# typed: strong

module OpenAI
  module Models

    module Beta

      class MultiAgentConfigParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::MultiAgentConfigParam,
            OpenAI::Internal::AnyHash
          )
        end

        # Whether subagent tools are enabled.
        sig { returns(T::Boolean) }
        attr_accessor :enabled

        # Maximum number of subagents that may run concurrently. Defaults to 6.
        sig { returns(T.nilable(Integer)) }
        attr_reader :max_concurrent_subagents

        sig { params(max_concurrent_subagents: Integer).void }
        attr_writer :max_concurrent_subagents

        # Explicit configuration for creating and coordinating subagents.
        sig do
          params(

            enabled: T::Boolean,

            max_concurrent_subagents: Integer
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Whether subagent tools are enabled.
          enabled:,

          # Maximum number of subagents that may run concurrently. Defaults to 6.

          max_concurrent_subagents: nil
        )
        end

        sig do
          override.returns(
            {enabled: T::Boolean, max_concurrent_subagents: Integer}
          )
        end
        def to_hash
        end

      end

    end

  end
end
