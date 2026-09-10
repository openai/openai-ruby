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

            # @!method initialize(environment_id:, request_options: {})
            #   @param environment_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
