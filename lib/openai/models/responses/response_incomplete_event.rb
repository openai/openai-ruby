# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseIncompleteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was incomplete.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.incomplete`.
        #
        #   @return [Symbol, :"response.incomplete"]
        required :type, const: :"response.incomplete"

        # @!method initialize(response:, type: :"response.incomplete")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseIncompleteEvent} for more details.
        #
        #   An event that is emitted when a response finishes as incomplete.
        #
        #   @param response [OpenAI::Responses::Response] The response that was incomplete.
        #
        #   @param type [Symbol, :"response.incomplete"] The type of the event. Always `response.incomplete`.
      end
    end
  end
end
