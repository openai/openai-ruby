# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that is in progress.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.in_progress`.
        #
        #   @return [Symbol, :"response.in_progress"]
        required :type, const: :"response.in_progress"

        # @!method initialize(response:, type: :"response.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseInProgressEvent} for more details.
        #
        #   Emitted when the response is in progress.
        #
        #   @param response [OpenAI::Responses::Response] The response that is in progress.
        #
        #   @param type [Symbol, :"response.in_progress"] The type of the event. Always `response.in_progress`.
      end
    end
  end
end
