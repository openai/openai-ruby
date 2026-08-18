# typed: strong

module OpenAI
  module Models
    BetaResponseShellCallCommandAddedEvent =
      Beta::BetaResponseShellCallCommandAddedEvent

    module Beta
      class BetaResponseShellCallCommandAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseShellCallCommandAddedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The shell command that was added.
        sig { returns(String) }
        attr_accessor :command

        # The index of the shell command that was added.
        sig { returns(Integer) }
        attr_accessor :command_index

        # The index of the output item that was updated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.shell_call_command.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseShellCallCommandAddedEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              OpenAI::Beta::BetaResponseShellCallCommandAddedEvent::Agent::OrHash
          ).void
        end
        attr_writer :agent

        # A streaming event that indicated a shell command was added to a tool call.
        sig do
          params(
            command: String,
            command_index: Integer,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              OpenAI::Beta::BetaResponseShellCallCommandAddedEvent::Agent::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The shell command that was added.
          command:,
          # The index of the shell command that was added.
          command_index:,
          # The index of the output item that was updated.
          output_index:,
          # The sequence number of the event that was emitted.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event, always `response.shell_call_command.added`.
          type: :"response.shell_call_command.added"
        )
        end

        sig do
          override.returns(
            {
              command: String,
              command_index: Integer,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent: OpenAI::Beta::BetaResponseShellCallCommandAddedEvent::Agent
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseShellCallCommandAddedEvent::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
