# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Events#create
          class EventCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute session_id
            #
            #   @return [String]
            required :session_id, String

            # @!attribute events
            #   The input events to submit to the session.
            #
            #   @return [Array<OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputMessage, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputCancel, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputToolResult>]
            required :events, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSessionInputParam] }

            # @!attribute idempotency_key
            #
            #   @return [String, nil]
            optional :idempotency_key, String

            # @!method initialize(session_id:, events:, idempotency_key: nil, request_options: {})
            #   @param session_id [String]
            #
            #   @param events [Array<OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputMessage, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputCancel, OpenAI::Models::Beta::AgentSessionInputParam::AgentSessionInputToolResult>]
            #     The input events to submit to the session.
            #
            #   @param idempotency_key [String]
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
