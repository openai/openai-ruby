# frozen_string_literal: true

require_relative "../../agents/tools"

module OpenAI
  module Helpers
    module Beta
      module Agents
        # @api private
        # Shared callback preparation, deduplication, and tool-result submission.
        class ToolDispatcher
          def initialize(sessions:, tool_handlers:, request_options:, session_id: nil)
            @sessions = sessions
            @session_id = session_id
            @handlers = tool_handlers.to_h.dup
            @handled_calls = {}
            @options = request_options.to_h.dup
            @options.delete(:idempotency_key)
            headers = {"OpenAI-Beta" => "agents=v1"}.merge(@options[:extra_headers].to_h)
            @options[:extra_headers] = headers.reject do |key, _|
              key.to_s.casecmp?("idempotency-key")
            end
          end

          def handler_names = @handlers.keys

          def observe(event)
            @session_id ||= event.session.id.dup if event.type == :"agent.session.created"
          end

          def prepare_call(event)
            unless event.type == :"agent.session.turn.item.added" &&
                event.item.is_a?(OpenAI::Models::Beta::AgentFunctionCallItem)
              return
            end

            call = event.item
            key = [call.turn_id.dup, call.call_id.dup]
            return if @handled_calls.key?(key)

            @handled_calls[key] = true
            handler = @handlers[call.name]
            return unless handler
            raise RuntimeError, "Creation stream did not identify a session" unless @session_id

            OpenAI::Helpers::Agents::Tools.prepare(call, handler)
          end

          def dispatch(result)
            idempotency_key = SecureRandom.uuid
            delays = [0.1, 0.3, 0.6]
            begin
              @sessions
                .events
                .create(@session_id, events: [result], idempotency_key: idempotency_key, request_options: @options)
            rescue OpenAI::Errors::BadRequestError => error
              delay = delays.shift
              raise unless delay && OpenAI::Helpers::Agents::Tools.pending_call_race?(error, result[:call_id])

              sleep(delay)
              retry
            end
          end
        end
      end
    end
  end
end
