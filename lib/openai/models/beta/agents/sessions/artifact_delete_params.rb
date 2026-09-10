# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Artifacts#delete
          class ArtifactDeleteParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute session_id
            #
            #   @return [String]
            required :session_id, String

            # @!attribute artifact_id
            #
            #   @return [String]
            required :artifact_id, String

            # @!method initialize(session_id:, artifact_id:, request_options: {})
            #   @param session_id [String]
            #   @param artifact_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
