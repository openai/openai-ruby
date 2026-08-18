# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseShellCallCommandDeltaEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseShellCallCommandDeltaEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The index of the shell command that was updated.
        sig { returns(Integer) }
        attr_accessor :command_index

        # The shell command delta that was appended.
        sig { returns(String) }
        attr_accessor :delta

        # The index of the output item that was updated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.shell_call_command.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An obfuscation string that was added to pad the event payload.
        sig { returns(T.nilable(String)) }
        attr_reader :obfuscation

        sig { params(obfuscation: String).void }
        attr_writer :obfuscation

        # A streaming event that indicated a shell command was incrementally updated.
        sig do
          params(

            command_index: Integer,

            delta: String,

            output_index: Integer,

            sequence_number: Integer,

            obfuscation: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The index of the shell command that was updated.
          command_index:,

          # The shell command delta that was appended.
          delta:,

          # The index of the output item that was updated.
          output_index:,

          # The sequence number of the event that was emitted.
          sequence_number:,

          # An obfuscation string that was added to pad the event payload.
          obfuscation: nil,

          # The type of the event, always `response.shell_call_command.delta`.

          type: :"response.shell_call_command.delta"
        )
        end

        sig do
          override.returns(
            {
              command_index: Integer,
              delta: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              obfuscation: String
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
