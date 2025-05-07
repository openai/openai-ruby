# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # A tool call to run code.
        sig { returns(OpenAI::Responses::ResponseCodeInterpreterToolCall) }
        attr_reader :code_interpreter_call

        sig do
          params(
            code_interpreter_call:
              OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash
          ).void
        end
        attr_writer :code_interpreter_call

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.code_interpreter_call.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a code interpreter call is in progress.
        sig do
          params(
            code_interpreter_call:
              OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A tool call to run code.
          code_interpreter_call:,
          # The index of the output item that the code interpreter call is in progress.
          output_index:,
          # The type of the event. Always `response.code_interpreter_call.in_progress`.
          type: :"response.code_interpreter_call.in_progress"
        )
        end

        sig do
          override.returns(
            {
              code_interpreter_call:
                OpenAI::Responses::ResponseCodeInterpreterToolCall,
              output_index: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
