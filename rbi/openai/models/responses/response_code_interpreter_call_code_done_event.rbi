# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDoneEvent < OpenAI::Internal::Type::BaseModel
        # The final code snippet output by the code interpreter.
        sig { returns(String) }
        attr_accessor :code

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.code_interpreter_call.code.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when code snippet output is finalized by the code interpreter.
        sig { params(code: String, output_index: Integer, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The final code snippet output by the code interpreter.
          code:,
          # The index of the output item that the code interpreter call is in progress.
          output_index:,
          # The type of the event. Always `response.code_interpreter_call.code.done`.
          type: :"response.code_interpreter_call.code.done"
        ); end
        sig { override.returns({code: String, output_index: Integer, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end
