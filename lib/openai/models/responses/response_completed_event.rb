# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   Properties of the completed response.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Models::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.completed`.
        #
        #   @return [Symbol, :"response.completed"]
        required :type, const: :"response.completed"

        # @!method initialize(response:, type: :"response.completed")
        #   Emitted when the model response is complete.
        #
        #   @param response [OpenAI::Models::Responses::Response]
        #   @param type [Symbol, :"response.completed"]
      end
    end
  end
end
