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
            raise @result_error if @result_error
            begin
              until_done
            rescue StandardError => error
              @collector.observe_error(error)
            end

            @collector.result
          rescue ResultError => error
            @result_error = error
            raise
          ensure
            close
          end

          # Consume through this turn's boundary without requiring a successful result.
          # @return [self]
          def until_done
            begin
              @iterator.next until @collector.stopped?
            rescue StopIteration
              # The result getter distinguishes EOF from a complete result.
            end

            self
          ensure
            close
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
