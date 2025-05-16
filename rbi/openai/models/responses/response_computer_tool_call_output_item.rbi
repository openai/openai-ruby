# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputItem < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseComputerToolCallOutputItem,
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
          returns(OpenAI::Responses::ResponseComputerToolCallOutputScreenshot)
        end
        attr_reader :output

        sig do
          params(
            output:
              OpenAI::Responses::ResponseComputerToolCallOutputScreenshot::OrHash
          ).void
        end
        attr_writer :output

        # The type of the computer tool call output. Always `computer_call_output`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The safety checks reported by the API that have been acknowledged by the
        # developer.
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck
              ]
            )
          )
        end
        attr_reader :acknowledged_safety_checks

        sig do
          params(
            acknowledged_safety_checks:
              T::Array[
                OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck::OrHash
              ]
          ).void
        end
        attr_writer :acknowledged_safety_checks

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::OrSymbol
          ).void
        end
        attr_writer :status

        sig do
          params(
            id: String,
            call_id: String,
            output:
              OpenAI::Responses::ResponseComputerToolCallOutputScreenshot::OrHash,
            acknowledged_safety_checks:
              T::Array[
                OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck::OrHash
              ],
            status:
              OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::OrSymbol,
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
          # The safety checks reported by the API that have been acknowledged by the
          # developer.
          acknowledged_safety_checks: nil,
          # The status of the message input. One of `in_progress`, `completed`, or
          # `incomplete`. Populated when input items are returned via API.
          status: nil,
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
                OpenAI::Responses::ResponseComputerToolCallOutputScreenshot,
              type: Symbol,
              acknowledged_safety_checks:
                T::Array[
                  OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck
                ],
              status:
                OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class AcknowledgedSafetyCheck < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck,
                OpenAI::Internal::AnyHash
              )
            end

          # The ID of the pending safety check.
          sig { returns(String) }
          attr_accessor :id

          # The type of the pending safety check.
          sig { returns(String) }
          attr_accessor :code

          # Details about the pending safety check.
          sig { returns(String) }
          attr_accessor :message

          # A pending safety check for the computer call.
          sig do
            params(id: String, code: String, message: String).returns(
              T.attached_class
            )
          end
          def self.new(
            # The ID of the pending safety check.
            id:,
            # The type of the pending safety check.
            code:,
            # Details about the pending safety check.
            message:
          )
          end

          sig do
            override.returns({ id: String, code: String, message: String })
          end
          def to_hash
          end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseComputerToolCallOutputItem::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
