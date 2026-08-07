# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseContainerReference < OpenAI::Internal::Type::BaseModel
        # @!attribute container_id
        #
        #   @return [String]
        required :container_id, String

        # @!attribute type
        #   The environment type. Always `container_reference`.
        #
        #   @return [Symbol, :container_reference]
        required :type, const: :container_reference

        # @!method initialize(container_id:, type: :container_reference)
        #   Represents a container created with /v1/containers.
        #
        #   @param container_id [String]
        #
        #   @param type [Symbol, :container_reference] The environment type. Always `container_reference`.
      end
    end
  end
end
