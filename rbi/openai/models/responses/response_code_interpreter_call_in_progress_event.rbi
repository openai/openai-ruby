# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCodeInterpreterCallInProgressEvent,
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

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.code_interpreter_call.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a code interpreter call is in progress.
        sig do
          params(
            code_interpreter_call:
              OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A tool call to run code.
          code_interpreter_call:,
          # The index of the output item that the code interpreter call is in progress.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.code_interpreter_call.in_progress`.
          type: :"response.code_interpreter_call.in_progress"
        )
        end

        sig do
          override.returns(
            {
              code_interpreter_call:
                OpenAI::Responses::ResponseCodeInterpreterToolCall,
              output_index: Integer,
              sequence_number: Integer,
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
