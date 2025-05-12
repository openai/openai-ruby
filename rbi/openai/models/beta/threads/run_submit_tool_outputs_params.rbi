# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunSubmitToolOutputsParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::RunSubmitToolOutputsParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :thread_id

          # A list of tools for which the outputs are being submitted.
          sig do
            returns(
              T::Array[
                OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput
              ]
            )
          end
          attr_accessor :tool_outputs

          sig do
            params(
              thread_id: String,
              tool_outputs:
                T::Array[
                  OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput::OrHash
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            thread_id:,
            # A list of tools for which the outputs are being submitted.
            tool_outputs:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                thread_id: String,
                tool_outputs:
                  T::Array[
                    OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput
                  ],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          class ToolOutput < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput,
                  OpenAI::Internal::AnyHash
                )
              end

            # The output of the tool call to be submitted to continue the run.
            sig { returns(T.nilable(String)) }
            attr_reader :output

            sig { params(output: String).void }
            attr_writer :output

            # The ID of the tool call in the `required_action` object within the run object
            # the output is being submitted for.
            sig { returns(T.nilable(String)) }
            attr_reader :tool_call_id

            sig { params(tool_call_id: String).void }
            attr_writer :tool_call_id

            sig do
              params(output: String, tool_call_id: String).returns(
                T.attached_class
              )
            end
            def self.new(
              # The output of the tool call to be submitted to continue the run.
              output: nil,
              # The ID of the tool call in the `required_action` object within the run object
              # the output is being submitted for.
              tool_call_id: nil
            )
            end

            sig { override.returns({ output: String, tool_call_id: String }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
