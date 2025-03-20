# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputItem < OpenAI::BaseModel
        # The unique ID of the computer call tool output.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The ID of the computer tool call that produced the output.
        sig { returns(String) }
        def call_id
        end

        sig { params(_: String).returns(String) }
        def call_id=(_)
        end

        # A computer screenshot image used with the computer use tool.
        sig { returns(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot) }
        def output
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot)
            .returns(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot)
        end
        def output=(_)
        end

        # The type of the computer tool call output. Always `computer_call_output`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The safety checks reported by the API that have been acknowledged by the
        #   developer.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck]
            )
          )
        end
        def acknowledged_safety_checks
        end

        sig do
          params(
            _: T::Array[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck]
          )
            .returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck])
        end
        def acknowledged_safety_checks=(_)
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        sig { returns(T.nilable(Symbol)) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig do
          params(
            id: String,
            call_id: String,
            output: OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot,
            acknowledged_safety_checks: T::Array[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck],
            status: Symbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, call_id:, output:, acknowledged_safety_checks: nil, status: nil, type: :computer_call_output)
        end

        sig do
          override
            .returns(
              {
                id: String,
                call_id: String,
                output: OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot,
                type: Symbol,
                acknowledged_safety_checks: T::Array[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck],
                status: Symbol
              }
            )
        end
        def to_hash
        end

        class AcknowledgedSafetyCheck < OpenAI::BaseModel
          # The ID of the pending safety check.
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # The type of the pending safety check.
          sig { returns(String) }
          def code
          end

          sig { params(_: String).returns(String) }
          def code=(_)
          end

          # Details about the pending safety check.
          sig { returns(String) }
          def message
          end

          sig { params(_: String).returns(String) }
          def message=(_)
          end

          # A pending safety check for the computer call.
          sig { params(id: String, code: String, message: String).returns(T.attached_class) }
          def self.new(id:, code:, message:)
          end

          sig { override.returns({id: String, code: String, message: String}) }
          def to_hash
          end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        class Status < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete
        end
      end
    end
  end
end
