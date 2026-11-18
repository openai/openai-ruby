# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class McpToolFilter < OpenAI::Internal::Type::BaseModel
        # @!attribute read_only
        #   Whether to allow only read-only tools for matching entries.
        #
        #   @return [Boolean, nil]
        optional :read_only, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute tool_names
        #   A list of tool names to match against.
        #
        #   @return [Array<String>, nil]
        optional :tool_names, OpenAI::Internal::Type::ArrayOf[String], nil?: true

        # @!method initialize(read_only: nil, tool_names: nil)
        #   @param read_only [Boolean, nil]
        #     Whether to allow only read-only tools for matching entries.
        #
        #   @param tool_names [Array<String>, nil]
        #     A list of tool names to match against.
      end
    end
  end
end
