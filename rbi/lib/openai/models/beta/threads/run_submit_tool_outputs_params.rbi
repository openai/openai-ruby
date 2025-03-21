# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunSubmitToolOutputsParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          sig { returns(String) }
          def thread_id
          end

          sig { params(_: String).returns(String) }
          def thread_id=(_)
          end

          # A list of tools for which the outputs are being submitted.
          sig { returns(T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput]) }
          def tool_outputs
          end

          sig do
            params(_: T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput])
              .returns(T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput])
          end
          def tool_outputs=(_)
          end

          sig do
            params(
              thread_id: String,
              tool_outputs: T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput],
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(thread_id:, tool_outputs:, request_options: {})
          end

          sig do
            override
              .returns(
                {
                  thread_id: String,
                  tool_outputs: T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput],
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash
          end

          class ToolOutput < OpenAI::BaseModel
            # The output of the tool call to be submitted to continue the run.
            sig { returns(T.nilable(String)) }
            def output
            end

            sig { params(_: String).returns(String) }
            def output=(_)
            end

            # The ID of the tool call in the `required_action` object within the run object
            #   the output is being submitted for.
            sig { returns(T.nilable(String)) }
            def tool_call_id
            end

            sig { params(_: String).returns(String) }
            def tool_call_id=(_)
            end

            sig { params(output: String, tool_call_id: String).returns(T.attached_class) }
            def self.new(output: nil, tool_call_id: nil)
            end

            sig { override.returns({output: String, tool_call_id: String}) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
