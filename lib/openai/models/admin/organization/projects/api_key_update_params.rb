# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::APIKeys#update
          class APIKeyUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute api_key_id
            #
            #   @return [String]
            required :api_key_id, String

            # @!attribute expires_in_seconds
            #   Number of seconds from this request until the API key expires. Must comply with
            #   the organization and project expiry policies. Expired keys cannot be updated.
            #   Retrying resets the expiry relative to the new request. Omit to keep the current
            #   expiration.
            #
            #   @return [Integer, nil]
            optional :expires_in_seconds, Integer

            # @!attribute scopes
            #   Replace the API key scope restrictions. Omit to leave scopes unchanged. An empty
            #   array removes key restrictions (All permissions), subject to the owner's
            #   effective permissions. Use ["api.all.read"] for read-only access. Scopes do not
            #   change the owner's roles or grant administrative permissions.
            #
            #   @return [Array<String>, nil]
            optional :scopes, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(project_id:, api_key_id:, expires_in_seconds: nil, scopes: nil, request_options: {})
            #   @param project_id [String]
            #
            #   @param api_key_id [String]
            #
            #   @param expires_in_seconds [Integer]
            #     Number of seconds from this request until the API key expires. Must comply with
            #     the organization and project expiry policies. Expired keys cannot be updated.
            #     Retrying resets the expiry relative to the new request. Omit to keep the current
            #     expiration.
            #
            #   @param scopes [Array<String>]
            #     Replace the API key scope restrictions. Omit to leave scopes unchanged. An empty
            #     array removes key restrictions (All permissions), subject to the owner's
            #     effective permissions. Use ["api.all.read"] for read-only access. Scopes do not
            #     change the owner's roles or grant administrative permissions.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
