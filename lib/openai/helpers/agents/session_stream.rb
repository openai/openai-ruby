# frozen_string_literal: true

require_relative "tools"
require_relative "../beta/agents/result"
require_relative "../beta/agents/attachment"

module OpenAI
  module Helpers
    module Agents
      # Submit input on an idle session, or omit input to attach to its active root turn.
      # When submitting input, the caller must be its only input writer
      # until iteration ends, because input submission does not return a turn ID.
      # Use a block or ensure #close when abandoning external iteration.
      # Closing the connection does not cancel the backend turn.
      class SessionStream
        include Enumerable

        # @api private
        def initialize(
          sessions:,
          session_id:,
          input: nil,
          tool_handlers: {},
          idempotency_key: nil,
          output_type: nil,
          request_options: {}
        )
          unless input.nil?
            unless input.is_a?(String) || input.respond_to?(:to_a)
              raise ArgumentError, "input must be text or a collection of messages"
            end

            messages = input.is_a?(String) ? [{role: :user, content: [{type: :input_text, text: input}]}] : input.to_a
            raise ArgumentError, "input must not be empty" if input == "" || messages.empty?
          end

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
          @handled_calls = {}
          @closed = false
          unless input.nil?
            session = @sessions.retrieve(@session_id, request_options: @options)
            raise ArgumentError, "sessions.stream with input requires an idle session" unless session.status == :idle
          else
            @attachment = OpenAI::Helpers::Beta::Agents::Attachment.new(
              sessions: @sessions,
              session_id: @session_id,
              request_options: @options
            )
          end

          @raw_stream = @sessions.events.stream_streaming(@session_id, request_options: @options)
          begin
            if @attachment
              @attachment.opened
              close if @attachment.settled?
            else
              @sessions.events.create(
                @session_id,
                events: [{type: :"agent.session.input.message", input: messages}],
                idempotency_key: input_key,
                request_options: @options
              )
            end

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

          if @attachment && !@reconciled && (@attachment.settled? || @collector.stopped? || @read_failure)
            begin
              @attachment.reconcile(@collector)
            rescue StandardError => error
              @collector.observe_recovery_error(error)
            ensure
              @reconciled = true
            end
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
          @collector.select_turn(@attachment.turn) if @attachment
          begin
            if @attachment && !@attachment_collected
              collect_attachment_actions
            end

          rescue StandardError => error
            @collector.observe_error(error)
            close
            @collector.result
          end

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
              source = @attachment ? read_events : @raw_stream
              source.each do |event|
                known = event.is_a?(OpenAI::Internal::Type::BaseModel)
                next if known && !accept?(event)

                @attachment.observe(event) if @attachment && known
                @collector.select_turn(@attachment.turn) if @attachment
                if @attachment_collected && @attachment.turn && @attachment_collected != @attachment.turn.id
                  collect_attachment_actions
                end

                current_root = !@attachment ||
                  !known ||
                  event.type != :"agent.session.requires_action" ||
                  @attachment.current_root?
                @collector.observe(event, current_root: current_root)
                unless known
                  yielder << event
                  next
                end

                terminal = if @attachment
                  @attachment.settled?
                else
                  event.type == :"agent.session.failed" || (event.type == :"agent.session.idle" && @turn_ended)
                end

                invocation = prepare_call(event) unless terminal
                close if terminal
                yielder << event
                break if terminal || @closed

                dispatch(invocation.call) if invocation
              end

              raise RuntimeError, "Session event stream ended before the turn reached idle or failed" unless @closed
            rescue StandardError => error
              unless @attachment && @read_failure && @attachment.recover_observation
                @collector.observe_error(error)
                raise
              end

            ensure
              close
            end
          end
        end

        def collect_attachment_actions
          @attachment_collected = @attachment.turn&.id || :no_turn
          @attachment.manual_actions.each { @collector.observe_pending_action(_1) }
          close if @attachment.settled?
        end

        def read_events
          Enumerator.new do |yielder|
            events = @raw_stream.to_enum
            loop do
              event = begin
                events.next
              rescue StopIteration
                @read_failure = true
                break
              rescue StandardError
                @read_failure = true
                raise
              end

              yielder << event
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
          unless event.type == :"agent.session.turn.item.added" &&
              event.item.is_a?(OpenAI::Models::Beta::AgentFunctionCallItem)
            return
          end

          call = event.item
          return if @attachment && call.turn_id != @attachment.turn&.id
          key = [call.turn_id.dup, call.call_id.dup]
          return if @handled_calls.key?(key)

          @handled_calls[key] = true
          handler = @handlers[call.name]
          unless handler
            if @attachment
              @collector.observe_pending_action(call)
            end

            return
          end

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
