# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Vaults#delete
        class VaultDeleted < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the deleted vault.
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #   Whether the resource was deleted. Always `true`.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   The object type. Always `vault.deleted`.
          #
          #   @return [Symbol, :"vault.deleted"]
          required :object, const: :"vault.deleted"

          # @!method initialize(id:, deleted:, object: :"vault.deleted")
          #   Confirmation that a vault was deleted.
          #
          #   @param id [String]
          #     The ID of the deleted vault.
          #
          #   @param deleted [Boolean]
          #     Whether the resource was deleted. Always `true`.
          #
          #   @param object [Symbol, :"vault.deleted"]
          #     The object type. Always `vault.deleted`.
        end
      end
    end
  end
end
