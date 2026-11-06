# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentCreateParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentCreateParams,
            OpenAI::Internal::AnyHash
          )
        end

        # The model to use for the agent. The requested model name is preserved.
        sig { returns(String) }
        attr_accessor :model

        # Context compaction settings. Omission or null enables background compaction.
        sig { returns(T.nilable(OpenAI::Beta::AgentCreateParams::Compaction)) }
        attr_reader :compaction

        sig { params(compaction: T.nilable(OpenAI::Beta::AgentCreateParams::Compaction::OrHash)).void }
        attr_writer :compaction

        # Experimental agent settings. All experimental features default to disabled.
        sig { returns(T.nilable(OpenAI::Beta::AgentCreateParams::Experimental)) }
        attr_reader :experimental

        sig { params(experimental: OpenAI::Beta::AgentCreateParams::Experimental::OrHash).void }
        attr_writer :experimental

        # Additional instructions appended to the agent's default base instructions. Omit
        # or set to null to add no custom instructions.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
        # characters. Omission or null defaults to an empty map.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # Configuration for creating and coordinating subagents. Subagent tools are
        # disabled by default.
        sig { returns(T.nilable(OpenAI::Beta::MultiAgentConfigParam)) }
        attr_reader :multi_agent

        sig { params(multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam::OrHash)).void }
        attr_writer :multi_agent

        # A human-readable name for the agent. Omission or null leaves the agent unnamed.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # Configuration for model reasoning. Omission uses the model's default effort.
        sig { returns(T.nilable(OpenAI::Beta::AgentReasoningParam)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam::OrHash)).void }
        attr_writer :reasoning

        # The service tier used for model requests. Defaults to `auto`.
        sig { returns(T.nilable(OpenAI::Beta::AgentCreateParams::ServiceTier::OrSymbol)) }
        attr_accessor :service_tier

        # Configuration for generated text. Defaults to the `text` format and medium
        # verbosity.
        sig { returns(T.nilable(OpenAI::Beta::AgentTextParam)) }
        attr_reader :text

        sig { params(text: T.nilable(OpenAI::Beta::AgentTextParam::OrHash)).void }
        attr_writer :text

        # Tools available to the agent. Defaults to an empty list. The tool list must fit
        # within 3 MiB (3,145,728 bytes) of compact UTF-8 JSON.
        sig {
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Beta::PersistedAgentToolParam::Function,
                  OpenAI::Beta::PersistedAgentToolParam::ToolSearch,
                  OpenAI::Beta::PersistedAgentToolParam::ProgrammaticToolCalling,
                  OpenAI::Beta::PersistedAgentToolParam::Mcp,
                  OpenAI::Beta::PersistedAgentToolParam::WebSearch,
                  OpenAI::Beta::PersistedAgentToolParam::ComputerUse,
                  OpenAI::Beta::PersistedAgentToolParam::Automations
                )
              ]
            )
          )
        }
        attr_accessor :tools

        sig do
          params(

            model: String,

            compaction: T.nilable(OpenAI::Beta::AgentCreateParams::Compaction::OrHash),

            experimental: OpenAI::Beta::AgentCreateParams::Experimental::OrHash,

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
                  OpenAI::Beta::PersistedAgentToolParam::WebSearch::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::ComputerUse::OrHash,
                  OpenAI::Beta::PersistedAgentToolParam::Automations::OrHash
                )
              ]
            ),

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The model to use for the agent. The requested model name is preserved.
          model:,

          # Context compaction settings. Omission or null enables background compaction.
          compaction: nil,

          # Experimental agent settings. All experimental features default to disabled.
          experimental: nil,

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

          # Tools available to the agent. Defaults to an empty list. The tool list must fit
          # within 3 MiB (3,145,728 bytes) of compact UTF-8 JSON.
          tools: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              model: String,
              compaction: T.nilable(OpenAI::Beta::AgentCreateParams::Compaction),
              experimental: OpenAI::Beta::AgentCreateParams::Experimental,
              instructions: T.nilable(String),
              metadata: T.nilable(T::Hash[Symbol, String]),
              multi_agent: T.nilable(OpenAI::Beta::MultiAgentConfigParam),
              name: T.nilable(String),
              reasoning: T.nilable(OpenAI::Beta::AgentReasoningParam),
              service_tier: T.nilable(OpenAI::Beta::AgentCreateParams::ServiceTier::OrSymbol),
              text: T.nilable(OpenAI::Beta::AgentTextParam),
              tools: T.nilable(
                T::Array[
                  T.any(
                    OpenAI::Beta::PersistedAgentToolParam::Function,
                    OpenAI::Beta::PersistedAgentToolParam::ToolSearch,
                    OpenAI::Beta::PersistedAgentToolParam::ProgrammaticToolCalling,
                    OpenAI::Beta::PersistedAgentToolParam::Mcp,
                    OpenAI::Beta::PersistedAgentToolParam::WebSearch,
                    OpenAI::Beta::PersistedAgentToolParam::ComputerUse,
                    OpenAI::Beta::PersistedAgentToolParam::Automations
                  )
                ]
              ),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        class Compaction < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentCreateParams::Compaction,
              OpenAI::Internal::AnyHash
            )
          end

          # Whether to compact context in the background. Omission or null defaults to true.
          # Set to false to use blocking compaction. Background compaction may increase
          # token usage.
          sig { returns(T.nilable(T::Boolean)) }
          attr_accessor :async

          # Context compaction settings. Omission or null enables background compaction.
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
              OpenAI::Beta::AgentCreateParams::Experimental,
              OpenAI::Internal::AnyHash
            )
          end

          # Whether to give the model periodic current-time reminders. Defaults to false.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :time_awareness

          sig { params(time_awareness: T::Boolean).void }
          attr_writer :time_awareness

          # Experimental agent settings. All experimental features default to disabled.
          sig do
            params(

              time_awareness: T::Boolean
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Whether to give the model periodic current-time reminders. Defaults to false.

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

        # The service tier used for model requests. Defaults to `auto`.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentCreateParams::ServiceTier) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # Selects the service tier automatically.
          AUTO = T.let(:auto, OpenAI::Beta::AgentCreateParams::ServiceTier::TaggedSymbol)

          # Uses the default service tier.
          DEFAULT = T.let(:default, OpenAI::Beta::AgentCreateParams::ServiceTier::TaggedSymbol)

          # Uses the flex service tier.
          FLEX = T.let(:flex, OpenAI::Beta::AgentCreateParams::ServiceTier::TaggedSymbol)

          # Uses the priority service tier.
          PRIORITY = T.let(:priority, OpenAI::Beta::AgentCreateParams::ServiceTier::TaggedSymbol)

          # Uses the fast service tier.
          FAST = T.let(:fast, OpenAI::Beta::AgentCreateParams::ServiceTier::TaggedSymbol)

          # Uses the ultrafast service tier.
          ULTRAFAST = T.let(:ultrafast, OpenAI::Beta::AgentCreateParams::ServiceTier::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentCreateParams::ServiceTier::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
