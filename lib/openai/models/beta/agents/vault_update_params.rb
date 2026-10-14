# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Vaults#update
        class VaultUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute vault_id
          #
          #   @return [String]
          required :vault_id, String

          # @!attribute metadata
          #   Replaces all metadata. Omit to leave unchanged, or pass {} to clear it. Up to 16
          #   string key-value pairs, with keys up to 64 and values up to 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String]

          # @!attribute name
          #   A replacement name. Omit to leave unchanged, or pass null to clear it. The name
          #   is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after trimming.
          #
          #   @return [String, nil]
          optional :name, String, nil?: true

          # @!method initialize(vault_id:, metadata: nil, name: nil, request_options: {})
          #   @param vault_id [String]
          #
          #   @param metadata [Hash{Symbol=>String}]
          #     Replaces all metadata. Omit to leave unchanged, or pass {} to clear it. Up to 16
          #     string key-value pairs, with keys up to 64 and values up to 512 characters.
          #
          #   @param name [String, nil]
          #     A replacement name. Omit to leave unchanged, or pass null to clear it. The name
          #     is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after trimming.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
