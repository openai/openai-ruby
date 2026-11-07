# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Environments
          # @see OpenAI::Resources::Beta::Agents::Environments::Files#create
          class FileCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute environment_id
            #
            #   @return [String]
            required :environment_id, String

            # @!attribute hosted_environment_file_param
            #   A file materialized in an OpenAI-hosted execution environment.
            #
            #   @return [OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline]
            required :hosted_environment_file_param, union: -> { OpenAI::Beta::HostedEnvironmentFileParam }

            # @!method initialize(environment_id:, hosted_environment_file_param:, request_options: {})
            #   @param environment_id [String]
            #
            #   @param hosted_environment_file_param [OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline]
            #     A file materialized in an OpenAI-hosted execution environment.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
