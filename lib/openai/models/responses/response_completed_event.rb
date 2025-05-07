# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   Properties of the completed response.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.completed`.
        #
        #   @return [Symbol, :"response.completed"]
        required :type, const: :"response.completed"

        # @!method initialize(response:, type: :"response.completed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseCompletedEvent} for more details.
        #
        #   Emitted when the model response is complete.
        #
        #   @param response [OpenAI::Responses::Response] Properties of the completed response.
        #
        #   @param type [Symbol, :"response.completed"] The type of the event. Always `response.completed`.
      end
    end
  end
end
