# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunSubmitToolOutputsParams < OpenAI::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          sig { returns(String) }
          attr_accessor :thread_id

          # A list of tools for which the outputs are being submitted.
          sig { returns(T::Array[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput]) }
          attr_accessor :tool_outputs

          sig do
            params(
              thread_id: String,
              tool_outputs: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput,
                OpenAI::Internal::Util::AnyHash
              )
              ],
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash)
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
            attr_reader :output

            sig { params(output: String).void }
            attr_writer :output

            # The ID of the tool call in the `required_action` object within the run object
            #   the output is being submitted for.
            sig { returns(T.nilable(String)) }
            attr_reader :tool_call_id

            sig { params(tool_call_id: String).void }
            attr_writer :tool_call_id

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
