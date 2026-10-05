# frozen_string_literal: true

require_relative "../beta/agents/tool_error"

module OpenAI
  module Helpers
    module Agents
      # @api private
      module Tools
        # @api private
        class ArgumentParsingError < StandardError
        end

        # Capture routing and detached arguments before caller code sees the event,
        # but defer the application callback until iteration resumes after yielding it.
        def self.prepare(call, handler, session_id:, on_tool_error: nil)
          base = {type: :"agent.session.input.tool_result", turn_id: call.turn_id.dup, call_id: call.call_id.dup}
          tool_name = call.name.dup
          arguments_error = nil
          arguments = begin
            JSON.parse(call.arguments.is_a?(String) ? call.arguments : JSON.generate(call.arguments))
          rescue StandardError => error
            arguments_error = error
            nil
          end

          lambda do
            stage = :arguments
            begin
              raise arguments_error if arguments_error
              raise ArgumentError, "Function arguments must be a JSON object" unless arguments.is_a?(Hash)

              stage = :execution
              output = handler.call(arguments)
              stage = :output
              output = JSON.generate(output) if output.is_a?(Hash)
              unless output.nil? || output.is_a?(String) || output.is_a?(Array)
                raise ArgumentError, "Tool output must be a string, object, content array, or nil"
              end

              serialized = JSON.generate(output)
              if output.is_a?(Array) && !content_output?(JSON.parse(serialized))
                raise ArgumentError, "Tool output array must contain input text or image content"
              end

              base.merge(success: true, output: output)
            rescue StandardError => error
              if error.is_a?(ArgumentParsingError)
                stage = :arguments
                error = error.cause
              end

              if on_tool_error
                failure = OpenAI::Helpers::Beta::Agents::ToolError.new(
                  error: error,
                  tool_name: tool_name,
                  session_id: session_id,
                  turn_id: base[:turn_id],
                  call_id: base[:call_id],
                  stage: stage
                )
                begin
                  on_tool_error.call(failure)
                rescue StandardError
                  # Diagnostics must not prevent submission of the original failure.
                end
              end

              base.merge(success: false, error: "Tool handler failed.")
            end
          end
        end

        def self.content_output?(parts)
          parts.all? do |part|
            next false unless part.is_a?(Hash)

            case part["type"]
            when "input_text"
              part["text"].is_a?(String)
            when "input_image"
              part["image_url"].is_a?(String)
            else
              false
            end
          end
        end

        def self.pending_call_race?(error, call_id)
          body = error.body
          body = body[:error] if body.is_a?(Hash) && body[:error].is_a?(Hash)
          body.is_a?(Hash) &&
            body[:code] == "invalid_request_error" &&
            body[:message] == "Unknown pending tool call: #{call_id}"
        end
      end
    end
  end
end
