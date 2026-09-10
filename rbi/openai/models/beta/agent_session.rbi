# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSession < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSession,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the session.
        sig { returns(String) }
        attr_accessor :id

        # The agent running in the session.
        sig { returns(OpenAI::Beta::AgentSession::Agent) }
        attr_reader :agent

        sig { params(agent: OpenAI::Beta::AgentSession::Agent::OrHash).void }
        attr_writer :agent

        # The Unix timestamp, in seconds, when the session was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The execution environment for the session.
        sig { returns(OpenAI::Beta::Environment::Variants) }
        attr_accessor :environment

        # The error that caused the session to fail, if any.
        sig { returns(T.nilable(String)) }
        attr_accessor :error

        # The Unix timestamp, in seconds, when the session was last active.
        sig { returns(Integer) }
        attr_accessor :last_active_at

        # Custom string key-value pairs attached to the session.
        sig { returns(T::Hash[Symbol, String]) }
        attr_accessor :metadata

        # The object type. Always `agent.session`.
        sig { returns(Symbol) }
        attr_accessor :object

        # Actions that must be completed before the session can continue.
        sig { returns(T::Array[OpenAI::Beta::AgentSession::RequiredAction::Variants]) }
        attr_accessor :required_actions

        # The current status of the session.
        sig { returns(OpenAI::Beta::AgentSession::Status::TaggedSymbol) }
        attr_accessor :status

        # Recorded token usage for a session or turn. Usage is best effort and may change.
        sig { returns(T.nilable(OpenAI::Beta::TokenUsage)) }
        attr_reader :usage

        sig { params(usage: T.nilable(OpenAI::Beta::TokenUsage::OrHash)).void }
        attr_writer :usage

        # The IDs of vaults made available to the session.
        sig { returns(T::Array[String]) }
        attr_accessor :vault_ids

        # A Managed Agents session.
        sig do
          params(

            id: String,

            agent: OpenAI::Beta::AgentSession::Agent::OrHash,

            created_at: Integer,

            environment: T.any(
              OpenAI::Beta::Environment::None::OrHash,
              OpenAI::Beta::Environment::OpenAIHosted::OrHash,
              OpenAI::Beta::Environment::SelfHosted::OrHash
            ),

            error: T.nilable(String),

            last_active_at: Integer,

            metadata: T::Hash[Symbol, String],

            required_actions: T::Array[
              T.any(
                OpenAI::Beta::AgentSession::RequiredAction::FunctionCall::OrHash,
                OpenAI::Beta::AgentSession::RequiredAction::EnvironmentConnection::OrHash
              )
            ],

            status: OpenAI::Beta::AgentSession::Status::OrSymbol,

            usage: T.nilable(OpenAI::Beta::TokenUsage::OrHash),

            vault_ids: T::Array[String],

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the session.
          id:,

          # The agent running in the session.
          agent:,

          # The Unix timestamp, in seconds, when the session was created.
          created_at:,

          # The execution environment for the session.
          environment:,

          # The error that caused the session to fail, if any.
          error:,

          # The Unix timestamp, in seconds, when the session was last active.
          last_active_at:,

          # Custom string key-value pairs attached to the session.
          metadata:,

          # Actions that must be completed before the session can continue.
          required_actions:,

          # The current status of the session.
          status:,

          # Recorded token usage for a session or turn. Usage is best effort and may change.
          usage:,

          # The IDs of vaults made available to the session.
          vault_ids:,

          # The object type. Always `agent.session`.

          object: :"agent.session"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              agent: OpenAI::Beta::AgentSession::Agent,
              created_at: Integer,
              environment: OpenAI::Beta::Environment::Variants,
              error: T.nilable(String),
              last_active_at: Integer,
              metadata: T::Hash[Symbol, String],
              object: Symbol,
              required_actions: T::Array[OpenAI::Beta::AgentSession::RequiredAction::Variants],
              status: OpenAI::Beta::AgentSession::Status::TaggedSymbol,
              usage: T.nilable(OpenAI::Beta::TokenUsage),
              vault_ids: T::Array[String]
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSession::Agent,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the agent.
          sig { returns(String) }
          attr_accessor :id

          # Custom instructions appended to the agent's default base instructions.
          sig { returns(T.nilable(String)) }
          attr_accessor :instructions

          # The model used by the agent.
          sig { returns(String) }
          attr_accessor :model

          # Configuration for creating and coordinating subagents.
          sig { returns(OpenAI::Beta::MultiAgentConfig) }
          attr_reader :multi_agent

          sig { params(multi_agent: OpenAI::Beta::MultiAgentConfig::OrHash).void }
          attr_writer :multi_agent

          # The reusable agent's name when the session was created, or null if no name was
          # saved. Later changes to the agent's name do not affect this value.
          sig { returns(T.nilable(String)) }
          attr_accessor :name

          # The agent's reasoning configuration.
          sig { returns(OpenAI::Beta::AgentReasoning) }
          attr_reader :reasoning

          sig { params(reasoning: OpenAI::Beta::AgentReasoning::OrHash).void }
          attr_writer :reasoning

          # The effective service-tier policy for model requests. Defaults to `auto`.
          sig { returns(OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol) }
          attr_accessor :service_tier

          # Configuration for text generated by the agent.
          sig { returns(OpenAI::Beta::AgentText) }
          attr_reader :text

          sig { params(text: OpenAI::Beta::AgentText::OrHash).void }
          attr_writer :text

          # Tools available to the agent.
          sig { returns(T::Array[OpenAI::Beta::AgentTool::Variants]) }
          attr_accessor :tools

          # The agent running in the session.
          sig do
            params(

              id: String,

              instructions: T.nilable(String),

              model: String,

              multi_agent: OpenAI::Beta::MultiAgentConfig::OrHash,

              name: T.nilable(String),

              reasoning: OpenAI::Beta::AgentReasoning::OrHash,

              service_tier: OpenAI::Beta::AgentSession::Agent::ServiceTier::OrSymbol,

              text: OpenAI::Beta::AgentText::OrHash,

              tools: T::Array[
                T.any(
                  OpenAI::Beta::AgentTool::Function::OrHash,
                  OpenAI::Beta::AgentTool::ProgrammaticToolCalling::OrHash,
                  OpenAI::Beta::AgentTool::Mcp::OrHash,
                  OpenAI::Beta::AgentTool::WebSearch::OrHash
                )
              ]
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the agent.
            id:,

            # Custom instructions appended to the agent's default base instructions.
            instructions:,

            # The model used by the agent.
            model:,

            # Configuration for creating and coordinating subagents.
            multi_agent:,

            # The reusable agent's name when the session was created, or null if no name was
            # saved. Later changes to the agent's name do not affect this value.
            name:,

            # The agent's reasoning configuration.
            reasoning:,

            # The effective service-tier policy for model requests. Defaults to `auto`.
            service_tier:,

            # Configuration for text generated by the agent.
            text:,

            # Tools available to the agent.

            tools:
          )
          end

          sig do
            override.returns(
              {
                id: String,
                instructions: T.nilable(String),
                model: String,
                multi_agent: OpenAI::Beta::MultiAgentConfig,
                name: T.nilable(String),
                reasoning: OpenAI::Beta::AgentReasoning,
                service_tier: OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol,
                text: OpenAI::Beta::AgentText,
                tools: T::Array[OpenAI::Beta::AgentTool::Variants]
              }
            )
          end
          def to_hash
          end

          # The effective service-tier policy for model requests. Defaults to `auto`.
          module ServiceTier
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentSession::Agent::ServiceTier) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO = T.let(:auto, OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol)
            DEFAULT = T.let(:default, OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol)
            FLEX = T.let(:flex, OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol)
            PRIORITY = T.let(:priority, OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol)
            FAST = T.let(:fast, OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::AgentSession::Agent::ServiceTier::TaggedSymbol]) }
            def self.values
            end
          end
        end

        # An action that must be completed before a session can continue.
        module RequiredAction
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Beta::AgentSession::RequiredAction::FunctionCall,
              OpenAI::Beta::AgentSession::RequiredAction::EnvironmentConnection
            )
          }

          class FunctionCall < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::AgentSession::RequiredAction::FunctionCall,
                OpenAI::Internal::AnyHash
              )
            end

            # The arguments supplied by the model.
            sig { returns(T.anything) }
            attr_accessor :arguments

            # The ID to include when submitting the function result.
            sig { returns(String) }
            attr_accessor :call_id

            # The function name.
            sig { returns(String) }
            attr_accessor :name

            # The ID of the turn that requested the function call.
            sig { returns(String) }
            attr_accessor :turn_id

            # The type of the object. Always `function_call`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Run a function tool and submit its result.
            sig do
              params(

                arguments: T.anything,

                call_id: String,

                name: String,

                turn_id: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The arguments supplied by the model.
              arguments:,

              # The ID to include when submitting the function result.
              call_id:,

              # The function name.
              name:,

              # The ID of the turn that requested the function call.
              turn_id:,

              # The type of the object. Always `function_call`.

              type: :function_call
            )
            end

            sig do
              override.returns(
                {arguments: T.anything, call_id: String, name: String, turn_id: String, type: Symbol}
              )
            end
            def to_hash
            end

          end

          class EnvironmentConnection < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::AgentSession::RequiredAction::EnvironmentConnection,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the environment to reconnect.
            sig { returns(String) }
            attr_accessor :environment_id

            # The type of the object. Always `environment_connection`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Reconnect a session environment.
            sig do
              params(

                environment_id: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the environment to reconnect.
              environment_id:,

              # The type of the object. Always `environment_connection`.

              type: :environment_connection
            )
            end

            sig do
              override.returns(
                {environment_id: String, type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Beta::AgentSession::RequiredAction::Variants]) }
          def self.variants
          end

        end

        # The current status of the session.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentSession::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # The session has no turn in progress and is ready for input. A hosted environment may still be provisioning.
          IDLE = T.let(:idle, OpenAI::Beta::AgentSession::Status::TaggedSymbol)

          # The session is processing a turn.
          IN_PROGRESS = T.let(:in_progress, OpenAI::Beta::AgentSession::Status::TaggedSymbol)

          # The session is waiting for one or more required actions.
          REQUIRES_ACTION = T.let(:requires_action, OpenAI::Beta::AgentSession::Status::TaggedSymbol)

          # The session failed.
          FAILED = T.let(:failed, OpenAI::Beta::AgentSession::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentSession::Status::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
