# typed: strong

module OpenAI
  module Models
    BetaResponseShellCallCommandDeltaEvent =
      Beta::BetaResponseShellCallCommandDeltaEvent

    module Beta
      class BetaResponseShellCallCommandDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent,
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

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent::Agent::OrHash
          ).void
        end
        attr_writer :agent

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
            agent:
              OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent::Agent::OrHash,
            obfuscation: String,
            type: Symbol
          ).returns(T.attached_class)
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
          # The agent that owns this multi-agent streaming event.
          agent: nil,
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
              agent:
                OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent::Agent,
              obfuscation: String
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent::Agent,
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
