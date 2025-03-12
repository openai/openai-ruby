# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDeltaEvent < OpenAI::BaseModel
        sig { returns(String) }
        def delta
        end

        sig { params(_: String).returns(String) }
        def delta=(_)
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

        sig { params(delta: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(delta:, output_index:, type: :"response.code_interpreter_call.code.delta")
        end

        sig { override.returns({delta: String, output_index: Integer, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
