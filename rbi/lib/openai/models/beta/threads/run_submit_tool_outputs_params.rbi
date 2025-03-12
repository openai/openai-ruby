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
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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
            sig { returns(T.nilable(String)) }
            def output
            end

            sig { params(_: String).returns(String) }
            def output=(_)
            end

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
