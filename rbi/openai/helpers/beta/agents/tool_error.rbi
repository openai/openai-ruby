# typed: strong

module OpenAI
  module Helpers
    module Beta
      module Agents
        # Beta, local-only tool failure diagnostic.
        class ToolError
          sig { returns(StandardError) }
          attr_reader :error
          sig { returns(String) }
          attr_reader :tool_name, :session_id, :turn_id, :call_id
          sig { returns(Symbol) }
          attr_reader :stage
        end
      end
    end
  end
end
