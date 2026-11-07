# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # How the automation was created, independently of how an invocation started.
        module AutomationCreatedBy
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :developer, -> { OpenAI::Beta::Agents::AutomationCreatedBy::Developer }

          variant :agent, -> { OpenAI::Beta::Agents::AutomationCreatedBy::Agent }

          class Developer < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The type of the object. Always `developer`.
            #
            #   @return [Symbol, :developer]
            required :type, const: :developer

            # @!method initialize(type: :developer)
            #   @param type [Symbol, :developer]
            #     The type of the object. Always `developer`.
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            # @!attribute session_id
            #   The creator session, which is also the automation's target.
            #
            #   @return [String]
            required :session_id, String

            # @!attribute tool_call_id
            #   The tool call that created the automation.
            #
            #   @return [String]
            required :tool_call_id, String

            # @!attribute type
            #   The type of the object. Always `agent`.
            #
            #   @return [Symbol, :agent]
            required :type, const: :agent

            # @!method initialize(session_id:, tool_call_id:, type: :agent)
            #   @param session_id [String]
            #     The creator session, which is also the automation's target.
            #
            #   @param tool_call_id [String]
            #     The tool call that created the automation.
            #
            #   @param type [Symbol, :agent]
            #     The type of the object. Always `agent`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::Agents::AutomationCreatedBy::Developer, OpenAI::Models::Beta::Agents::AutomationCreatedBy::Agent)]
        end
      end
    end
  end
end
