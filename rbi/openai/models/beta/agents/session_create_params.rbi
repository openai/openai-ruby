# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class SessionCreateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::SessionCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          # An inline execution environment or a reference to an environment template.
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

          # Agent configuration. With `agent_id`, supplied fields override the saved agent
          # for this session. Without `agent_id`, `model` is required.
          sig { returns(T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Agent)) }
          attr_reader :agent

          sig { params(agent: OpenAI::Beta::Agents::SessionCreateParams::Agent::OrHash).void }
          attr_writer :agent

          # The ID of a saved reusable agent. Omit `agent` to use its configuration
          # unchanged.
          sig { returns(T.nilable(String)) }
          attr_reader :agent_id

          sig { params(agent_id: String).void }
          attr_writer :agent_id

          # Initial input submitted when creating a session.
          sig { returns(T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Input::Variants)) }
          attr_accessor :input

          # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          # characters. Omission or null defaults to an empty map.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          # The IDs of vaults made available to the session.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :vault_ids

          sig do
            params(

              environment: T.any(
                OpenAI::Beta::EnvironmentParam::None::OrHash,
                OpenAI::Beta::EnvironmentParam::OpenAIHosted::OrHash,
                OpenAI::Beta::EnvironmentParam::SelfHosted::OrHash
              ),

              agent: OpenAI::Beta::Agents::SessionCreateParams::Agent::OrHash,

              agent_id: String,

              input: T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Input::Variants),

              metadata: T.nilable(T::Hash[Symbol, String]),

              vault_ids: T.nilable(T::Array[String]),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # An inline execution environment or a reference to an environment template.
            environment:,

            # Agent configuration. With `agent_id`, supplied fields override the saved agent
            # for this session. Without `agent_id`, `model` is required.
            agent: nil,

            # The ID of a saved reusable agent. Omit `agent` to use its configuration
            # unchanged.
            agent_id: nil,

            # Initial input submitted when creating a session.
            input: nil,

            # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            # characters. Omission or null defaults to an empty map.
            metadata: nil,

            # The IDs of vaults made available to the session.
            vault_ids: nil,

            request_options: {}
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
                agent: OpenAI::Beta::Agents::SessionCreateParams::Agent,
                agent_id: String,
                input: T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Input::Variants),
                metadata: T.nilable(T::Hash[Symbol, String]),
                vault_ids: T.nilable(T::Array[String]),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::SessionCreateParams::Agent,
                OpenAI::Internal::AnyHash
              )
            end

            # Additional instructions appended to the agent's default base instructions. Omit
            # to leave unchanged.
            sig { returns(T.nilable(String)) }
            attr_accessor :instructions

            # The model to use for the agent. The requested model name is preserved.
            sig { returns(T.nilable(String)) }
            attr_reader :model

            sig { params(model: String).void }
            attr_writer :model

            # Explicit configuration for creating and coordinating subagents.
            sig { returns(T.nilable(OpenAI::Beta::MultiAgentConfigParam)) }
            attr_reader :multi_agent

            sig { params(multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam::OrHash)).void }
            attr_writer :multi_agent

            # Reasoning configuration for the agent.
            sig { returns(T.nilable(OpenAI::Beta::AgentReasoningParam)) }
            attr_reader :reasoning

            sig { params(reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam::OrHash)).void }
            attr_writer :reasoning

            # The service tier used for model requests.
            sig { returns(T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::OrSymbol)) }
            attr_accessor :service_tier

            # Configuration for text generated by the agent.
            sig { returns(T.nilable(OpenAI::Beta::AgentTextParam)) }
            attr_reader :text

            sig { params(text: T.nilable(OpenAI::Beta::AgentTextParam::OrHash)).void }
            attr_writer :text

            # Tools available to the agent. Omit to inherit, or pass null to clear them.
            sig {
              returns(
                T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::AgentToolParam::Function,
                      OpenAI::Beta::AgentToolParam::ToolSearch,
                      OpenAI::Beta::AgentToolParam::ProgrammaticToolCalling,
                      OpenAI::Beta::AgentToolParam::Mcp,
                      OpenAI::Beta::AgentToolParam::WebSearch
                    )
                  ]
                )
              )
            }
            attr_accessor :tools

            # Agent configuration. With `agent_id`, supplied fields override the saved agent
            # for this session. Without `agent_id`, `model` is required.
            sig do
              params(

                instructions: T.nilable(String),

                model: String,

                multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam::OrHash),

                reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam::OrHash),

                service_tier: T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::OrSymbol),

                text: T.nilable(OpenAI::Beta::AgentTextParam::OrHash),

                tools: T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::AgentToolParam::Function::OrHash,
                      OpenAI::Beta::AgentToolParam::ToolSearch::OrHash,
                      OpenAI::Beta::AgentToolParam::ProgrammaticToolCalling::OrHash,
                      OpenAI::Beta::AgentToolParam::Mcp::OrHash,
                      OpenAI::Beta::AgentToolParam::WebSearch::OrHash
                    )
                  ]
                )
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Additional instructions appended to the agent's default base instructions. Omit
              # to leave unchanged.
              instructions: nil,

              # The model to use for the agent. The requested model name is preserved.
              model: nil,

              # Explicit configuration for creating and coordinating subagents.
              multi_agent: nil,

              # Reasoning configuration for the agent.
              reasoning: nil,

              # The service tier used for model requests.
              service_tier: nil,

              # Configuration for text generated by the agent.
              text: nil,

              # Tools available to the agent. Omit to inherit, or pass null to clear them.

              tools: nil
            )
            end

            sig do
              override.returns(
                {
                  instructions: T.nilable(String),
                  model: String,
                  multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam),
                  reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam),
                  service_tier: T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::OrSymbol),
                  text: T.nilable(OpenAI::Beta::AgentTextParam),
                  tools: T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Beta::AgentToolParam::Function,
                        OpenAI::Beta::AgentToolParam::ToolSearch,
                        OpenAI::Beta::AgentToolParam::ProgrammaticToolCalling,
                        OpenAI::Beta::AgentToolParam::Mcp,
                        OpenAI::Beta::AgentToolParam::WebSearch
                      )
                    ]
                  )
                }
              )
            end
            def to_hash
            end

            # The service tier used for model requests.
            module ServiceTier
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Selects the service tier automatically.
              AUTO = T.let(:auto, OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the default service tier.
              DEFAULT = T.let(:default, OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the flex service tier.
              FLEX = T.let(:flex, OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the priority service tier.
              PRIORITY = T.let(:priority, OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the fast service tier.
              FAST = T.let(:fast, OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::TaggedSymbol)

              sig {
                override.returns(T::Array[OpenAI::Beta::Agents::SessionCreateParams::Agent::ServiceTier::TaggedSymbol])
              }
              def self.values
              end
            end
          end

          # Initial input submitted when creating a session.
          module Input
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, T::Array[OpenAI::Beta::AgentSessionInputMessageParam]) }

            sig { override.returns(T::Array[OpenAI::Beta::Agents::SessionCreateParams::Input::Variants]) }
            def self.variants
            end

            AgentSessionInputMessageParamArray = T.let(
              OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::AgentSessionInputMessageParam],
              OpenAI::Internal::Type::Converter
            )

          end

        end

      end

    end

  end
end
