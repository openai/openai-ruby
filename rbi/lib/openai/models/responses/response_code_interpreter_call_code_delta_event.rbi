# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDeltaEvent < OpenAI::Internal::Type::BaseModel
        # The partial code snippet added by the code interpreter.
        sig { returns(String) }
        attr_accessor :delta

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.code_interpreter_call.code.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a partial code snippet is added by the code interpreter.
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
