# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class McpRequireApprovalFilter < OpenAI::Internal::Type::BaseModel
        # @!attribute always
        #   A filter that forces approval for matching tools.
        #
        #   @return [OpenAI::Models::Live::McpToolFilter, nil]
        optional :always, -> { OpenAI::Live::McpToolFilter }, nil?: true

        # @!attribute never
        #   A filter that skips approval for matching tools.
        #
        #   @return [OpenAI::Models::Live::McpToolFilter, nil]
        optional :never, -> { OpenAI::Live::McpToolFilter }, nil?: true

        # @!method initialize(always: nil, never: nil)
        #   @param always [OpenAI::Models::Live::McpToolFilter, nil]
        #     A filter that forces approval for matching tools.
        #
        #   @param never [OpenAI::Models::Live::McpToolFilter, nil]
        #     A filter that skips approval for matching tools.
      end
    end
  end
end
