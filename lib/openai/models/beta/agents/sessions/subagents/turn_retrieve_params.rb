# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          module Subagents
            # @see OpenAI::Resources::Beta::Agents::Sessions::Subagents::Turns#retrieve
            class TurnRetrieveParams < OpenAI::Internal::Type::BaseModel
              extend OpenAI::Internal::Type::RequestParameters::Converter
              include OpenAI::Internal::Type::RequestParameters

              # @!attribute session_id
              #
              #   @return [String]
              required :session_id, String

              # @!attribute subagent_id
              #
              #   @return [String]
              required :subagent_id, String

              # @!attribute turn_id
              #
              #   @return [String]
              required :turn_id, String

              # @!method initialize(session_id:, subagent_id:, turn_id:, request_options: {})
              #   @param session_id [String]
              #   @param subagent_id [String]
              #   @param turn_id [String]
              #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
            end
          end
        end
      end
    end
  end
end
