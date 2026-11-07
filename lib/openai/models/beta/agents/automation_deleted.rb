# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Automations#delete
        class AutomationDeleted < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The deleted automation ID.
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #   Always true.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   Always `agent.automation.deleted`.
          #
          #   @return [Symbol, :"agent.automation.deleted"]
          required :object, const: :"agent.automation.deleted"

          # @!method initialize(id:, deleted:, object: :"agent.automation.deleted")
          #   @param id [String]
          #     The deleted automation ID.
          #
          #   @param deleted [Boolean]
          #     Always true.
          #
          #   @param object [Symbol, :"agent.automation.deleted"]
          #     Always `agent.automation.deleted`.
        end
      end
    end
  end
end
