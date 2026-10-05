# frozen_string_literal: true

require_relative "result"
require_relative "tool_dispatcher"

module OpenAI
  module Helpers
    module Beta
      module Agents
        # A typed creation event stream with beta turn-result collection.
        # Existing event iteration and HTTP metadata access remain available.
        class CreationStream < OpenAI::Internal::Stream
          # Requires initial input in create_streaming.
          # Consume events through the initial root turn's terminal/idle boundary.
          # Calling this again returns the same result without making requests.
          # @return [OpenAI::Helpers::Beta::Agents::TurnResult]
          def get_final_result
            with_result_collection
            raise @result_error if @result_error
            begin
              @iterator.next until @collector.stopped?
            rescue StopIteration
              # EOF alone does not establish a completed turn.
            rescue StandardError => error
              @collector.observe_error(error)
            end

            result = @collector.result
            @output_parser ? @output_parser.parse(result) : result
          rescue ResultError => error
            @result_error = error
            raise
          ensure
            close
          end

          # Enable result collection before iterating to display progress.
          # @return [self]
          def with_result_collection
            @collector.enable
            self
          end

          # @api private
          def configure_output_parser(parser)
            @output_parser = parser
            self
          end

          # @api private
          def configure_tool_handlers(sessions:, tool_handlers:, request_options:)
            @dispatcher = ToolDispatcher.new(
              sessions: sessions,
              tool_handlers: tool_handlers,
              request_options: request_options
            )
            @collector = ResultCollector.new(handler_names: @dispatcher.handler_names)
            self
          end

          def close
            @closed = true
            super
          end

          private

          def iterator
            @collector = ResultCollector.new
            source = super
            @iterator = OpenAI::Internal::Util.chain_fused(source) do |yielder|
              source.each do |event|
                invocation = nil
                if @dispatcher && event.is_a?(OpenAI::Internal::Type::BaseModel)
                  @dispatcher.observe(event)
                  invocation = @dispatcher.prepare_call(event)
                end

                @collector.observe(event)
                yielder << event
                break if @closed

                @dispatcher.dispatch(invocation.call) if invocation
              end

            rescue StandardError => error
              @collector.observe_error(error)
              raise
            end
          end
        end
      end
    end
  end
end
