# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::BaseModel
        # The function-call arguments delta that is added.
        sig { returns(String) }
        def delta
        end

        sig { params(_: String).returns(String) }
        def delta=(_)
        end

        # The ID of the output item that the function-call arguments delta is added to.
        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        # The index of the output item that the function-call arguments delta is added to.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The type of the event. Always `response.function_call_arguments.delta`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when there is a partial function-call arguments delta.
        sig do
          params(
            delta: String,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(delta:, item_id:, output_index:, type: :"response.function_call_arguments.delta")
        end

        sig { override.returns({delta: String, item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
