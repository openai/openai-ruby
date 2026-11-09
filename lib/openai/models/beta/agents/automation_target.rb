# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # Saved target configuration, excluding confidential request-only values.
        module AutomationTarget
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :new_session, -> { OpenAI::Beta::Agents::AutomationTarget::NewSession }

          variant :existing_session, -> { OpenAI::Beta::Agents::AutomationTarget::ExistingSession }

          class NewSession < OpenAI::Internal::Type::BaseModel
            # @!attribute agent
            #   The inline agent configuration, or null when agent_id is configured.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationAgentConfig, nil]
            required :agent, -> { OpenAI::Beta::Agents::AutomationAgentConfig }, nil?: true

            # @!attribute agent_id
            #   The saved agent reference, or null when an inline agent is configured.
            #
            #   @return [String, nil]
            required :agent_id, String, nil?: true

            # @!attribute environment
            #   Configuration or references used to select the execution environment.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationEnvironment::None, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted, OpenAI::Models::Beta::Agents::AutomationEnvironment::SelfHosted]
            required :environment, union: -> { OpenAI::Beta::Agents::AutomationEnvironment }

            # @!attribute input
            #   Initial input delivered to each new session.
            #
            #   @return [Array<OpenAI::Models::Beta::Agents::AutomationTarget::NewSession::Input>]
            required(
              :input,
              -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::Agents::AutomationTarget::NewSession::Input] }
            )

            # @!attribute metadata
            #   Metadata attached to each new session.
            #
            #   @return [Hash{Symbol=>String}]
            required :metadata, OpenAI::Internal::Type::HashOf[String]

            # @!attribute type
            #   The type of the object. Always `new_session`.
            #
            #   @return [Symbol, :new_session]
            required :type, const: :new_session

            # @!attribute vault_ids
            #   Vaults made available to each new session.
            #
            #   @return [Array<String>]
            required :vault_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(agent:, agent_id:, environment:, input:, metadata:, vault_ids:, type: :new_session)
            #   @param agent [OpenAI::Models::Beta::Agents::AutomationAgentConfig, nil]
            #     The inline agent configuration, or null when agent_id is configured.
            #
            #   @param agent_id [String, nil]
            #     The saved agent reference, or null when an inline agent is configured.
            #
            #   @param environment [OpenAI::Models::Beta::Agents::AutomationEnvironment::None, OpenAI::Models::Beta::Agents::AutomationEnvironment::OpenAIHosted, OpenAI::Models::Beta::Agents::AutomationEnvironment::SelfHosted]
            #     Configuration or references used to select the execution environment.
            #
            #   @param input [Array<OpenAI::Models::Beta::Agents::AutomationTarget::NewSession::Input>]
            #     Initial input delivered to each new session.
            #
            #   @param metadata [Hash{Symbol=>String}]
            #     Metadata attached to each new session.
            #
            #   @param vault_ids [Array<String>]
            #     Vaults made available to each new session.
            #
            #   @param type [Symbol, :new_session]
            #     The type of the object. Always `new_session`.
            class Input < OpenAI::Internal::Type::BaseModel
              # @!attribute content
              #   The content of the message.
              #
              #   @return [Array<OpenAI::Models::Beta::InputContent::InputText, OpenAI::Models::Beta::InputContent::InputImage>]
              required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::InputContent] }

              # @!attribute role
              #   The role of the message author. Always `user`.
              #
              #   @return [Symbol, :user]
              required :role, const: :user

              # @!attribute type
              #   The type of the input item. Always `message`.
              #
              #   @return [Symbol, :message]
              required :type, const: :message

              # @!method initialize(content:, role: :user, type: :message)
              #   A user message recorded in a session.
              #
              #   @param content [Array<OpenAI::Models::Beta::InputContent::InputText, OpenAI::Models::Beta::InputContent::InputImage>]
              #     The content of the message.
              #
              #   @param role [Symbol, :user]
              #     The role of the message author. Always `user`.
              #
              #   @param type [Symbol, :message]
              #     The type of the input item. Always `message`.
            end
          end

          class ExistingSession < OpenAI::Internal::Type::BaseModel
            # @!attribute instructions
            #   Saved instructions delivered as an automation notification.
            #
            #   @return [String]
            required :instructions, String

            # @!attribute session_id
            #   The session receiving each invocation.
            #
            #   @return [String]
            required :session_id, String

            # @!attribute type
            #   The type of the object. Always `existing_session`.
            #
            #   @return [Symbol, :existing_session]
            required :type, const: :existing_session

            # @!method initialize(instructions:, session_id:, type: :existing_session)
            #   @param instructions [String]
            #     Saved instructions delivered as an automation notification.
            #
            #   @param session_id [String]
            #     The session receiving each invocation.
            #
            #   @param type [Symbol, :existing_session]
            #     The type of the object. Always `existing_session`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::Agents::AutomationTarget::NewSession, OpenAI::Models::Beta::Agents::AutomationTarget::ExistingSession)]
        end
      end
    end
  end
end
