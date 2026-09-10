# frozen_string_literal: true

require_relative "tools"

module OpenAI
  module Helpers
    module Agents
      # Stream one turn on an idle session. The caller must be its only input writer
      # until iteration ends, because input submission does not return a turn ID.
      # Use a block or ensure #close when abandoning external iteration.
      # Closing the connection does not cancel the backend turn.
      class SessionStream
        include Enumerable

        # @api private
        def initialize(sessions:, session_id:, input:, tool_handlers: {}, idempotency_key: nil, request_options: {})
          messages = input.is_a?(String) ? [{role: :user, content: [{type: :input_text, text: input}]}] : input.to_a
          raise ArgumentError, "input must not be empty" if input == "" || messages.empty?

          @sessions = sessions
          @session_id = session_id
          @handlers = tool_handlers.to_h.dup
          @options = request_options.to_h.dup
          headers = {"OpenAI-Beta" => "agents=v1"}.merge(@options[:extra_headers].to_h)
          options_key = @options.delete(:idempotency_key)
          input_key = idempotency_key || options_key || SecureRandom.uuid
          headers.delete_if do |key, value|
            match = key.to_s.casecmp?("idempotency-key")
            input_key = value if match
            match
          end

          @options[:extra_headers] = headers
          @recent_events = {}
          @handled_calls = {}
          @closed = false
          session = @sessions.retrieve(@session_id, request_options: @options)
          unless session.status == :idle
            raise(
              ArgumentError,
              "sessions.stream requires an idle session; use sessions.events.stream_streaming to follow an active session"
            )
          end

          @raw_stream = @sessions.events.stream_streaming(@session_id, request_options: @options)
          begin
            @sessions.events.create(
              @session_id,
              events: [{type: :"agent.session.input.message", input: messages}],
              idempotency_key: input_key,
              request_options: @options
            )
            @iterator = iterator
            submitted = true
          ensure
            close unless submitted
          end
        end

        # Yields the original typed events. Registered handlers run sequentially after
        # their function-call event is yielded; unknown tools remain caller-managed.
        # @yieldparam event [OpenAI::Models::Beta::AgentSessionEvent]
        # @return [Enumerator, self]
        def each
          return enum_for(:each) unless block_given?
          return self if @closed
          begin
            loop do
              break if @closed
              yield @iterator.next
            end

          ensure
            close
          end

          self
        end

        # Consume remaining events and registered tool calls.
        # @return [self]
        def until_done
          each { |_event| nil }
          self
        end

        # Close the event connection without cancelling the backend turn.
        # @return [void]
        def close
          return if @closed

          @closed = true
          @raw_stream&.close
        end

        private

        def iterator
          Enumerator.new do |yielder|
            begin
              @raw_stream.each do |event|
                next unless accept?(event)

                terminal = event.type == :"agent.session.failed" ||
                  (event.type == :"agent.session.idle" && @turn_ended)
                invocation = prepare_call(event) unless terminal
                close if terminal
                yielder << event
                break if terminal || @closed

                dispatch(invocation.call) if invocation
              end

              raise RuntimeError, "Session event stream ended before the turn reached idle or failed" unless @closed
            ensure
              close
            end
          end
        end

        def accept?(event)
          return false if @recent_events.key?(event.event_id)

          @recent_events.shift if @recent_events.size == 1024
          @recent_events[event.event_id] = true
          case event.type
          when :"agent.session.turn.created"
            @turn_id ||= event.turn_id.dup if event.turn.subagent_id.nil?
          when :"agent.session.turn.completed", :"agent.session.turn.failed", :"agent.session.turn.cancelled"
            @turn_ended = true if @turn_id && event.turn_id == @turn_id
          end

          true
        end

        def prepare_call(event)
          return unless event.type == :"agent.session.turn.item.added" && event.item.type == :function_call

          call = event.item
          key = [call.turn_id.dup, call.call_id.dup]
          return if @handled_calls.key?(key)

          @handled_calls[key] = true
          handler = @handlers[call.name]
          return unless handler

          Tools.prepare(call, handler)
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
            raise unless delay && Tools.pending_call_race?(error, result[:call_id])

            sleep(delay)
            retry
          end
        end
      end
    end
  end
end
