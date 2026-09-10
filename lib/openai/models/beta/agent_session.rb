# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSession < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the session.
        #
        #   @return [String]
        required :id, String

        # @!attribute agent
        #   The agent running in the session.
        #
        #   @return [OpenAI::Models::Beta::AgentSession::Agent]
        required :agent, -> { OpenAI::Beta::AgentSession::Agent }

        # @!attribute created_at
        #   The Unix timestamp, in seconds, when the session was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute environment
        #   The execution environment for the session.
        #
        #   @return [OpenAI::Models::Beta::Environment::None, OpenAI::Models::Beta::Environment::OpenAIHosted, OpenAI::Models::Beta::Environment::SelfHosted]
        required :environment, union: -> { OpenAI::Beta::Environment }

        # @!attribute error
        #   The error that caused the session to fail, if any.
        #
        #   @return [String, nil]
        required :error, String, nil?: true

        # @!attribute last_active_at
        #   The Unix timestamp, in seconds, when the session was last active.
        #
        #   @return [Integer]
        required :last_active_at, Integer

        # @!attribute metadata
        #   Custom string key-value pairs attached to the session.
        #
        #   @return [Hash{Symbol=>String}]
        required :metadata, OpenAI::Internal::Type::HashOf[String]

        # @!attribute object
        #   The object type. Always `agent.session`.
        #
        #   @return [Symbol, :"agent.session"]
        required :object, const: :"agent.session"

        # @!attribute required_actions
        #   Actions that must be completed before the session can continue.
        #
        #   @return [Array<OpenAI::Models::Beta::AgentSession::RequiredAction::FunctionCall, OpenAI::Models::Beta::AgentSession::RequiredAction::EnvironmentConnection>]
        required(
          :required_actions,
          -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSession::RequiredAction] }
        )

        # @!attribute status
        #   The current status of the session.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentSession::Status]
        required :status, enum: -> { OpenAI::Beta::AgentSession::Status }

        # @!attribute usage
        #   Recorded token usage for a session or turn. Usage is best effort and may change.
        #
        #   @return [OpenAI::Models::Beta::TokenUsage, nil]
        required :usage, -> { OpenAI::Beta::TokenUsage }, nil?: true

        # @!attribute vault_ids
        #   The IDs of vaults made available to the session.
        #
        #   @return [Array<String>]
        required :vault_ids, OpenAI::Internal::Type::ArrayOf[String]

        # @!method initialize(id:, agent:, created_at:, environment:, error:, last_active_at:, metadata:, required_actions:, status:, usage:, vault_ids:, object: :"agent.session")
        #   A Managed Agents session.
        #
        #   @param id [String]
        #     The ID of the session.
        #
        #   @param agent [OpenAI::Models::Beta::AgentSession::Agent]
        #     The agent running in the session.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp, in seconds, when the session was created.
        #
        #   @param environment [OpenAI::Models::Beta::Environment::None, OpenAI::Models::Beta::Environment::OpenAIHosted, OpenAI::Models::Beta::Environment::SelfHosted]
        #     The execution environment for the session.
        #
        #   @param error [String, nil]
        #     The error that caused the session to fail, if any.
        #
        #   @param last_active_at [Integer]
        #     The Unix timestamp, in seconds, when the session was last active.
        #
        #   @param metadata [Hash{Symbol=>String}]
        #     Custom string key-value pairs attached to the session.
        #
        #   @param required_actions [Array<OpenAI::Models::Beta::AgentSession::RequiredAction::FunctionCall, OpenAI::Models::Beta::AgentSession::RequiredAction::EnvironmentConnection>]
        #     Actions that must be completed before the session can continue.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentSession::Status]
        #     The current status of the session.
        #
        #   @param usage [OpenAI::Models::Beta::TokenUsage, nil]
        #     Recorded token usage for a session or turn. Usage is best effort and may change.
        #
        #   @param vault_ids [Array<String>]
        #     The IDs of vaults made available to the session.
        #
        #   @param object [Symbol, :"agent.session"]
        #     The object type. Always `agent.session`.

        # @see OpenAI::Models::Beta::AgentSession#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the agent.
          #
          #   @return [String]
          required :id, String

          # @!attribute instructions
          #   Custom instructions appended to the agent's default base instructions.
          #
          #   @return [String, nil]
          required :instructions, String, nil?: true

          # @!attribute model
          #   The model used by the agent.
          #
          #   @return [String]
          required :model, String

          # @!attribute multi_agent
          #   Configuration for creating and coordinating subagents.
          #
          #   @return [OpenAI::Models::Beta::MultiAgentConfig]
          required :multi_agent, -> { OpenAI::Beta::MultiAgentConfig }

          # @!attribute name
          #   The reusable agent's name when the session was created, or null if no name was
          #   saved. Later changes to the agent's name do not affect this value.
          #
          #   @return [String, nil]
          required :name, String, nil?: true

          # @!attribute reasoning
          #   The agent's reasoning configuration.
          #
          #   @return [OpenAI::Models::Beta::AgentReasoning]
          required :reasoning, -> { OpenAI::Beta::AgentReasoning }

          # @!attribute service_tier
          #   The effective service-tier policy for model requests. Defaults to `auto`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentSession::Agent::ServiceTier]
          required :service_tier, enum: -> { OpenAI::Beta::AgentSession::Agent::ServiceTier }

          # @!attribute text
          #   Configuration for text generated by the agent.
          #
          #   @return [OpenAI::Models::Beta::AgentText]
          required :text, -> { OpenAI::Beta::AgentText }

          # @!attribute tools
          #   Tools available to the agent.
          #
          #   @return [Array<OpenAI::Models::Beta::AgentTool::Function, OpenAI::Models::Beta::AgentTool::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentTool::Mcp, OpenAI::Models::Beta::AgentTool::WebSearch>]
          required :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentTool] }

          # @!method initialize(id:, instructions:, model:, multi_agent:, name:, reasoning:, service_tier:, text:, tools:)
          #   The agent running in the session.
          #
          #   @param id [String]
          #     The ID of the agent.
          #
          #   @param instructions [String, nil]
          #     Custom instructions appended to the agent's default base instructions.
          #
          #   @param model [String]
          #     The model used by the agent.
          #
          #   @param multi_agent [OpenAI::Models::Beta::MultiAgentConfig]
          #     Configuration for creating and coordinating subagents.
          #
          #   @param name [String, nil]
          #     The reusable agent's name when the session was created, or null if no name was
          #     saved. Later changes to the agent's name do not affect this value.
          #
          #   @param reasoning [OpenAI::Models::Beta::AgentReasoning]
          #     The agent's reasoning configuration.
          #
          #   @param service_tier [Symbol, OpenAI::Models::Beta::AgentSession::Agent::ServiceTier]
          #     The effective service-tier policy for model requests. Defaults to `auto`.
          #
          #   @param text [OpenAI::Models::Beta::AgentText]
          #     Configuration for text generated by the agent.
          #
          #   @param tools [Array<OpenAI::Models::Beta::AgentTool::Function, OpenAI::Models::Beta::AgentTool::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentTool::Mcp, OpenAI::Models::Beta::AgentTool::WebSearch>]
          #     Tools available to the agent.

          # The effective service-tier policy for model requests. Defaults to `auto`.
          #
          # @see OpenAI::Models::Beta::AgentSession::Agent#service_tier
          module ServiceTier
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            DEFAULT = :default
            FLEX = :flex
            PRIORITY = :priority
            FAST = :fast

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # An action that must be completed before a session can continue.
        module RequiredAction
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Run a function tool and submit its result.
          variant :function_call, -> { OpenAI::Beta::AgentSession::RequiredAction::FunctionCall }

          # Reconnect a session environment.
          variant :environment_connection, -> { OpenAI::Beta::AgentSession::RequiredAction::EnvironmentConnection }

          class FunctionCall < OpenAI::Internal::Type::BaseModel
            # @!attribute arguments
            #   The arguments supplied by the model.
            #
            #   @return [Object]
            required :arguments, OpenAI::Internal::Type::Unknown

            # @!attribute call_id
            #   The ID to include when submitting the function result.
            #
            #   @return [String]
            required :call_id, String

            # @!attribute name
            #   The function name.
            #
            #   @return [String]
            required :name, String

            # @!attribute turn_id
            #   The ID of the turn that requested the function call.
            #
            #   @return [String]
            required :turn_id, String

            # @!attribute type
            #   The type of the object. Always `function_call`.
            #
            #   @return [Symbol, :function_call]
            required :type, const: :function_call

            # @!method initialize(arguments:, call_id:, name:, turn_id:, type: :function_call)
            #   Run a function tool and submit its result.
            #
            #   @param arguments [Object]
            #     The arguments supplied by the model.
            #
            #   @param call_id [String]
            #     The ID to include when submitting the function result.
            #
            #   @param name [String]
            #     The function name.
            #
            #   @param turn_id [String]
            #     The ID of the turn that requested the function call.
            #
            #   @param type [Symbol, :function_call]
            #     The type of the object. Always `function_call`.
          end

          class EnvironmentConnection < OpenAI::Internal::Type::BaseModel
            # @!attribute environment_id
            #   The ID of the environment to reconnect.
            #
            #   @return [String]
            required :environment_id, String

            # @!attribute type
            #   The type of the object. Always `environment_connection`.
            #
            #   @return [Symbol, :environment_connection]
            required :type, const: :environment_connection

            # @!method initialize(environment_id:, type: :environment_connection)
            #   Reconnect a session environment.
            #
            #   @param environment_id [String]
            #     The ID of the environment to reconnect.
            #
            #   @param type [Symbol, :environment_connection]
            #     The type of the object. Always `environment_connection`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::AgentSession::RequiredAction::FunctionCall, OpenAI::Models::Beta::AgentSession::RequiredAction::EnvironmentConnection)]
        end

        # The current status of the session.
        #
        # @see OpenAI::Models::Beta::AgentSession#status
        module Status
          extend OpenAI::Internal::Type::Enum

          # The session has no turn in progress and is ready for input. A hosted environment may still be provisioning.
          IDLE = :idle

          # The session is processing a turn.
          IN_PROGRESS = :in_progress

          # The session is waiting for one or more required actions.
          REQUIRES_ACTION = :requires_action

          # The session failed.
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
