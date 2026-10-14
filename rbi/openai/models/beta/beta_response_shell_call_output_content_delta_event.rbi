# typed: strong

module OpenAI
  module Models

    BetaResponseShellCallOutputContentDeltaEvent = Beta::BetaResponseShellCallOutputContentDeltaEvent

    module Beta

      class BetaResponseShellCallOutputContentDeltaEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The index of the shell command that produced output.
        sig { returns(Integer) }
        attr_accessor :command_index

        # The stdout/stderr delta that was emitted.
        sig { returns(OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta) }
        attr_reader :delta

        sig { params(delta: OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta::OrHash).void }
        attr_writer :delta

        # The ID of the output item that was updated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that was updated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.shell_call_output_content.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent)) }
        attr_reader :agent

        sig { params(agent: OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent::OrHash).void }
        attr_writer :agent

        # A streaming event that indicated shell call output was incrementally added.
        sig do
          params(

            command_index: Integer,

            delta: OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta::OrHash,

            item_id: String,

            output_index: Integer,

            sequence_number: Integer,

            agent: OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The index of the shell command that produced output.
          command_index:,

          # The stdout/stderr delta that was emitted.
          delta:,

          # The ID of the output item that was updated.
          item_id:,

          # The index of the output item that was updated.
          output_index:,

          # The sequence number of the event that was emitted.
          sequence_number:,

          # The agent that owns this multi-agent streaming event.
          agent: nil,

          # The type of the event, always `response.shell_call_output_content.delta`.

          type: :"response.shell_call_output_content.delta"
        )
        end

        sig do
          override.returns(
            {
              command_index: Integer,
              delta: OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent: OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent
            }
          )
        end
        def to_hash
        end

        class Delta < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta,
              OpenAI::Internal::AnyHash
            )
          end

          # The stderr delta that was emitted.
          sig { returns(T.nilable(String)) }
          attr_reader :stderr

          sig { params(stderr: String).void }
          attr_writer :stderr

          # The stdout delta that was emitted.
          sig { returns(T.nilable(String)) }
          attr_reader :stdout

          sig { params(stdout: String).void }
          attr_writer :stdout

          # The stdout/stderr delta that was emitted.
          sig do
            params(

              stderr: String,

              stdout: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The stderr delta that was emitted.
            stderr: nil,

            # The stdout delta that was emitted.

            stdout: nil
          )
          end

          sig do
            override.returns(
              {stderr: String, stdout: String}
            )
          end
          def to_hash
          end

        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent,
              OpenAI::Internal::AnyHash
            )
          end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig do
            params(

              agent_name: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The canonical name of the agent that produced this item.

            agent_name:
          )
          end

          sig do
            override.returns(
              {agent_name: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
