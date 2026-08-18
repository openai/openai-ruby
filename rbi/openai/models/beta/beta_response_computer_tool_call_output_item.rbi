# typed: strong

module OpenAI
  module Models
    BetaResponseComputerToolCallOutputItem =
      Beta::BetaResponseComputerToolCallOutputItem

    module Beta
      class BetaResponseComputerToolCallOutputItem < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the computer call tool output.
        sig { returns(String) }
        attr_accessor :id

        # The ID of the computer tool call that produced the output.
        sig { returns(String) }
        attr_accessor :call_id

        # A computer screenshot image used with the computer use tool.
        sig do
          returns(OpenAI::Beta::BetaResponseComputerToolCallOutputScreenshot)
        end
        attr_reader :output

        sig do
          params(
            output:
              OpenAI::Beta::BetaResponseComputerToolCallOutputScreenshot::OrHash
          ).void
        end
        attr_writer :output

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        sig do
          returns(
            OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::TaggedSymbol
          )
        end
        attr_accessor :status

        # The type of the computer tool call output. Always `computer_call_output`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The safety checks reported by the API that have been acknowledged by the
        # developer.
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck
              ]
            )
          )
        end
        attr_reader :acknowledged_safety_checks

        sig do
          params(
            acknowledged_safety_checks:
              T::Array[
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck::OrHash
              ]
          ).void
        end
        attr_writer :acknowledged_safety_checks

        # The agent that produced this item.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # The identifier of the actor that created the item.
        sig { returns(T.nilable(String)) }
        attr_reader :created_by

        sig { params(created_by: String).void }
        attr_writer :created_by

        sig do
          params(
            id: String,
            call_id: String,
            output:
              OpenAI::Beta::BetaResponseComputerToolCallOutputScreenshot::OrHash,
            status:
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::OrSymbol,
            acknowledged_safety_checks:
              T::Array[
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck::OrHash
              ],
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Agent::OrHash
              ),
            created_by: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the computer call tool output.
          id:,
          # The ID of the computer tool call that produced the output.
          call_id:,
          # A computer screenshot image used with the computer use tool.
          output:,
          # The status of the message input. One of `in_progress`, `completed`, or
          # `incomplete`. Populated when input items are returned via API.
          status:,
          # The safety checks reported by the API that have been acknowledged by the
          # developer.
          acknowledged_safety_checks: nil,
          # The agent that produced this item.
          agent: nil,
          # The identifier of the actor that created the item.
          created_by: nil,
          # The type of the computer tool call output. Always `computer_call_output`.
          type: :computer_call_output
        )
        end

        sig do
          override.returns(
            {
              id: String,
              call_id: String,
              output:
                OpenAI::Beta::BetaResponseComputerToolCallOutputScreenshot,
              status:
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::TaggedSymbol,
              type: Symbol,
              acknowledged_safety_checks:
                T::Array[
                  OpenAI::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck
                ],
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Agent
                ),
              created_by: String
            }
          )
        end
        def to_hash
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETED =
            T.let(
              :completed,
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )
          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class AcknowledgedSafetyCheck < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck,
                OpenAI::Internal::AnyHash
              )
            end

          # The ID of the pending safety check.
          sig { returns(String) }
          attr_accessor :id

          # The type of the pending safety check.
          sig { returns(T.nilable(String)) }
          attr_accessor :code

          # Details about the pending safety check.
          sig { returns(T.nilable(String)) }
          attr_accessor :message

          # A pending safety check for the computer call.
          sig do
            params(
              id: String,
              code: T.nilable(String),
              message: T.nilable(String)
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the pending safety check.
            id:,
            # The type of the pending safety check.
            code: nil,
            # Details about the pending safety check.
            message: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                code: T.nilable(String),
                message: T.nilable(String)
              }
            )
          end
          def to_hash
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that produced this item.
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
