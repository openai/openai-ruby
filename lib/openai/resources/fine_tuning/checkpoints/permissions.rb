# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Checkpoints
        class Permissions
          # **NOTE:** Calling this endpoint requires an [admin API key](../admin-api-keys).
          #
          # This enables organization owners to share fine-tuned models with other projects
          # in their organization.
          #
          # @overload create(fine_tuned_model_checkpoint, project_ids:, request_options: {})
          #
          # @param fine_tuned_model_checkpoint [String]
          # @param project_ids [Array<String>]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Page<OpenAI::Models::FineTuning::Checkpoints::PermissionCreateResponse>]
          #
          # @see OpenAI::Models::FineTuning::Checkpoints::PermissionCreateParams
          def create(fine_tuned_model_checkpoint, params)
            parsed, options = OpenAI::Models::FineTuning::Checkpoints::PermissionCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["fine_tuning/checkpoints/%1$s/permissions", fine_tuned_model_checkpoint],
              body: parsed,
              page: OpenAI::Internal::Page,
              model: OpenAI::Models::FineTuning::Checkpoints::PermissionCreateResponse,
              options: options
            )
          end

          # **NOTE:** This endpoint requires an [admin API key](../admin-api-keys).
          #
          # Organization owners can use this endpoint to view all permissions for a
          # fine-tuned model checkpoint.
          #
          # @overload retrieve(fine_tuned_model_checkpoint, after: nil, limit: nil, order: nil, project_id: nil, request_options: {})
          #
          # @param fine_tuned_model_checkpoint [String]
          # @param after [String]
          # @param limit [Integer]
          # @param order [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order]
          # @param project_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse]
          #
          # @see OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams
          def retrieve(fine_tuned_model_checkpoint, params = {})
            parsed, options = OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["fine_tuning/checkpoints/%1$s/permissions", fine_tuned_model_checkpoint],
              query: parsed,
              model: OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse,
              options: options
            )
          end

          # **NOTE:** This endpoint requires an [admin API key](../admin-api-keys).
          #
          # Organization owners can use this endpoint to delete a permission for a
          # fine-tuned model checkpoint.
          #
          # @overload delete(permission_id, fine_tuned_model_checkpoint:, request_options: {})
          #
          # @param permission_id [String]
          # @param fine_tuned_model_checkpoint [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::FineTuning::Checkpoints::PermissionDeleteResponse]
          #
          # @see OpenAI::Models::FineTuning::Checkpoints::PermissionDeleteParams
          def delete(permission_id, params)
            parsed, options = OpenAI::Models::FineTuning::Checkpoints::PermissionDeleteParams.dump_request(params)
            fine_tuned_model_checkpoint =
              parsed.delete(:fine_tuned_model_checkpoint) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :delete,
              path: [
                "fine_tuning/checkpoints/%1$s/permissions/%2$s",
                fine_tuned_model_checkpoint,
                permission_id
              ],
              model: OpenAI::Models::FineTuning::Checkpoints::PermissionDeleteResponse,
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
