# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInProgressEvent < OpenAI::BaseModel
        # A tool call to run code.
        sig { returns(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall) }
        def code_interpreter_call
        end

        sig do
          params(_: T.any(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Util::AnyHash))
        end
        def code_interpreter_call=(_)
        end

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The type of the event. Always `response.code_interpreter_call.in_progress`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when a code interpreter call is in progress.
        sig do
          params(
            code_interpreter_call: T.any(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Util::AnyHash),
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
