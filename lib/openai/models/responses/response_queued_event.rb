# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseQueuedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The full response object that is queued.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute type
        #   The type of the event. Always 'response.queued'.
        #
        #   @return [Symbol, :"response.queued"]
        required :type, const: :"response.queued"

        # @!method initialize(response:, type: :"response.queued")
        #   Emitted when a response is queued and waiting to be processed.
        #
        #   @param response [OpenAI::Responses::Response] The full response object that is queued.
        #
        #   @param type [Symbol, :"response.queued"] The type of the event. Always 'response.queued'.
      end
    end
  end
end
