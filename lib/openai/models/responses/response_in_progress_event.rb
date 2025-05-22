# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that is in progress.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.in_progress`.
        #
        #   @return [Symbol, :"response.in_progress"]
        required :type, const: :"response.in_progress"

        # @!method initialize(response:, sequence_number:, type: :"response.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseInProgressEvent} for more details.
        #
        #   Emitted when the response is in progress.
        #
        #   @param response [OpenAI::Models::Responses::Response] The response that is in progress.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.in_progress"] The type of the event. Always `response.in_progress`.
      end
    end
  end
end
