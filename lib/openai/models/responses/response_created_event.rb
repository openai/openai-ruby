# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was created.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Models::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.created`.
        #
        #   @return [Symbol, :"response.created"]
        required :type, const: :"response.created"

        # @!parse
        #   # An event that is emitted when a response is created.
        #   #
        #   # @param response [OpenAI::Models::Responses::Response]
        #   # @param type [Symbol, :"response.created"]
        #   #
        #   def initialize(response:, type: :"response.created", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
