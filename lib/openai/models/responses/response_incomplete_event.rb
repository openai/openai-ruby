# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseIncompleteEvent < OpenAI::BaseModel
        # @!attribute response
        #   The response that was incomplete.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Models::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.incomplete`.
        #
        #   @return [Symbol, :"response.incomplete"]
        required :type, const: :"response.incomplete"

        # @!parse
        #   # An event that is emitted when a response finishes as incomplete.
        #   #
        #   # @param response [OpenAI::Models::Responses::Response]
        #   # @param type [Symbol, :"response.incomplete"]
        #   #
        #   def initialize(response:, type: :"response.incomplete", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
