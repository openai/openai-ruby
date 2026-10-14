# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          # Submit input to an idle session and stream one turn through idle or failure.
          # The caller must be the session's only input writer during iteration.
          # Handlers run sequentially; failures submit a generic error without exception text.
          # Input and each tool result use distinct retry-safe idempotency keys.
          # A block closes the connection on every exit path without cancelling the turn.
          #
          # @param session_id [String]
          # @param input [String, Array<OpenAI::Models::Beta::AgentSessionInputMessageParam>]
          # @param tool_handlers [Hash{String=>Proc}]
          # @param on_tool_error [Proc, nil]
          #   Beta: use with tool_handlers to log or monitor argument parsing, handler
          #   execution, and output conversion failures locally. Receives ToolError;
          #   API/transport errors still propagate normally. Ordinary observer errors
          #   are ignored, and the submitted tool failure stays generic.
          # @param idempotency_key [String, nil] Applies only to the input submission.
          # @param output_type [Class<OpenAI::BaseModel>, nil] Beta: parse output without changing session configuration.
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          # @yieldparam stream [OpenAI::Helpers::Agents::SessionStream]
          # @return [OpenAI::Helpers::Agents::SessionStream]
          def stream(
            session_id,
            input:,
            tool_handlers: {},
            on_tool_error: nil,
            idempotency_key: nil,
            output_type: nil,
            request_options: {}
          )
            stream = OpenAI::Helpers::Agents::SessionStream.new(
              sessions: self,
              session_id: session_id,
              input: input,
              tool_handlers: tool_handlers,
              on_tool_error: on_tool_error,
              idempotency_key: idempotency_key,
              output_type: output_type,
              request_options: request_options
            )
            return stream unless block_given?

            begin
              yield stream
            ensure
              stream.close
            end

            stream
          end
        end
      end
    end
  end
end
