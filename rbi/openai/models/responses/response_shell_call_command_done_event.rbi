# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseShellCallCommandDoneEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseShellCallCommandDoneEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The final shell command that was emitted.
        sig { returns(String) }
        attr_accessor :command

        # The index of the shell command that was completed.
        sig { returns(Integer) }
        attr_accessor :command_index

        # The index of the output item that was updated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.shell_call_command.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A streaming event that indicated a shell command was completed.
        sig do
          params(

            command: String,

            command_index: Integer,

            output_index: Integer,

            sequence_number: Integer,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The final shell command that was emitted.
          command:,

          # The index of the shell command that was completed.
          command_index:,

          # The index of the output item that was updated.
          output_index:,

          # The sequence number of the event that was emitted.
          sequence_number:,

          # The type of the event, always `response.shell_call_command.done`.

          type: :"response.shell_call_command.done"
        )
        end

        sig do
          override.returns(
            {command: String, command_index: Integer, output_index: Integer, sequence_number: Integer, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
