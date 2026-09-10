# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Vaults#create
        class VaultCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute metadata
          #   Key-value pairs to associate with the vault, such as an application or team
          #   identifier.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute name
          #   The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
          #   trimming.
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(metadata: nil, name: nil, request_options: {})
          #   @param metadata [Hash{Symbol=>String}, nil]
          #     Key-value pairs to associate with the vault, such as an application or team
          #     identifier.
          #
          #   @param name [String]
          #     The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
          #     trimming.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
