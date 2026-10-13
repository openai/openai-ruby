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
            #   Retrying resets the expiry relative to the new request.
            #
            #   @return [Integer]
            required :expires_in_seconds, Integer

            # @!method initialize(project_id:, api_key_id:, expires_in_seconds:, request_options: {})
            #   @param project_id [String]
            #
            #   @param api_key_id [String]
            #
            #   @param expires_in_seconds [Integer]
            #     Number of seconds from this request until the API key expires. Must comply with
            #     the organization and project expiry policies. Expired keys cannot be updated.
            #     Retrying resets the expiry relative to the new request.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
