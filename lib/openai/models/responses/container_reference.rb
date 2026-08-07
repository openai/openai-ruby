# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ContainerReference < OpenAI::Internal::Type::BaseModel
        # @!attribute container_id
        #   The ID of the referenced container.
        #
        #   @return [String]
        required :container_id, String

        # @!attribute type
        #   References a container created with the /v1/containers endpoint
        #
        #   @return [Symbol, :container_reference]
        required :type, const: :container_reference

        # @!method initialize(container_id:, type: :container_reference)
        #   @param container_id [String] The ID of the referenced container.
        #
        #   @param type [Symbol, :container_reference] References a container created with the /v1/containers endpoint
      end
    end
  end
end
