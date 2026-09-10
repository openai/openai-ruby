# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Sessions#update
        class SessionUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute session_id
          #
          #   @return [String]
          required :session_id, String

          # @!attribute metadata
          #   Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          #   Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #   characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!method initialize(session_id:, metadata: nil, request_options: {})
          #   @param session_id [String]
          #
          #   @param metadata [Hash{Symbol=>String}, nil]
          #     Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          #     Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          #     characters.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
