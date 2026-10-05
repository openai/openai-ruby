# frozen_string_literal: true

module OpenAI
  module Helpers
    module Beta
      module Agents
        # Beta, local-only diagnostic delivered to sessions.stream(on_tool_error:).
        # Use alongside tool_handlers for logging or monitoring argument parsing,
        # handler execution, and output conversion failures, not API/transport errors.
        # The original exception may contain sensitive application data.
        class ToolError
          attr_reader :error, :tool_name, :session_id, :turn_id, :call_id, :stage

          # @api private
          def initialize(error:, tool_name:, session_id:, turn_id:, call_id:, stage:)
            @error = error
            @tool_name = tool_name.dup.freeze
            @session_id = session_id.dup.freeze
            @turn_id = turn_id.dup.freeze
            @call_id = call_id.dup.freeze
            @stage = stage
            freeze
          end
        end
      end
    end
  end
end
