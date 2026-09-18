# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#delete
      class DeletedWebhookEndpoint < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the deleted webhook endpoint.
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #   Whether the endpoint was deleted.
        #
        #   @return [Boolean]
        required :deleted, OpenAI::Internal::Type::Boolean

        # @!attribute object
        #   The object type, which is always webhook_endpoint.deleted.
        #
        #   @return [Symbol, :"webhook_endpoint.deleted"]
        required :object, const: :"webhook_endpoint.deleted"

        # @!method initialize(id:, deleted:, object: :"webhook_endpoint.deleted")
        #   @param id [String]
        #     The ID of the deleted webhook endpoint.
        #
        #   @param deleted [Boolean]
        #     Whether the endpoint was deleted.
        #
        #   @param object [Symbol, :"webhook_endpoint.deleted"]
        #     The object type, which is always webhook_endpoint.deleted.
      end
    end
  end
end
