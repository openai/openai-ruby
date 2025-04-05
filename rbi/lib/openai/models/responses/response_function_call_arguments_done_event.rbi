# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        # The function-call arguments.
        sig { returns(String) }
        attr_accessor :arguments

        # The ID of the item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item.
        sig { returns(Integer) }
        attr_accessor :output_index

        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when function-call arguments are finalized.
        sig do
          params(
            arguments: String,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(arguments:, item_id:, output_index:, type: :"response.function_call_arguments.done"); end

        sig { override.returns({arguments: String, item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end
