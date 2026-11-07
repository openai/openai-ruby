# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # The session an automation invocation targets.
        module AutomationTargetParam
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
              OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession
            )
          end

          class NewSession < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
                OpenAI::Internal::AnyHash
              )
            end

            # The execution environment for each new session.
            sig {
              returns(
                T.any(
                  OpenAI::Beta::EnvironmentParam::None,
                  OpenAI::Beta::EnvironmentParam::OpenAIHosted,
                  OpenAI::Beta::EnvironmentParam::SelfHosted
                )
              )
            }
            attr_accessor :environment

            # Initial user messages submitted with each new session.
            sig { returns(T::Array[OpenAI::Beta::AgentSessionInputMessageParam]) }
            attr_accessor :input

            # The type of the object. Always `new_session`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Inline agent configuration. Provide exactly one of agent and agent_id.
            sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent)) }
            attr_reader :agent

            sig { params(agent: OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::OrHash).void }
            attr_writer :agent

            # A saved agent ID. Provide exactly one of agent and agent_id.
            sig { returns(T.nilable(String)) }
            attr_reader :agent_id

            sig { params(agent_id: String).void }
            attr_writer :agent_id

            # Metadata attached to each new session.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :metadata

            # The IDs of vaults made available to each new session.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :vault_ids

            # Create a session for each invocation.
            sig do
              params(

                environment: T.any(
                  OpenAI::Beta::EnvironmentParam::None::OrHash,
                  OpenAI::Beta::EnvironmentParam::OpenAIHosted::OrHash,
                  OpenAI::Beta::EnvironmentParam::SelfHosted::OrHash
                ),

                input: T::Array[OpenAI::Beta::AgentSessionInputMessageParam::OrHash],

                agent: OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::OrHash,

                agent_id: String,

                metadata: T.nilable(T::Hash[Symbol, String]),

                vault_ids: T.nilable(T::Array[String]),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The execution environment for each new session.
              environment:,

              # Initial user messages submitted with each new session.
              input:,

              # Inline agent configuration. Provide exactly one of agent and agent_id.
              agent: nil,

              # A saved agent ID. Provide exactly one of agent and agent_id.
              agent_id: nil,

              # Metadata attached to each new session.
              metadata: nil,

              # The IDs of vaults made available to each new session.
              vault_ids: nil,

              # The type of the object. Always `new_session`.

              type: :new_session
            )
            end

            sig do
              override.returns(
                {
                  environment: T.any(
                    OpenAI::Beta::EnvironmentParam::None,
                    OpenAI::Beta::EnvironmentParam::OpenAIHosted,
                    OpenAI::Beta::EnvironmentParam::SelfHosted
                  ),
                  input: T::Array[OpenAI::Beta::AgentSessionInputMessageParam],
                  type: Symbol,
                  agent: OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent,
                  agent_id: String,
                  metadata: T.nilable(T::Hash[Symbol, String]),
                  vault_ids: T.nilable(T::Array[String])
                }
              )
            end
            def to_hash
            end

            class Agent < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

              # Context compaction settings. Omit to keep the current settings. A supplied
              # object replaces the settings; null or an empty object enables background
              # compaction.
              sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction)) }
              attr_reader :compaction

              sig {
                params(
                  compaction: T.nilable(
                    OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction::OrHash
                  )
                )
                  .void
              }
              attr_writer :compaction

              # Experimental settings to merge by key. Omitted settings keep their current
              # values.
              sig { returns(T.nilable(OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental)) }
              attr_reader :experimental

              sig {
                params(
                  experimental: OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental::OrHash
                )
                  .void
              }
              attr_writer :experimental

              # Additional instructions appended to the agent's default base instructions. Omit
              # to leave unchanged.
              sig { returns(T.nilable(String)) }
              attr_accessor :instructions

              # The model to use for the agent. The requested model name is preserved.
              sig { returns(T.nilable(String)) }
              attr_reader :model

              sig { params(model: String).void }
              attr_writer :model

              # Configuration for creating and coordinating subagents.
              sig { returns(T.nilable(OpenAI::Beta::MultiAgentConfigParam)) }
              attr_reader :multi_agent

              sig { params(multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam::OrHash)).void }
              attr_writer :multi_agent

              # Configuration for model reasoning. Omit to keep the current settings; pass
              # `null` to reset to the model's default effort.
              sig { returns(T.nilable(OpenAI::Beta::AgentReasoningParam)) }
              attr_reader :reasoning

              sig { params(reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam::OrHash)).void }
              attr_writer :reasoning

              # The service tier used for model requests.
              sig {
                returns(
                  T.nilable(OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::OrSymbol)
                )
              }
              attr_accessor :service_tier

              # Configuration for text generated by the agent.
              sig { returns(T.nilable(OpenAI::Beta::AgentTextParam)) }
              attr_reader :text

              sig { params(text: T.nilable(OpenAI::Beta::AgentTextParam::OrHash)).void }
              attr_writer :text

              # Tools available to the agent. Omit to inherit, or pass null to clear them. The
              # resolved tool list must fit within 3 MiB (3,145,728 bytes) of compact UTF-8
              # JSON.
              sig {
                returns(
                  T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Beta::AgentToolParam::Function,
                        OpenAI::Beta::AgentToolParam::ToolSearch,
                        OpenAI::Beta::AgentToolParam::ProgrammaticToolCalling,
                        OpenAI::Beta::AgentToolParam::Mcp,
                        OpenAI::Beta::AgentToolParam::WebSearch,
                        OpenAI::Beta::AgentToolParam::ComputerUse,
                        OpenAI::Beta::AgentToolParam::Automations
                      )
                    ]
                  )
                )
              }
              attr_accessor :tools

              # Inline agent configuration. Provide exactly one of agent and agent_id.
              sig do
                params(

                  compaction: T.nilable(
                    OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction::OrHash
                  ),

                  experimental: OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental::OrHash,

                  instructions: T.nilable(String),

                  model: String,

                  multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam::OrHash),

                  reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam::OrHash),

                  service_tier: T.nilable(
                    OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::OrSymbol
                  ),

                  text: T.nilable(OpenAI::Beta::AgentTextParam::OrHash),

                  tools: T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Beta::AgentToolParam::Function::OrHash,
                        OpenAI::Beta::AgentToolParam::ToolSearch::OrHash,
                        OpenAI::Beta::AgentToolParam::ProgrammaticToolCalling::OrHash,
                        OpenAI::Beta::AgentToolParam::Mcp::OrHash,
                        OpenAI::Beta::AgentToolParam::WebSearch::OrHash,
                        OpenAI::Beta::AgentToolParam::ComputerUse::OrHash,
                        OpenAI::Beta::AgentToolParam::Automations::OrHash
                      )
                    ]
                  )
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Context compaction settings. Omit to keep the current settings. A supplied
                # object replaces the settings; null or an empty object enables background
                # compaction.
                compaction: nil,

                # Experimental settings to merge by key. Omitted settings keep their current
                # values.
                experimental: nil,

                # Additional instructions appended to the agent's default base instructions. Omit
                # to leave unchanged.
                instructions: nil,

                # The model to use for the agent. The requested model name is preserved.
                model: nil,

                # Configuration for creating and coordinating subagents.
                multi_agent: nil,

                # Configuration for model reasoning. Omit to keep the current settings; pass
                # `null` to reset to the model's default effort.
                reasoning: nil,

                # The service tier used for model requests.
                service_tier: nil,

                # Configuration for text generated by the agent.
                text: nil,

                # Tools available to the agent. Omit to inherit, or pass null to clear them. The
                # resolved tool list must fit within 3 MiB (3,145,728 bytes) of compact UTF-8
                # JSON.

                tools: nil
              )
              end

              sig do
                override.returns(
                  {
                    compaction: T.nilable(OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction),
                    experimental: OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental,
                    instructions: T.nilable(String),
                    model: String,
                    multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam),
                    reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam),
                    service_tier: T.nilable(
                      OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::OrSymbol
                    ),
                    text: T.nilable(OpenAI::Beta::AgentTextParam),
                    tools: T.nilable(
                      T::Array[
                        T.any(
                          OpenAI::Beta::AgentToolParam::Function,
                          OpenAI::Beta::AgentToolParam::ToolSearch,
                          OpenAI::Beta::AgentToolParam::ProgrammaticToolCalling,
                          OpenAI::Beta::AgentToolParam::Mcp,
                          OpenAI::Beta::AgentToolParam::WebSearch,
                          OpenAI::Beta::AgentToolParam::ComputerUse,
                          OpenAI::Beta::AgentToolParam::Automations
                        )
                      ]
                    )
                  }
                )
              end
              def to_hash
              end

              class Compaction < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Compaction,
                    OpenAI::Internal::AnyHash
                  )
                end

                # Whether to compact context in the background. Omission or null defaults to true.
                # Set to false to use blocking compaction. Background compaction may increase
                # token usage.
                sig { returns(T.nilable(T::Boolean)) }
                attr_accessor :async

                # Context compaction settings. Omit to keep the current settings. A supplied
                # object replaces the settings; null or an empty object enables background
                # compaction.
                sig do
                  params(

                    async: T.nilable(T::Boolean)
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # Whether to compact context in the background. Omission or null defaults to true.
                  # Set to false to use blocking compaction. Background compaction may increase
                  # token usage.

                  async: nil
                )
                end

                sig do
                  override.returns(
                    {async: T.nilable(T::Boolean)}
                  )
                end
                def to_hash
                end

              end

              class Experimental < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::Experimental,
                    OpenAI::Internal::AnyHash
                  )
                end

                # Whether to give the model periodic current-time reminders. Omit to keep the
                # current setting.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :time_awareness

                sig { params(time_awareness: T::Boolean).void }
                attr_writer :time_awareness

                # Experimental settings to merge by key. Omitted settings keep their current
                # values.
                sig do
                  params(

                    time_awareness: T::Boolean
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # Whether to give the model periodic current-time reminders. Omit to keep the
                  # current setting.

                  time_awareness: nil
                )
                end

                sig do
                  override.returns(
                    {time_awareness: T::Boolean}
                  )
                end
                def to_hash
                end

              end

              # The service tier used for model requests.
              module ServiceTier
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                # Selects the service tier automatically.
                AUTO = T.let(
                  :auto,
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::TaggedSymbol
                )

                # Uses the default service tier.
                DEFAULT = T.let(
                  :default,
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::TaggedSymbol
                )

                # Uses the flex service tier.
                FLEX = T.let(
                  :flex,
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::TaggedSymbol
                )

                # Uses the priority service tier.
                PRIORITY = T.let(
                  :priority,
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::TaggedSymbol
                )

                # Uses the fast service tier.
                FAST = T.let(
                  :fast,
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::TaggedSymbol
                )

                # Uses the ultrafast service tier.
                ULTRAFAST = T.let(
                  :ultrafast,
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::AutomationTargetParam::NewSession::Agent::ServiceTier::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end
          end

          class ExistingSession < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession,
                OpenAI::Internal::AnyHash
              )
            end

            # Instructions delivered as an automation notification.
            sig { returns(String) }
            attr_accessor :instructions

            # The session receiving each invocation.
            sig { returns(String) }
            attr_accessor :session_id

            # The type of the object. Always `existing_session`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Deliver instructions to an existing session.
            sig do
              params(

                instructions: String,

                session_id: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Instructions delivered as an automation notification.
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

          sig { override.returns(T::Array[OpenAI::Beta::Agents::AutomationTargetParam::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
