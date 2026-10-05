# frozen_string_literal: true

require_relative "../beta/agents/tool_dispatcher"
require_relative "../beta/agents/result"

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
        def initialize(
          sessions:,
          session_id:,
          input:,
          tool_handlers: {},
          idempotency_key: nil,
          output_type: nil,
          request_options: {}
        )
          messages = input.is_a?(String) ? [{role: :user, content: [{type: :input_text, text: input}]}] : input.to_a
          raise ArgumentError, "input must not be empty" if input == "" || messages.empty?

          @output_parser = OpenAI::Helpers::Beta::Agents::OutputParser.new(output_type) unless output_type.nil?
          @sessions = sessions
          @session_id = session_id
          @handlers = tool_handlers.to_h.dup
          @collector = OpenAI::Helpers::Beta::Agents::ResultCollector.new(
            session_id: session_id,
            handler_names: @handlers.keys
          )
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
          @dispatcher = OpenAI::Helpers::Beta::Agents::ToolDispatcher.new(
            sessions: sessions,
            session_id: session_id,
            tool_handlers: @handlers,
            request_options: @options
          )
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

        # @beta
        # Consume the remaining events and handlers, then return this turn's final
        # answer. Failed, blocked, or incomplete observation raises ResultError.
        # @return [OpenAI::Helpers::Beta::Agents::TurnResult]
        def get_final_result
          with_result_collection
          raise @result_error if @result_error
          begin
            each { |_event| break if @collector.stopped? } unless @collector.stopped?
          rescue StandardError => error
            @collector.observe_error(error)
          end

          result = @collector.result
          @output_parser ? @output_parser.parse(result) : result
        rescue OpenAI::Helpers::Beta::Agents::ResultError => error
          @result_error = error
          raise
        ensure
          close
        end

        # @beta
        # Enable result collection before iterating to display progress.
        # @return [self]
        def with_result_collection
          @collector.enable
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
                known = event.is_a?(OpenAI::Internal::Type::BaseModel)
                next if known && !accept?(event)

                @collector.observe(event)
                unless known
                  yielder << event
                  next
                end

                terminal = event.type == :"agent.session.failed" ||
                  (event.type == :"agent.session.idle" && @turn_ended)
                invocation = @dispatcher.prepare_call(event) unless terminal
                close if terminal
                yielder << event
                break if terminal || @closed

                @dispatcher.dispatch(invocation.call) if invocation
              end

              raise RuntimeError, "Session event stream ended before the turn reached idle or failed" unless @closed
            rescue StandardError => error
              @collector.observe_error(error)
              raise
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

      end
    end
  end
end
