# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#create
        class AdminAPIKeyCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute name
          #
          #   @return [String]
          required :name, String

          # @!attribute expires_in_seconds
          #   The number of seconds until the API key expires. Omit this field for a key that
          #   does not expire.
          #
          #   @return [Integer, nil]
          optional :expires_in_seconds, Integer

          # @!method initialize(name:, expires_in_seconds: nil, request_options: {})
          #   @param name [String]
          #
          #   @param expires_in_seconds [Integer]
          #     The number of seconds until the API key expires. Omit this field for a key that
          #     does not expire.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
