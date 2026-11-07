# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # Saved target configuration, excluding confidential request-only values.
        module AutomationTarget
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationTarget::NewSession,
              OpenAI::Beta::Agents::AutomationTarget::ExistingSession
            )
          end

          class NewSession < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationTarget::NewSession,
                OpenAI::Internal::AnyHash
              )
            end

            # The inline agent configuration, or null when agent_id is configured.
            sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationAgentConfig)) }
            attr_reader :agent

            sig { params(agent: T.nilable(OpenAI::Beta::Agents::AutomationAgentConfig::OrHash)).void }
            attr_writer :agent

            # The saved agent reference, or null when an inline agent is configured.
            sig { returns(T.nilable(String)) }
            attr_accessor :agent_id

            # Configuration or references used to select the execution environment.
            sig { returns(OpenAI::Beta::Agents::AutomationEnvironment::Variants) }
            attr_accessor :environment

            # Initial input delivered to each new session.
            sig { returns(T::Array[OpenAI::Beta::Agents::AutomationTarget::NewSession::Input]) }
            attr_accessor :input

            # Metadata attached to each new session.
            sig { returns(T::Hash[Symbol, String]) }
            attr_accessor :metadata

            # The type of the object. Always `new_session`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Vaults made available to each new session.
            sig { returns(T::Array[String]) }
            attr_accessor :vault_ids

            sig do
              params(

                agent: T.nilable(OpenAI::Beta::Agents::AutomationAgentConfig::OrHash),

                agent_id: T.nilable(String),

                environment: T.any(
                  OpenAI::Beta::Agents::AutomationEnvironment::None::OrHash,
                  OpenAI::Beta::Agents::AutomationEnvironment::OpenAIHosted::OrHash,
                  OpenAI::Beta::Agents::AutomationEnvironment::SelfHosted::OrHash
                ),

                input: T::Array[OpenAI::Beta::Agents::AutomationTarget::NewSession::Input::OrHash],

                metadata: T::Hash[Symbol, String],

                vault_ids: T::Array[String],

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The inline agent configuration, or null when agent_id is configured.
              agent:,

              # The saved agent reference, or null when an inline agent is configured.
              agent_id:,

              # Configuration or references used to select the execution environment.
              environment:,

              # Initial input delivered to each new session.
              input:,

              # Metadata attached to each new session.
              metadata:,

              # Vaults made available to each new session.
              vault_ids:,

              # The type of the object. Always `new_session`.

              type: :new_session
            )
            end

            sig do
              override.returns(
                {
                  agent: T.nilable(OpenAI::Beta::Agents::AutomationAgentConfig),
                  agent_id: T.nilable(String),
                  environment: OpenAI::Beta::Agents::AutomationEnvironment::Variants,
                  input: T::Array[OpenAI::Beta::Agents::AutomationTarget::NewSession::Input],
                  metadata: T::Hash[Symbol, String],
                  type: Symbol,
                  vault_ids: T::Array[String]
                }
              )
            end
            def to_hash
            end

            class Input < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::AutomationTarget::NewSession::Input,
                  OpenAI::Internal::AnyHash
                )
              end

              # The content of the message.
              sig { returns(T::Array[OpenAI::Beta::InputContent::Variants]) }
              attr_accessor :content

              # The role of the message author. Always `user`.
              sig { returns(Symbol) }
              attr_accessor :role

              # The type of the input item. Always `message`.
              sig { returns(Symbol) }
              attr_accessor :type

              # A user message recorded in a session.
              sig do
                params(

                  content: T::Array[
                    T.any(OpenAI::Beta::InputContent::InputText::OrHash, OpenAI::Beta::InputContent::InputImage::OrHash)
                  ],

                  role: Symbol,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The content of the message.
                content:,

                # The role of the message author. Always `user`.
                role: :user,

                # The type of the input item. Always `message`.

                type: :message
              )
              end

              sig do
                override.returns(
                  {content: T::Array[OpenAI::Beta::InputContent::Variants], role: Symbol, type: Symbol}
                )
              end
              def to_hash
              end

            end
          end

          class ExistingSession < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationTarget::ExistingSession,
                OpenAI::Internal::AnyHash
              )
            end

            # Saved instructions delivered as an automation notification.
            sig { returns(String) }
            attr_accessor :instructions

            # The session receiving each invocation.
            sig { returns(String) }
            attr_accessor :session_id

            # The type of the object. Always `existing_session`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                instructions: String,

                session_id: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Saved instructions delivered as an automation notification.
              instructions:,

              # The session receiving each invocation.
              session_id:,

              # The type of the object. Always `existing_session`.

              type: :existing_session
            )
            end

            sig do
              override.returns(
                {instructions: String, session_id: String, type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Beta::Agents::AutomationTarget::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
