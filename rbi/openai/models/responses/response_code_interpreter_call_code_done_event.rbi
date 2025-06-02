# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCodeInterpreterCallCodeDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The final code snippet output by the code interpreter.
        sig { returns(String) }
        attr_accessor :code

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.code_interpreter_call_code.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when code snippet output is finalized by the code interpreter.
        sig do
          params(
            code: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The final code snippet output by the code interpreter.
          code:,
          # The index of the output item that the code interpreter call is in progress.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.code_interpreter_call_code.done`.
          type: :"response.code_interpreter_call_code.done"
        )
        end

        sig do
          override.returns(
            {
              code: String,
              output_index: Integer,
              sequence_number: Integer,
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
