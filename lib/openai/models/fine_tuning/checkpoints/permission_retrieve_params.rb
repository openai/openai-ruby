# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#retrieve
        class PermissionRetrieveParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

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
          #   @return [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order, nil]
          optional :order, enum: -> { OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order }

          # @!attribute project_id
          #   The ID of the project to get permissions for.
          #
          #   @return [String, nil]
          optional :project_id, String

          # @!method initialize(after: nil, limit: nil, order: nil, project_id: nil, request_options: {})
          #   @param after [String]
          #   @param limit [Integer]
          #   @param order [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order]
          #   @param project_id [String]
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
