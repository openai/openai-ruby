# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDoneEvent < OpenAI::BaseModel
        # The final code snippet output by the code interpreter.
        sig { returns(String) }
        def code
        end

        sig { params(_: String).returns(String) }
        def code=(_)
        end

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The type of the event. Always `response.code_interpreter_call.code.done`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when code snippet output is finalized by the code interpreter.
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
