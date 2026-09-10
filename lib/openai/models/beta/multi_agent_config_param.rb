# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class MultiAgentConfigParam < OpenAI::Internal::Type::BaseModel
        # @!attribute enabled
        #   Whether subagent tools are enabled.
        #
        #   @return [Boolean]
        required :enabled, OpenAI::Internal::Type::Boolean

        # @!attribute max_concurrent_subagents
        #   Maximum number of subagents that may run concurrently. Defaults to 6.
        #
        #   @return [Integer, nil]
        optional :max_concurrent_subagents, Integer

        # @!method initialize(enabled:, max_concurrent_subagents: nil)
        #   Explicit configuration for creating and coordinating subagents.
        #
        #   @param enabled [Boolean]
        #     Whether subagent tools are enabled.
        #
        #   @param max_concurrent_subagents [Integer]
        #     Maximum number of subagents that may run concurrently. Defaults to 6.
      end
    end
  end
end
