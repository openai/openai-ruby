# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInProgressEvent < OpenAI::BaseModel
        # @!attribute response
        #   The response that is in progress.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Models::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.in_progress`.
        #
        #   @return [Symbol, :"response.in_progress"]
        required :type, const: :"response.in_progress"

        # @!parse
        #   # Emitted when the response is in progress.
        #   #
        #   # @param response [OpenAI::Models::Responses::Response]
        #   # @param type [Symbol, :"response.in_progress"]
        #   #
        #   def initialize(response:, type: :"response.in_progress", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
