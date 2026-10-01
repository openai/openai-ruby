# frozen_string_literal: true

require_relative "result"

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

          private

          def iterator
            @collector = ResultCollector.new
            source = super
            @iterator = OpenAI::Internal::Util.chain_fused(source) do |yielder|
              source.each do |event|
                @collector.observe(event)
                yielder << event
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
