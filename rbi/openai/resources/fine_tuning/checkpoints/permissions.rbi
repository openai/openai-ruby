# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Checkpoints
        class Permissions
          # **NOTE:** Calling this endpoint requires an [admin API key](../admin-api-keys).
          #
          # This enables organization owners to share fine-tuned models with other projects
          # in their organization.
          sig do
            params(
              fine_tuned_model_checkpoint: String,
              project_ids: T::Array[String],
              request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
            )
              .returns(OpenAI::Internal::Page[OpenAI::Models::FineTuning::Checkpoints::PermissionCreateResponse])
          end
          def create(
            # The ID of the fine-tuned model checkpoint to create a permission for.
            fine_tuned_model_checkpoint,
            # The project identifiers to grant access to.
            project_ids:,
            request_options: {}
          ); end
          # **NOTE:** This endpoint requires an [admin API key](../admin-api-keys).
          #
          # Organization owners can use this endpoint to view all permissions for a
          # fine-tuned model checkpoint.
          sig do
            params(
              fine_tuned_model_checkpoint: String,
              after: String,
              limit: Integer,
              order: OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::OrSymbol,
              project_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
            )
              .returns(OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse)
          end
          def retrieve(
            # The ID of the fine-tuned model checkpoint to get permissions for.
            fine_tuned_model_checkpoint,
            # Identifier for the last permission ID from the previous pagination request.
            after: nil,
            # Number of permissions to retrieve.
            limit: nil,
            # The order in which to retrieve permissions.
            order: nil,
            # The ID of the project to get permissions for.
            project_id: nil,
            request_options: {}
          ); end
          # **NOTE:** This endpoint requires an [admin API key](../admin-api-keys).
          #
          # Organization owners can use this endpoint to delete a permission for a
          # fine-tuned model checkpoint.
          sig do
            params(
              permission_id: String,
              fine_tuned_model_checkpoint: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
            )
              .returns(OpenAI::Models::FineTuning::Checkpoints::PermissionDeleteResponse)
          end
          def delete(
            # The ID of the fine-tuned model checkpoint permission to delete.
            permission_id,
            # The ID of the fine-tuned model checkpoint to delete a permission for.
            fine_tuned_model_checkpoint:,
            request_options: {}
          ); end
          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:); end
        end
      end
    end
  end
end
