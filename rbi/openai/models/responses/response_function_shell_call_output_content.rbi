# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionShellCallOutputContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseFunctionShellCallOutputContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The exit or timeout outcome associated with this shell call.
        sig do
          returns(
            T.any(
              OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout,
              OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit
            )
          )
        end
        attr_accessor :outcome

        # Captured stderr output for the shell call.
        sig { returns(String) }
        attr_accessor :stderr

        # Captured stdout output for the shell call.
        sig { returns(String) }
        attr_accessor :stdout

        # Captured stdout and stderr for a portion of a shell tool call output.
        sig do
          params(
            outcome:
              T.any(
                OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout::OrHash,
                OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit::OrHash
              ),
            stderr: String,
            stdout: String
          ).returns(T.attached_class)
        end
        def self.new(
          # The exit or timeout outcome associated with this shell call.
          outcome:,
          # Captured stderr output for the shell call.
          stderr:,
          # Captured stdout output for the shell call.
          stdout:
        )
        end

        sig do
          override.returns(
            {
              outcome:
                T.any(
                  OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout,
                  OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit
                ),
              stderr: String,
              stdout: String
            }
          )
        end
        def to_hash
        end

        # The exit or timeout outcome associated with this shell call.
        module Outcome
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout,
                OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit
              )
            end

          class Timeout < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout,
                  OpenAI::Internal::AnyHash
                )
              end

            # The outcome type. Always `timeout`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Indicates that the shell call exceeded its configured time limit.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(
              # The outcome type. Always `timeout`.
              type: :timeout
            )
            end

            sig { override.returns({ type: Symbol }) }
            def to_hash
            end
          end

          class Exit < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit,
                  OpenAI::Internal::AnyHash
                )
              end

            # The exit code returned by the shell process.
            sig { returns(Integer) }
            attr_accessor :exit_code

            # The outcome type. Always `exit`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Indicates that the shell commands finished and returned an exit code.
            sig do
              params(exit_code: Integer, type: Symbol).returns(T.attached_class)
            end
            def self.new(
              # The exit code returned by the shell process.
              exit_code:,
              # The outcome type. Always `exit`.
              type: :exit
            )
            end

            sig { override.returns({ exit_code: Integer, type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
