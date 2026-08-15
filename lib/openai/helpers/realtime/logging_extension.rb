# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Raw-response observation for non-JSON Realtime endpoints.
      module LoggingExtension
        def observe_raw_response(response)
          return response unless enabled?(:error)

          OpenAI::HTTPClient::Response.new(
            status: response.status,
            headers: response.headers,
            body: OpenAI::Internal::Logging::ObservedEnumerable.new(
              enumerable: response.body,
              context: self,
              response: response,
              close: -> { OpenAI::Internal::Util.close_fused!(response.body) }
            )
          )
        end
      end
    end
  end

  module Internal
    module Logging
      # @api private
      class ObservedEnumerable
        include Enumerable

        def initialize(enumerable:, context:, response:, close:)
          @enumerable = enumerable
          @context = context
          @response = response
          @close = close
          @iterator = iterator
        end

        def each(&block) = @iterator.each(&block)
        def close = OpenAI::Internal::Util.close_fused!(@iterator)

        private def iterator
          source = @enumerable.to_enum
          observed = Enumerator.new do |yielder|
            loop do
              chunk =
                begin
                  source.next
                rescue StopIteration
                  @context.completed(@response)
                  break
                rescue StandardError => e
                  @context.request_failed(e)
                  raise
                end
              yielder << chunk
            end
          end
          OpenAI::Internal::Util.fused_enum(observed, &@close)
        end
      end
    end
  end
end

OpenAI::Internal::Logging::Context.include(OpenAI::Helpers::Realtime::LoggingExtension)
