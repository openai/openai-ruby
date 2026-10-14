# frozen_string_literal: true

module OpenAI
  # Shared response metadata interface for SDK values that are not model
  # objects, such as binary StringIO responses.
  module ResponseCarrier
    # The ID of the API request, returned via the x-request-id response
    # header. This is only populated on top-level response objects returned
    # by the client.
    #
    # @api public
    #
    # @return [String, nil]
    def _request_id = last_response&.request_id

    # Metadata from the HTTP response that produced this value.
    #
    # @api public
    #
    # @return [OpenAI::ResponseMetadata, nil]
    attr_reader :last_response

    # @api private
    #
    # @param response [OpenAI::ResponseMetadata]
    # @return [self]
    def _set_last_response(response)
      @last_response = response
      self
    end

    # Keep transport metadata outside Psych's object serialization path.
    #
    # @api private
    #
    # @param _coder [Psych::Coder]
    # @return [void]
    def encode_with(_coder)
      nil
    end
  end
end
