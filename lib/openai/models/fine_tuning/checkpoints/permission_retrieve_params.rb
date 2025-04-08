# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#retrieve
        class PermissionRetrieveParams < OpenAI::Internal::Type::BaseModel
          # @!parse
          #   extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute [r] after
          #   Identifier for the last permission ID from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!parse
          #   # @return [String]
          #   attr_writer :after

          # @!attribute [r] limit
          #   Number of permissions to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :limit

          # @!attribute [r] order
          #   The order in which to retrieve permissions.
          #
          #   @return [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order, nil]
          optional :order, enum: -> { OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order]
          #   attr_writer :order

          # @!attribute [r] project_id
          #   The ID of the project to get permissions for.
          #
          #   @return [String, nil]
          optional :project_id, String

          # @!parse
          #   # @return [String]
          #   attr_writer :project_id

          # @!parse
          #   # @param after [String]
          #   # @param limit [Integer]
          #   # @param order [Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order]
          #   # @param project_id [String]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(after: nil, limit: nil, order: nil, project_id: nil, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # The order in which to retrieve permissions.
          module Order
            extend OpenAI::Internal::Type::Enum

            ASCENDING = :ascending
            DESCENDING = :descending

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end
      end
    end
  end
end
