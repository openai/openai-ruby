# typed: strong

module OpenAI
  module Helpers
    module Streaming
      # @api private
      class ResponseEventDecoder
        sig { params(model: T.untyped).void }
        def initialize(model:)
        end

        sig { params(data: T.untyped).returns(T.untyped) }
        def decode(data)
        end

        private

        sig { returns(T::Boolean) }
        def response_stream_model?
        end

        sig { params(data: T.untyped).returns(T::Boolean) }
        def unknown_response_event?(data)
        end
      end
    end
  end
end
