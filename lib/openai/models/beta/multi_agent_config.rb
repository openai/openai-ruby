# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class MultiAgentConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute enabled
        #   Whether subagent tools are enabled. Defaults to false.
        #
        #   @return [Boolean]
        required :enabled, OpenAI::Internal::Type::Boolean

        # @!attribute max_concurrent_subagents
        #   Maximum number of subagents that may run concurrently, or null when disabled.
        #   Defaults to 6 when enabled.
        #
        #   @return [Integer, nil]
        required :max_concurrent_subagents, Integer, nil?: true

        # @!method initialize(enabled:, max_concurrent_subagents:)
        #   The resolved configuration for creating and coordinating subagents.
        #
        #   @param enabled [Boolean]
        #     Whether subagent tools are enabled. Defaults to false.
        #
        #   @param max_concurrent_subagents [Integer, nil]
        #     Maximum number of subagents that may run concurrently, or null when disabled.
        #     Defaults to 6 when enabled.
      end
    end
  end
end
