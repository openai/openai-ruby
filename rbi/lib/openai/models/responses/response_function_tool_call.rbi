# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCall < OpenAI::BaseModel
        # A JSON string of the arguments to pass to the function.
        sig { returns(String) }
        attr_accessor :arguments

        # The unique ID of the function tool call generated by the model.
        sig { returns(String) }
        attr_accessor :call_id

        # The name of the function to run.
        sig { returns(String) }
        attr_accessor :name

        # The type of the function tool call. Always `function_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the function tool call.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseFunctionToolCall::Status::OrSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Models::Responses::ResponseFunctionToolCall::Status::OrSymbol).void }
        attr_writer :status

        # A tool call to run a function. See the
        #   [function calling guide](https://platform.openai.com/docs/guides/function-calling)
        #   for more information.
        sig do
          params(
            arguments: String,
            call_id: String,
            name: String,
            id: String,
            status: OpenAI::Models::Responses::ResponseFunctionToolCall::Status::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(arguments:, call_id:, name:, id: nil, status: nil, type: :function_call)
        end

        sig do
          override
            .returns(
              {
                arguments: String,
                call_id: String,
                name: String,
                type: Symbol,
                id: String,
                status: OpenAI::Models::Responses::ResponseFunctionToolCall::Status::OrSymbol
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
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseFunctionToolCall::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseFunctionToolCall::Status::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Models::Responses::ResponseFunctionToolCall::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseFunctionToolCall::Status::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
