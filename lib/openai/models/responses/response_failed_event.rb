# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that failed.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.failed`.
        #
        #   @return [Symbol, :"response.failed"]
        required :type, const: :"response.failed"

        # @!method initialize(response:, type: :"response.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseFailedEvent} for more details.
        #
        #   An event that is emitted when a response fails.
        #
        #   @param response [OpenAI::Responses::Response] The response that failed.
        #
        #   @param type [Symbol, :"response.failed"] The type of the event. Always `response.failed`.
      end
    end
  end
end
