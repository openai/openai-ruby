# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInterpretingEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCodeInterpreterCallInterpretingEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique identifier of the code interpreter tool call item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response for which the code interpreter is
        # interpreting code.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event, used to order streaming events.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.code_interpreter_call.interpreting`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the code interpreter is actively interpreting the code snippet.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier of the code interpreter tool call item.
          item_id:,
          # The index of the output item in the response for which the code interpreter is
          # interpreting code.
          output_index:,
          # The sequence number of this event, used to order streaming events.
          sequence_number:,
          # The type of the event. Always `response.code_interpreter_call.interpreting`.
          type: :"response.code_interpreter_call.interpreting"
        )
        end

        sig do
          override.returns(
            {
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
