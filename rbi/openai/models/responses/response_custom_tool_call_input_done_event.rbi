# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCustomToolCallInputDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCustomToolCallInputDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The complete input data for the custom tool call.
        sig { returns(String) }
        attr_accessor :input

        # Unique identifier for the API item associated with this event.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output this event applies to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The event type identifier.
        sig { returns(Symbol) }
        attr_accessor :type

        # Event indicating that input for a custom tool call is complete.
        sig do
          params(
            input: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The complete input data for the custom tool call.
          input:,
          # Unique identifier for the API item associated with this event.
          item_id:,
          # The index of the output this event applies to.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The event type identifier.
          type: :"response.custom_tool_call_input.done"
        )
        end

        sig do
          override.returns(
            {
              input: String,
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
