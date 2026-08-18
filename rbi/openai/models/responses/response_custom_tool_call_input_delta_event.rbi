# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCustomToolCallInputDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCustomToolCallInputDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The incremental input data (delta) for the custom tool call.
        sig { returns(String) }
        attr_accessor :delta

        # Unique identifier for the API item associated with this event.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output this delta applies to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The event type identifier.
        sig { returns(Symbol) }
        attr_accessor :type

        # Event representing a delta (partial update) to the input of a custom tool call.
        sig do
          params(
            delta: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The incremental input data (delta) for the custom tool call.
          delta:,
          # Unique identifier for the API item associated with this event.
          item_id:,
          # The index of the output this delta applies to.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The event type identifier.
          type: :"response.custom_tool_call_input.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
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
