# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCodeInterpreterCallCodeDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The partial code snippet added by the code interpreter.
        sig { returns(String) }
        attr_accessor :delta

        # The index of the output item that the code interpreter call is in progress.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.code_interpreter_call_code.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a partial code snippet is added by the code interpreter.
        sig do
          params(
            delta: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The partial code snippet added by the code interpreter.
          delta:,
          # The index of the output item that the code interpreter call is in progress.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.code_interpreter_call_code.delta`.
          type: :"response.code_interpreter_call_code.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
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
