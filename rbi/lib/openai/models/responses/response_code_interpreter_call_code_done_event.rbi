# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDoneEvent < OpenAI::BaseModel
        sig { returns(String) }
        def code
        end

        sig { params(_: String).returns(String) }
        def code=(_)
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

        sig { params(code: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(code:, output_index:, type: :"response.code_interpreter_call.code.done")
        end

        sig { override.returns({code: String, output_index: Integer, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
