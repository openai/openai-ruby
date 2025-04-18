# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputItem < OpenAI::Internal::Type::BaseModel
        # The unique ID of the computer call tool output.
        sig { returns(String) }
        attr_accessor :id

        # The ID of the computer tool call that produced the output.
        sig { returns(String) }
        attr_accessor :call_id

        # A computer screenshot image used with the computer use tool.
        sig { returns(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot) }
        attr_reader :output

        sig do
          params(
            output: T.any(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot, OpenAI::Internal::AnyHash)
          )
            .void
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
              T::Array[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck]
            )
          )
        end
        attr_reader :acknowledged_safety_checks

        sig do
          params(
            acknowledged_safety_checks: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck,
                OpenAI::Internal::AnyHash
              )
            ]
          )
            .void
        end
        attr_writer :acknowledged_safety_checks

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::OrSymbol).void }
        attr_writer :status

        sig do
          params(
            id: String,
            call_id: String,
            output: T.any(OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot, OpenAI::Internal::AnyHash),
            acknowledged_safety_checks: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck,
                OpenAI::Internal::AnyHash
              )
            ],
            status: OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          call_id:,
          output:,
          acknowledged_safety_checks: nil,
          status: nil,
          type: :computer_call_output
        )
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
                status: OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol
              }
            )
        end
        def to_hash; end

        class AcknowledgedSafetyCheck < OpenAI::Internal::Type::BaseModel
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
          sig { params(id: String, code: String, message: String).returns(T.attached_class) }
          def self.new(id:, code:, message:); end

          sig { override.returns({id: String, code: String, message: String}) }
          def to_hash; end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol)
          COMPLETED =
            T.let(:completed, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status::TaggedSymbol])
          end
          def self.values; end
        end
      end
    end
  end
end
