# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCodeInterpreterCallCompletedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # A tool call to run code.
        sig { returns(OpenAI::Responses::ResponseCodeInterpreterToolCall) }
        attr_reader :code_interpreter_call

        sig do
          params(
            code_interpreter_call:
              OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash
          ).void
        end
        attr_writer :code_interpreter_call

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.code_interpreter_call.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the code interpreter call is completed.
        sig do
          params(
            code_interpreter_call:
              OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A tool call to run code.
          code_interpreter_call:,
          # The index of the output item that the code interpreter call is in progress.
          output_index:,
          # The type of the event. Always `response.code_interpreter_call.completed`.
          type: :"response.code_interpreter_call.completed"
        )
        end

        sig do
          override.returns(
            {
              code_interpreter_call:
                OpenAI::Responses::ResponseCodeInterpreterToolCall,
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
