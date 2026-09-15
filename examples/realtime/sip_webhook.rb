#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "openssl"
require "timeout"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      # A single-tenant, single-process worker. See SIP.md before deploying.
      class SIPWebhook
        class Unauthorized < StandardError
        end

        def initialize(
          client:,
          tenant:,
          application_token:,
          webhook_secret:,
          model:,
          accepting: true,
          call_seconds: 60,
          transport: nil
        )
          [tenant, application_token, webhook_secret, model].each do |value|
            raise ArgumentError, "Nonempty configuration required" unless value.is_a?(String) && !value.strip.empty?
          end

          unless call_seconds.is_a?(Numeric) && call_seconds.finite? && call_seconds.positive?
            raise ArgumentError, "Positive finite call deadline required"
          end

          raise ArgumentError, "Boolean admission policy required" unless [true, false].include?(accepting)

          @client = client
          @tenant = tenant.dup.freeze
          @application_token = application_token.dup.freeze
          @webhook_secret = webhook_secret.dup.freeze
          @model = model
          @accepting = accepting
          @call_seconds = call_seconds
          @transport = transport
          @mutex = Mutex.new
          @events = {}
          @calls = {}
        end

        # The application token belongs to a trusted gateway, never a SIP caller.
        # The gateway preserves the raw body and signature headers unchanged.
        def handle(envelope)
          authenticate!(envelope)
          event = @client.webhooks.unwrap(envelope.fetch("body"), envelope.fetch("headers"), @webhook_secret)
          return :ignored unless event.is_a?(OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent)

          data = event.data
          unless event.id.is_a?(String) &&
              !event.id.empty? &&
              data.is_a?(OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data) &&
              data.call_id.is_a?(String) &&
              /\Artc_[A-Za-z0-9_-]+\z/.match?(data.call_id)
            raise ArgumentError, "Invalid incoming call event"
          end

          # No envelope field or SIP header can choose credentials, tenant, or call ID.
          call_id = data.call_id
          return :duplicate unless claim(event.id, call_id)
          return reject(call_id) unless @accepting

          answer(call_id)
        end

        # Local diagnostic state only; contains no durable ownership guarantee.
        def state(call_id)
          @mutex.synchronize { @calls[call_id] }
        end

        private def authenticate!(envelope)
          token = envelope.fetch("application_token")
          unless token.is_a?(String) &&
              OpenSSL.secure_compare(@application_token, token) &&
              envelope.fetch("tenant") == @tenant
            raise Unauthorized, "Application is not authorized for this tenant"
          end
        end

        private def claim(event_id, call_id)
          @mutex.synchronize do
            return false if @events.key?(event_id) || @calls.key?(call_id)

            @events[event_id] = true
            @calls[call_id] = :claimed
            true
          end
        end

        private def record(call_id, state)
          @mutex.synchronize { @calls[call_id] = state }
        end

        private def reject(call_id)
          record(call_id, :reject_unknown)
          @client.realtime.calls.reject(call_id, status_code: 486, request_options: {max_retries: 0, timeout: 5})
          record(call_id, :rejected)
        end

        private def answer(call_id)
          owned = false
          completed = false
          # A lost accept response does not prove ownership. Never retry it or hang
          # up a potentially competing Realtime/Live handler's call.
          record(call_id, :accept_unknown)
          begin
            @client.realtime.calls.accept(
              call_id,
              type: :realtime,
              model: @model,
              instructions: "You are a helpful phone assistant. Keep answers brief. Do not request sensitive information.",
              tools: [],
              request_options: {max_retries: 0, timeout: 5}
            )
          rescue OpenAI::Errors::ConflictError
            return record(call_id, :other_owner)
          end

          owned = true
          record(call_id, :owned)

          Timeout.timeout(@call_seconds) do
            @client.realtime.connect_to_call(call_id: call_id, transport: @transport) do |connection|
              connection.each do |event|
                if event.is_a?(OpenAI::Realtime::RealtimeErrorEvent)
                  raise "Realtime sideband reported an error"
                end
                # response.done and output_audio_buffer.stopped finish a turn,
                # not the call. Keep observing until EOF, error, or our deadline.
              end
            end
          end

          completed = true
          :sideband_closed
        ensure
          # A caller may already be rescuing an unrelated exception in $!.
          cleanup(call_id, completed ? nil : $!) if owned
        end

        private def cleanup(call_id, primary_error)
          cleanup = lambda do
            Timeout.timeout(5) do
              @client.realtime.calls.hangup(call_id, request_options: {max_retries: 0, timeout: 5})
            end
          end

          task = Async::Task.current? if defined?(Async::Task)
          if task
            if task.respond_to?(:defer_cancel)
              task.defer_cancel(&cleanup)
            else
              task.defer_stop(&cleanup)
            end
          else
            cleanup.call
          end

          record(call_id, :hangup_confirmed)
        rescue StandardError, *(defined?(Async::Stop) ? [Async::Stop] : [])
          # A peer may already have ended the call. Do not assume every 404/409
          # means that: retain an unresolved cleanup state and never replay accept.
          record(call_id, :cleanup_unconfirmed)
          raise if primary_error.nil?
        end

        def self.run(worker:, input: $stdin, output: $stdout)
          input.each_line do |line|
            begin
              result = worker.handle(JSON.parse(line))
              output.puts(JSON.generate(status: result))
            rescue StandardError
              # SDK exceptions can contain request/response data. Never print them.
              output.puts(JSON.generate(status: :failed))
            end

            output.flush
          end
        end
      end
    end
  end

end

if $PROGRAM_NAME == __FILE__
  begin
    policy = ENV.fetch("SIP_ACCEPT_CALLS", "false")
    raise ArgumentError, "Invalid admission policy" unless %w[true false].include?(policy)

    worker = OpenAI::Examples::Realtime::SIPWebhook.new(
      client: OpenAI::Client.new(api_key: ENV.fetch("OPENAI_API_KEY"), project: ENV.fetch("OPENAI_PROJECT_ID")),
      tenant: ENV.fetch("SIP_TENANT"),
      application_token: ENV.fetch("SIP_APPLICATION_TOKEN"),
      webhook_secret: ENV.fetch("OPENAI_WEBHOOK_SECRET"),
      model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
      accepting: policy == "true",
      call_seconds: Float(ENV.fetch("SIP_CALL_SECONDS", "60"))
    )
    OpenAI::Examples::Realtime::SIPWebhook.run(worker: worker)
  rescue StandardError
    warn("SIP worker failed; details omitted to protect credentials and call data.")
    exit(1)
  end
end
