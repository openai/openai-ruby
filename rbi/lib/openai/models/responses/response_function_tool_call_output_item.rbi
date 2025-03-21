# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCallOutputItem < OpenAI::BaseModel
        # The unique ID of the function call tool output.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The unique ID of the function tool call generated by the model.
        sig { returns(String) }
        def call_id
        end

        sig { params(_: String).returns(String) }
        def call_id=(_)
        end

        # A JSON string of the output of the function tool call.
        sig { returns(String) }
        def output
        end

        sig { params(_: String).returns(String) }
        def output=(_)
        end

        # The type of the function tool call output. Always `function_call_output`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::TaggedSymbol)) }
        def status
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::OrSymbol)
            .returns(OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::OrSymbol)
        end
        def status=(_)
        end

        sig do
          params(
            id: String,
            call_id: String,
            output: String,
            status: OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, call_id:, output:, status: nil, type: :function_call_output)
        end

        sig do
          override
            .returns(
              {
                id: String,
                call_id: String,
                output: String,
                type: Symbol,
                status: OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::TaggedSymbol
              }
            )
        end
        def to_hash
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        module Status
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::TaggedSymbol)
          COMPLETED =
            T.let(:completed, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::TaggedSymbol)

          class << self
            sig do
              override
                .returns(T::Array[OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status::TaggedSymbol])
            end
            def values
            end
          end
        end
      end
    end
  end
end
