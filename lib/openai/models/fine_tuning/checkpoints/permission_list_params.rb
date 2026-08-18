# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#list
        class PermissionListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute fine_tuned_model_checkpoint
          #
          #   @return [String]
          required :fine_tuned_model_checkpoint, String

          # @!attribute after
          #   Identifier for the last permission ID from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   Number of permissions to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   The order in which to retrieve permissions.
          #
          #   @return [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionListParams::Order, nil]
          optional :order, enum: -> { OpenAI::FineTuning::Checkpoints::PermissionListParams::Order }

          # @!attribute project_id
          #   The ID of the project to get permissions for.
          #
          #   @return [String, nil]
          optional :project_id, String

          # @!method initialize(fine_tuned_model_checkpoint:, after: nil, limit: nil, order: nil, project_id: nil, request_options: {})
          #   @param fine_tuned_model_checkpoint [String]
          #
          #   @param after [String] Identifier for the last permission ID from the previous pagination request.
          #
          #   @param limit [Integer] Number of permissions to retrieve.
          #
          #   @param order [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionListParams::Order] The order in which to retrieve permissions.
          #
          #   @param project_id [String] The ID of the project to get permissions for.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # The order in which to retrieve permissions.
          module Order
            extend OpenAI::Internal::Type::Enum

            ASCENDING = :ascending
            DESCENDING = :descending

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
