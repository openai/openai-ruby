# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The function-call arguments delta that is added.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the output item that the function-call arguments delta is added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the function-call arguments delta is added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.function_call_arguments.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a partial function-call arguments delta.
        sig do
          params(
            delta: String,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The function-call arguments delta that is added.
          delta:,
          # The ID of the output item that the function-call arguments delta is added to.
          item_id:,
          # The index of the output item that the function-call arguments delta is added to.
          output_index:,
          # The type of the event. Always `response.function_call_arguments.delta`.
          type: :"response.function_call_arguments.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              item_id: String,
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
