# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Traces#list
          class SessionTrace < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The root turn ID. Use this ID as the pagination anchor.
            #
            #   @return [String]
            required :id, String

            # @!attribute created_at
            #   The Unix timestamp in seconds when the root turn was created.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute object
            #   The object type, which is always `agent.session.trace`.
            #
            #   @return [Symbol, :"agent.session.trace"]
            required :object, const: :"agent.session.trace"

            # @!attribute otlp
            #   An OTLP JSON ExportTraceServiceRequest containing resourceSpans. Only currently
            #   published data is returned; later trace updates are not awaited.
            #
            #   @return [Hash{Symbol=>Object}]
            required :otlp, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

            # @!attribute session_id
            #   The session that owns this trace.
            #
            #   @return [String]
            required :session_id, String

            # @!method initialize(id:, created_at:, otlp:, session_id:, object: :"agent.session.trace")
            #   @param id [String]
            #     The root turn ID. Use this ID as the pagination anchor.
            #
            #   @param created_at [Integer]
            #     The Unix timestamp in seconds when the root turn was created.
            #
            #   @param otlp [Hash{Symbol=>Object}]
            #     An OTLP JSON ExportTraceServiceRequest containing resourceSpans. Only currently
            #     published data is returned; later trace updates are not awaited.
            #
            #   @param session_id [String]
            #     The session that owns this trace.
            #
            #   @param object [Symbol, :"agent.session.trace"]
            #     The object type, which is always `agent.session.trace`.
          end
        end

        SessionTrace = Sessions::SessionTrace
      end
    end
  end
end
