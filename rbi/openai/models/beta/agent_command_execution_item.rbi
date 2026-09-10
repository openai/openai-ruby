# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentCommandExecutionItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentCommandExecutionItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the command execution item.
        sig { returns(String) }
        attr_accessor :id

        # The command that was executed.
        sig { returns(String) }
        attr_accessor :command

        # The working directory used to execute the command.
        sig { returns(T.nilable(String)) }
        attr_accessor :cwd

        # The command duration in milliseconds.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :duration_ms

        # The process exit code, if the command completed.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :exit_code

        # The command output, if available.
        sig { returns(T.nilable(String)) }
        attr_accessor :output

        # The status of the command execution.
        sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `command_execution`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A command execution produced by the agent.
        sig do
          params(

            id: String,

            command: String,

            cwd: T.nilable(String),

            duration_ms: T.nilable(Integer),

            exit_code: T.nilable(Integer),

            output: T.nilable(String),

            status: OpenAI::Beta::AgentFunctionCallStatus::OrSymbol,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the command execution item.
          id:,

          # The command that was executed.
          command:,

          # The working directory used to execute the command.
          cwd:,

          # The command duration in milliseconds.
          duration_ms:,

          # The process exit code, if the command completed.
          exit_code:,

          # The command output, if available.
          output:,

          # The status of the command execution.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `command_execution`.

          type: :command_execution
        )
        end

        sig do
          override.returns(
            {
              id: String,
              command: String,
              cwd: T.nilable(String),
              duration_ms: T.nilable(Integer),
              exit_code: T.nilable(Integer),
              output: T.nilable(String),
              status: OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol,
              turn_id: String,
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
