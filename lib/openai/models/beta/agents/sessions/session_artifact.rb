# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Artifacts#retrieve
          class SessionArtifact < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The immutable artifact ID.
            #
            #   @return [String]
            required :id, String

            # @!attribute created_at
            #   The Unix timestamp, in seconds, when the artifact was published.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute environment_id
            #   The ID of the environment that produced the artifact.
            #
            #   @return [String]
            required :environment_id, String

            # @!attribute object
            #   The object type. Always `agent.session.artifact`.
            #
            #   @return [Symbol, :"agent.session.artifact"]
            required :object, const: :"agent.session.artifact"

            # @!attribute path
            #   The original absolute file path in the execution environment.
            #
            #   @return [String]
            required :path, String

            # @!attribute session_id
            #   The ID of the session that owns the artifact.
            #
            #   @return [String]
            required :session_id, String

            # @!attribute size_bytes
            #   The immutable artifact size in bytes.
            #
            #   @return [Integer]
            required :size_bytes, Integer

            # @!attribute turn_id
            #   The ID of the completed turn that published the artifact.
            #
            #   @return [String]
            required :turn_id, String

            # @!method initialize(id:, created_at:, environment_id:, path:, session_id:, size_bytes:, turn_id:, object: :"agent.session.artifact")
            #   An immutable file published by a completed hosted session turn.
            #
            #   @param id [String]
            #     The immutable artifact ID.
            #
            #   @param created_at [Integer]
            #     The Unix timestamp, in seconds, when the artifact was published.
            #
            #   @param environment_id [String]
            #     The ID of the environment that produced the artifact.
            #
            #   @param path [String]
            #     The original absolute file path in the execution environment.
            #
            #   @param session_id [String]
            #     The ID of the session that owns the artifact.
            #
            #   @param size_bytes [Integer]
            #     The immutable artifact size in bytes.
            #
            #   @param turn_id [String]
            #     The ID of the completed turn that published the artifact.
            #
            #   @param object [Symbol, :"agent.session.artifact"]
            #     The object type. Always `agent.session.artifact`.
          end
        end

        SessionArtifact = Sessions::SessionArtifact
      end
    end
  end
end
