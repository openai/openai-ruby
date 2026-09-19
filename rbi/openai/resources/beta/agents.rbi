# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        sig { returns(OpenAI::Resources::Beta::Agents::Environments) }
        attr_reader :environments

        sig { returns(OpenAI::Resources::Beta::Agents::Vaults) }
        attr_reader :vaults

        sig { returns(OpenAI::Resources::Beta::Agents::Sessions) }
        attr_reader :sessions

        # Creates a reusable agent without storing credentials. See
        # [agent configuration](https://developers.openai.com/api/docs/guides/agents-api/configuration).
        sig {
          params(
            model: String,
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam::OrHash),
            name: T.nilable(String),
            reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam::OrHash),
            service_tier: T.nilable(OpenAI::Beta::AgentCreateParams::ServiceTier::OrSymbol),
            text: T.nilable(OpenAI::Beta::AgentTextParam::OrHash),
            tools: T.nilable(
              T::Array[
                T.any(
                  OpenAI::Beta::PersistedAgentToolParam::Function::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::ToolSearch::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::ProgrammaticToolCalling::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::Mcp::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::WebSearch::OrHash
                )
              ]
            ),
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Beta::Agent)
        }
        def create(
          # The model to use for the agent. The requested model name is preserved.
          model:,
          # Additional instructions appended to the agent's default base instructions. Omit
          # or set to null to add no custom instructions.
          instructions: nil,
          # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          # characters. Omission or null defaults to an empty map.
          metadata: nil,
          # Configuration for creating and coordinating subagents. Subagent tools are
          # disabled by default.
          multi_agent: nil,
          # A human-readable name for the agent. Omission or null leaves the agent unnamed.
          name: nil,
          # Configuration for model reasoning. Omission uses the model's default effort.
          reasoning: nil,
          # The service tier used for model requests. Defaults to `auto`.
          service_tier: nil,
          # Configuration for generated text. Defaults to the `text` format and medium
          # verbosity.
          text: nil,
          # Tools available to the agent. Defaults to an empty list.
          tools: nil,
          request_options: {}
        )
        end

        # Retrieves a reusable agent by ID. See
        # [agent configuration](https://developers.openai.com/api/docs/guides/agents-api/configuration).
        sig { params(agent_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::Beta::Agent) }
        def retrieve(
          # The ID of the reusable agent.
          agent_id,
          request_options: {}
        )
        end

        # Updates a reusable agent. See
        # [agent configuration](https://developers.openai.com/api/docs/guides/agents-api/configuration).
        sig {
          params(
            agent_id: String,
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam::OrHash),
            name: T.nilable(String),
            reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam::OrHash),
            service_tier: T.nilable(OpenAI::Beta::AgentUpdateParams::ServiceTier::OrSymbol),
            text: T.nilable(OpenAI::Beta::AgentTextParam::OrHash),
            tools: T.nilable(
              T::Array[
                T.any(
                  OpenAI::Beta::PersistedAgentToolParam::Function::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::ToolSearch::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::ProgrammaticToolCalling::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::Mcp::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::WebSearch::OrHash
                )
              ]
            ),
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Beta::Agent)
        }
        def update(
          # The ID of the reusable agent.
          agent_id,
          # Additional instructions appended to the agent's default base instructions. Omit
          # to leave unchanged.
          instructions: nil,
          # Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          # characters.
          metadata: nil,
          # The model to use for the agent. The requested model name is preserved.
          model: nil,
          # Configuration for creating and coordinating subagents.
          multi_agent: nil,
          # A replacement name. Omit to leave unchanged, or pass null to clear it.
          name: nil,
          # Configuration for model reasoning. Omit to keep the current settings; pass
          # `null` to reset to the model's default effort.
          reasoning: nil,
          # The service tier used for model requests.
          service_tier: nil,
          # Configuration for text generated by the agent.
          text: nil,
          # Tools available to the agent.
          tools: nil,
          request_options: {}
        )
        end

        # Lists reusable agents in the current project. See
        # [agent configuration](https://developers.openai.com/api/docs/guides/agents-api/configuration).
        sig {
          params(
            after: String,
            limit: T.nilable(Integer),
            order: OpenAI::Beta::AgentListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agent])
        }
        def list(
          # Return resources after this resource ID in the selected order.
          after: nil,
          # The maximum number of resources to return.
          limit: nil,
          # The order in which resources are returned. Defaults to `desc`.
          order: nil,
          request_options: {}
        )
        end

        # Deletes a reusable agent. See
        # [agent configuration](https://developers.openai.com/api/docs/guides/agents-api/configuration).
        sig {
          params(agent_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::Beta::AgentDeleted)
        }
        def delete(
          # The ID of the reusable agent.
          agent_id,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end
