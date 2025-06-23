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

        # The unique identifier of the code interpreter tool call item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response for which the code is finalized.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event, used to order streaming events.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.code_interpreter_call_code.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the code snippet is finalized by the code interpreter.
        sig do
          params(
            code: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The final code snippet output by the code interpreter.
          code:,
          # The unique identifier of the code interpreter tool call item.
          item_id:,
          # The index of the output item in the response for which the code is finalized.
          output_index:,
          # The sequence number of this event, used to order streaming events.
          sequence_number:,
          # The type of the event. Always `response.code_interpreter_call_code.done`.
          type: :"response.code_interpreter_call_code.done"
        )
        end

        sig do
          override.returns(
            {
              code: String,
              item_id: String,
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
