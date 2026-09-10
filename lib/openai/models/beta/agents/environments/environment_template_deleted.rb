# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Environments
          # @see OpenAI::Resources::Beta::Agents::Environments::Templates#delete
          class EnvironmentTemplateDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the deleted environment template.
            #
            #   @return [String]
            required :id, String

            # @!attribute deleted
            #   Whether the environment template was deleted. Always `true`.
            #
            #   @return [Boolean]
            required :deleted, OpenAI::Internal::Type::Boolean

            # @!attribute object
            #   The object type. Always `agent.environment.template.deleted`.
            #
            #   @return [Symbol, :"agent.environment.template.deleted"]
            required :object, const: :"agent.environment.template.deleted"

            # @!method initialize(id:, deleted:, object: :"agent.environment.template.deleted")
            #   A deleted reusable environment template.
            #
            #   @param id [String]
            #     The ID of the deleted environment template.
            #
            #   @param deleted [Boolean]
            #     Whether the environment template was deleted. Always `true`.
            #
            #   @param object [Symbol, :"agent.environment.template.deleted"]
            #     The object type. Always `agent.environment.template.deleted`.
          end
        end

        EnvironmentTemplateDeleted = Environments::EnvironmentTemplateDeleted
      end
    end
  end
end
