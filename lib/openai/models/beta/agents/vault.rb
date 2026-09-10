# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Vaults#create
        class Vault < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the vault.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The Unix timestamp, in seconds, when the vault was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute metadata
          #   Key-value pairs associated with the vault, such as an application or team
          #   identifier.
          #
          #   @return [Hash{Symbol=>String}]
          required :metadata, OpenAI::Internal::Type::HashOf[String]

          # @!attribute name
          #   The human-readable name of the vault, if set.
          #
          #   @return [String, nil]
          required :name, String, nil?: true

          # @!attribute object
          #   The object type. Always `vault`.
          #
          #   @return [Symbol, :vault]
          required :object, const: :vault

          # @!method initialize(id:, created_at:, metadata:, name:, object: :vault)
          #   A collection of credentials that agent tools can use to authenticate to MCP
          #   servers.
          #
          #   @param id [String]
          #     The ID of the vault.
          #
          #   @param created_at [Integer]
          #     The Unix timestamp, in seconds, when the vault was created.
          #
          #   @param metadata [Hash{Symbol=>String}]
          #     Key-value pairs associated with the vault, such as an application or team
          #     identifier.
          #
          #   @param name [String, nil]
          #     The human-readable name of the vault, if set.
          #
          #   @param object [Symbol, :vault]
          #     The object type. Always `vault`.
        end
      end
    end
  end
end
