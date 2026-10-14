# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseShellCallOutputContentDoneEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseShellCallOutputContentDoneEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The index of the shell command that produced output.
        sig { returns(Integer) }
        attr_accessor :command_index

        # The ID of the output item that was updated.
        sig { returns(String) }
        attr_accessor :item_id

        # The output contents emitted for the shell command.
        sig { returns(T::Array[OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output]) }
        attr_accessor :output

        # The index of the output item that was updated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.shell_call_output_content.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A streaming event that indicated shell call output was completed.
        sig do
          params(

            command_index: Integer,

            item_id: String,

            output: T::Array[OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::OrHash],

            output_index: Integer,

            sequence_number: Integer,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The index of the shell command that produced output.
          command_index:,

          # The ID of the output item that was updated.
          item_id:,

          # The output contents emitted for the shell command.
          output:,

          # The index of the output item that was updated.
          output_index:,

          # The sequence number of the event that was emitted.
          sequence_number:,

          # The type of the event, always `response.shell_call_output_content.done`.

          type: :"response.shell_call_output_content.done"
        )
        end

        sig do
          override.returns(
            {
              command_index: Integer,
              item_id: String,
              output: T::Array[OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output],
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Output < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output,
              OpenAI::Internal::AnyHash
            )
          end

          # Represents either an exit outcome (with an exit code) or a timeout outcome for a
          # shell call output chunk.
          sig { returns(OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Variants) }
          attr_accessor :outcome

          # The standard error output that was captured.
          sig { returns(String) }
          attr_accessor :stderr

          # The standard output that was captured.
          sig { returns(String) }
          attr_accessor :stdout

          # The identifier of the actor that created the item.
          sig { returns(T.nilable(String)) }
          attr_reader :created_by

          sig { params(created_by: String).void }
          attr_writer :created_by

          # The content of a shell tool call output that was emitted.
          sig do
            params(

              outcome: T.any(
                OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout::OrHash,
                OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit::OrHash
              ),

              stderr: String,

              stdout: String,

              created_by: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Represents either an exit outcome (with an exit code) or a timeout outcome for a
            # shell call output chunk.
            outcome:,

            # The standard error output that was captured.
            stderr:,

            # The standard output that was captured.
            stdout:,

            # The identifier of the actor that created the item.

            created_by: nil
          )
          end

          sig do
            override.returns(
              {
                outcome: OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Variants,
                stderr: String,
                stdout: String,
                created_by: String
              }
            )
          end
          def to_hash
          end

          # Represents either an exit outcome (with an exit code) or a timeout outcome for a
          # shell call output chunk.
          module Outcome
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout,
                OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit
              )
            }

            class Timeout < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout,
                  OpenAI::Internal::AnyHash
                )
              end

              # The outcome type. Always `timeout`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Indicates that the shell call exceeded its configured time limit.
              sig do
                params(

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The outcome type. Always `timeout`.

                type: :timeout
              )
              end

              sig do
                override.returns(
                  {type: Symbol}
                )
              end
              def to_hash
              end

            end

            class Exit < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit,
                  OpenAI::Internal::AnyHash
                )
              end

              # Exit code from the shell process.
              sig { returns(Integer) }
              attr_accessor :exit_code

              # The outcome type. Always `exit`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Indicates that the shell commands finished and returned an exit code.
              sig do
                params(

                  exit_code: Integer,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Exit code from the shell process.
                exit_code:,

                # The outcome type. Always `exit`.

                type: :exit
              )
              end

              sig do
                override.returns(
                  {exit_code: Integer, type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig {
              override.returns(
                T::Array[OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Variants]
              )
            }
            def self.variants
            end

          end
        end

      end

    end

  end
end
