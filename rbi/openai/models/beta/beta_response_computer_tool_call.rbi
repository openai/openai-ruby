# typed: strong

module OpenAI
  module Models
    BetaResponseComputerToolCall = Beta::BetaResponseComputerToolCall

    module Beta
      class BetaResponseComputerToolCall < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseComputerToolCall,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the computer call.
        sig { returns(String) }
        attr_accessor :id

        # An identifier used when responding to the tool call with output.
        sig { returns(String) }
        attr_accessor :call_id

        # The pending safety checks for the computer call.
        sig do
          returns(
            T::Array[
              OpenAI::Beta::BetaResponseComputerToolCall::PendingSafetyCheck
            ]
          )
        end
        attr_accessor :pending_safety_checks

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig do
          returns(OpenAI::Beta::BetaResponseComputerToolCall::Status::OrSymbol)
        end
        attr_accessor :status

        # The type of the computer call. Always `computer_call`.
        sig do
          returns(OpenAI::Beta::BetaResponseComputerToolCall::Type::OrSymbol)
        end
        attr_accessor :type

        # A click action.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Beta::BetaComputerAction::Click,
                OpenAI::Beta::BetaComputerAction::DoubleClick,
                OpenAI::Beta::BetaComputerAction::Drag,
                OpenAI::Beta::BetaComputerAction::Keypress,
                OpenAI::Beta::BetaComputerAction::Move,
                OpenAI::Beta::BetaComputerAction::Screenshot,
                OpenAI::Beta::BetaComputerAction::Scroll,
                OpenAI::Beta::BetaComputerAction::Type,
                OpenAI::Beta::BetaComputerAction::Wait
              )
            )
          )
        end
        attr_reader :action

        sig do
          params(
            action:
              T.any(
                OpenAI::Beta::BetaComputerAction::Click::OrHash,
                OpenAI::Beta::BetaComputerAction::DoubleClick::OrHash,
                OpenAI::Beta::BetaComputerAction::Drag::OrHash,
                OpenAI::Beta::BetaComputerAction::Keypress::OrHash,
                OpenAI::Beta::BetaComputerAction::Move::OrHash,
                OpenAI::Beta::BetaComputerAction::Screenshot::OrHash,
                OpenAI::Beta::BetaComputerAction::Scroll::OrHash,
                OpenAI::Beta::BetaComputerAction::Type::OrHash,
                OpenAI::Beta::BetaComputerAction::Wait::OrHash
              )
          ).void
        end
        attr_writer :action

        # Flattened batched actions for `computer_use`. Each action includes an `type`
        # discriminator and action-specific fields.
        sig do
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Beta::BetaComputerAction::Click,
                  OpenAI::Beta::BetaComputerAction::DoubleClick,
                  OpenAI::Beta::BetaComputerAction::Drag,
                  OpenAI::Beta::BetaComputerAction::Keypress,
                  OpenAI::Beta::BetaComputerAction::Move,
                  OpenAI::Beta::BetaComputerAction::Screenshot,
                  OpenAI::Beta::BetaComputerAction::Scroll,
                  OpenAI::Beta::BetaComputerAction::Type,
                  OpenAI::Beta::BetaComputerAction::Wait
                )
              ]
            )
          )
        end
        attr_reader :actions

        sig do
          params(
            actions:
              T::Array[
                T.any(
                  OpenAI::Beta::BetaComputerAction::Click::OrHash,
                  OpenAI::Beta::BetaComputerAction::DoubleClick::OrHash,
                  OpenAI::Beta::BetaComputerAction::Drag::OrHash,
                  OpenAI::Beta::BetaComputerAction::Keypress::OrHash,
                  OpenAI::Beta::BetaComputerAction::Move::OrHash,
                  OpenAI::Beta::BetaComputerAction::Screenshot::OrHash,
                  OpenAI::Beta::BetaComputerAction::Scroll::OrHash,
                  OpenAI::Beta::BetaComputerAction::Type::OrHash,
                  OpenAI::Beta::BetaComputerAction::Wait::OrHash
                )
              ]
          ).void
        end
        attr_writer :actions

        # The agent that produced this item.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseComputerToolCall::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseComputerToolCall::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use)
        # for more information.
        sig do
          params(
            id: String,
            call_id: String,
            pending_safety_checks:
              T::Array[
                OpenAI::Beta::BetaResponseComputerToolCall::PendingSafetyCheck::OrHash
              ],
            status:
              OpenAI::Beta::BetaResponseComputerToolCall::Status::OrSymbol,
            type: OpenAI::Beta::BetaResponseComputerToolCall::Type::OrSymbol,
            action:
              T.any(
                OpenAI::Beta::BetaComputerAction::Click::OrHash,
                OpenAI::Beta::BetaComputerAction::DoubleClick::OrHash,
                OpenAI::Beta::BetaComputerAction::Drag::OrHash,
                OpenAI::Beta::BetaComputerAction::Keypress::OrHash,
                OpenAI::Beta::BetaComputerAction::Move::OrHash,
                OpenAI::Beta::BetaComputerAction::Screenshot::OrHash,
                OpenAI::Beta::BetaComputerAction::Scroll::OrHash,
                OpenAI::Beta::BetaComputerAction::Type::OrHash,
                OpenAI::Beta::BetaComputerAction::Wait::OrHash
              ),
            actions:
              T::Array[
                T.any(
                  OpenAI::Beta::BetaComputerAction::Click::OrHash,
                  OpenAI::Beta::BetaComputerAction::DoubleClick::OrHash,
                  OpenAI::Beta::BetaComputerAction::Drag::OrHash,
                  OpenAI::Beta::BetaComputerAction::Keypress::OrHash,
                  OpenAI::Beta::BetaComputerAction::Move::OrHash,
                  OpenAI::Beta::BetaComputerAction::Screenshot::OrHash,
                  OpenAI::Beta::BetaComputerAction::Scroll::OrHash,
                  OpenAI::Beta::BetaComputerAction::Type::OrHash,
                  OpenAI::Beta::BetaComputerAction::Wait::OrHash
                )
              ],
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseComputerToolCall::Agent::OrHash
              )
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the computer call.
          id:,
          # An identifier used when responding to the tool call with output.
          call_id:,
          # The pending safety checks for the computer call.
          pending_safety_checks:,
          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          status:,
          # The type of the computer call. Always `computer_call`.
          type:,
          # A click action.
          action: nil,
          # Flattened batched actions for `computer_use`. Each action includes an `type`
          # discriminator and action-specific fields.
          actions: nil,
          # The agent that produced this item.
          agent: nil
        )
        end

        sig do
          override.returns(
            {
              id: String,
              call_id: String,
              pending_safety_checks:
                T::Array[
                  OpenAI::Beta::BetaResponseComputerToolCall::PendingSafetyCheck
                ],
              status:
                OpenAI::Beta::BetaResponseComputerToolCall::Status::OrSymbol,
              type: OpenAI::Beta::BetaResponseComputerToolCall::Type::OrSymbol,
              action:
                T.any(
                  OpenAI::Beta::BetaComputerAction::Click,
                  OpenAI::Beta::BetaComputerAction::DoubleClick,
                  OpenAI::Beta::BetaComputerAction::Drag,
                  OpenAI::Beta::BetaComputerAction::Keypress,
                  OpenAI::Beta::BetaComputerAction::Move,
                  OpenAI::Beta::BetaComputerAction::Screenshot,
                  OpenAI::Beta::BetaComputerAction::Scroll,
                  OpenAI::Beta::BetaComputerAction::Type,
                  OpenAI::Beta::BetaComputerAction::Wait
                ),
              actions:
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaComputerAction::Click,
                    OpenAI::Beta::BetaComputerAction::DoubleClick,
                    OpenAI::Beta::BetaComputerAction::Drag,
                    OpenAI::Beta::BetaComputerAction::Keypress,
                    OpenAI::Beta::BetaComputerAction::Move,
                    OpenAI::Beta::BetaComputerAction::Screenshot,
                    OpenAI::Beta::BetaComputerAction::Scroll,
                    OpenAI::Beta::BetaComputerAction::Type,
                    OpenAI::Beta::BetaComputerAction::Wait
                  )
                ],
              agent:
                T.nilable(OpenAI::Beta::BetaResponseComputerToolCall::Agent)
            }
          )
        end
        def to_hash
        end

        class PendingSafetyCheck < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseComputerToolCall::PendingSafetyCheck,
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

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::BetaResponseComputerToolCall::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Beta::BetaResponseComputerToolCall::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Beta::BetaResponseComputerToolCall::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Beta::BetaResponseComputerToolCall::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseComputerToolCall::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The type of the computer call. Always `computer_call`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::BetaResponseComputerToolCall::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPUTER_CALL =
            T.let(
              :computer_call,
              OpenAI::Beta::BetaResponseComputerToolCall::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseComputerToolCall::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseComputerToolCall::Agent,
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
