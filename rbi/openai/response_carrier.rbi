# typed: strong

module OpenAI
  # Shared response metadata interface for SDK values that are not model
  # objects, such as binary StringIO responses.
  module ResponseCarrier
    sig { returns(T.nilable(String)) }
    def _request_id
    end

    sig { returns(T.nilable(OpenAI::ResponseMetadata)) }
    def last_response
    end

    # @api private
    sig { params(response: OpenAI::ResponseMetadata).returns(T.self_type) }
    def _set_last_response(response)
    end

    # @api private
    sig { params(coder: T.untyped).void }
    def encode_with(coder)
    end
  end
end
