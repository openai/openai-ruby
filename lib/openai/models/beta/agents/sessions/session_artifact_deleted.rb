# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Artifacts#delete
          class SessionArtifactDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the deleted session artifact.
            #
            #   @return [String]
            required :id, String

            # @!attribute deleted
            #   Whether the session artifact was deleted. Always `true`.
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #   The object type. Always `agent.session.artifact.deleted`.
            #
            #   @return [Symbol, :"agent.session.artifact.deleted"]
            required :object, const: :"agent.session.artifact.deleted"

            # @!method initialize(id:, deleted:, object: :"agent.session.artifact.deleted")
            #   Confirmation that an immutable session artifact was deleted.
            #
            #   @param id [String]
            #     The ID of the deleted session artifact.
            #
            #   @param deleted [Boolean]
            #     Whether the session artifact was deleted. Always `true`.
            #
            #   @param object [Symbol, :"agent.session.artifact.deleted"]
            #     The object type. Always `agent.session.artifact.deleted`.
          end
        end

        SessionArtifactDeleted = Sessions::SessionArtifactDeleted
      end
    end
  end
end
