# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The function-call arguments.
        sig { returns(String) }
        attr_accessor :arguments

        # The ID of the item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when function-call arguments are finalized.
        sig do
          params(
            arguments: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The function-call arguments.
          arguments:,
          # The ID of the item.
          item_id:,
          # The index of the output item.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          type: :"response.function_call_arguments.done"
        )
        end

        sig do
          override.returns(
            {
              arguments: String,
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
