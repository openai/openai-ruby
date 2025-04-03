# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInterpretingEvent < OpenAI::Internal::Type::BaseModel
        # A tool call to run code.
        sig { returns(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall) }
        attr_reader :code_interpreter_call

        sig do
          params(
            code_interpreter_call: T.any(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :code_interpreter_call

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.code_interpreter_call.interpreting`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the code interpreter is actively interpreting the code snippet.
        sig do
          params(
            code_interpreter_call: T.any(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Internal::AnyHash),
            output_index: Integer,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          code_interpreter_call:,
          output_index:,
          type: :"response.code_interpreter_call.interpreting"
        )
        end

        sig do
          override
            .returns(
              {
                code_interpreter_call: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall,
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
