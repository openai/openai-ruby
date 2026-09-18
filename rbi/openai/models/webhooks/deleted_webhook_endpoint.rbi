# typed: strong

module OpenAI
  module Models

    module Webhooks

      class DeletedWebhookEndpoint < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::DeletedWebhookEndpoint,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the deleted webhook endpoint.
        sig { returns(String) }
        attr_accessor :id

        # Whether the endpoint was deleted.
        sig { returns(T::Boolean) }
        attr_accessor :deleted

        # The object type, which is always webhook_endpoint.deleted.
        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(

            id: String,

            deleted: T::Boolean,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the deleted webhook endpoint.
          id:,

          # Whether the endpoint was deleted.
          deleted:,

          # The object type, which is always webhook_endpoint.deleted.

          object: :"webhook_endpoint.deleted"
        )
        end

        sig do
          override.returns(
            {id: String, deleted: T::Boolean, object: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
