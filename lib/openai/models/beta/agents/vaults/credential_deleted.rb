# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Vaults
          # @see OpenAI::Resources::Beta::Agents::Vaults::Credentials#delete
          class CredentialDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the deleted credential.
            #
            #   @return [String]
            required :id, String

            # @!attribute deleted
            #   Whether the resource was deleted. Always `true`.
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #   The object type. Always `vault.credential.deleted`.
            #
            #   @return [Symbol, :"vault.credential.deleted"]
            required :object, const: :"vault.credential.deleted"

            # @!method initialize(id:, deleted:, object: :"vault.credential.deleted")
            #   Confirmation that a vault credential was deleted.
            #
            #   @param id [String]
            #     The ID of the deleted credential.
            #
            #   @param deleted [Boolean]
            #     Whether the resource was deleted. Always `true`.
            #
            #   @param object [Symbol, :"vault.credential.deleted"]
            #     The object type. Always `vault.credential.deleted`.
          end
        end
      end
    end
  end
end
