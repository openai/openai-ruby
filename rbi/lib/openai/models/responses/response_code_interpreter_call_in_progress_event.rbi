# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInProgressEvent < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall) }
        def code_interpreter_call
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall)
            .returns(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall)
        end
        def code_interpreter_call=(_)
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
            code_interpreter_call: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall,
            output_index: Integer,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(code_interpreter_call:, output_index:, type: :"response.code_interpreter_call.in_progress")
        end

        sig do
          override
            .returns(
              {
                code_interpreter_call: OpenAI::Models::Responses::ResponseCodeInterpreterToolCall,
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
