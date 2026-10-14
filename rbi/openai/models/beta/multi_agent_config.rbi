# typed: strong

module OpenAI
  module Models

    module Beta

      class MultiAgentConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::MultiAgentConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # Whether subagent tools are enabled. Defaults to false.
        sig { returns(T::Boolean) }
        attr_accessor :enabled

        # Maximum number of subagents that may run concurrently, or null when disabled.
        # Defaults to 6 when enabled.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_concurrent_subagents

        # The resolved configuration for creating and coordinating subagents.
        sig do
          params(

            enabled: T::Boolean,

            max_concurrent_subagents: T.nilable(Integer)
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Whether subagent tools are enabled. Defaults to false.
          enabled:,

          # Maximum number of subagents that may run concurrently, or null when disabled.
          # Defaults to 6 when enabled.

          max_concurrent_subagents:
        )
        end

        sig do
          override.returns(
            {enabled: T::Boolean, max_concurrent_subagents: T.nilable(Integer)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
