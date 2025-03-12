# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionCallArgumentsDoneEvent < OpenAI::BaseModel
        sig { returns(String) }
        def arguments
        end

        sig { params(_: String).returns(String) }
        def arguments=(_)
        end

        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            arguments: String,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(arguments:, item_id:, output_index:, type: :"response.function_call_arguments.done")
        end

        sig { override.returns({arguments: String, item_id: String, output_index: Integer, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
