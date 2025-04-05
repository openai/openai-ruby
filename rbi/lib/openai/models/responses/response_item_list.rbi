# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseItemList < OpenAI::Internal::Type::BaseModel
        # A list of items used to generate this response.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputMessageItem,
                OpenAI::Models::Responses::ResponseOutputMessage,
                OpenAI::Models::Responses::ResponseFileSearchToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCallOutputItem,
                OpenAI::Models::Responses::ResponseFunctionWebSearch,
                OpenAI::Models::Responses::ResponseFunctionToolCallItem,
                OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem
              )
            ]
          )
        end
        attr_accessor :data

        # The ID of the first item in the list.
        sig { returns(String) }
        attr_accessor :first_id

        # Whether there are more items available.
        sig { returns(T::Boolean) }
        attr_accessor :has_more

        # The ID of the last item in the list.
        sig { returns(String) }
        attr_accessor :last_id

        # The type of object returned, must be `list`.
        sig { returns(Symbol) }
        attr_accessor :object

        # A list of Response items.
        sig do
          params(
            data: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputMessageItem,
                OpenAI::Internal::AnyHash,
                OpenAI::Models::Responses::ResponseOutputMessage,
                OpenAI::Models::Responses::ResponseFileSearchToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCallOutputItem,
                OpenAI::Models::Responses::ResponseFunctionWebSearch,
                OpenAI::Models::Responses::ResponseFunctionToolCallItem,
                OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem
              )
            ],
            first_id: String,
            has_more: T::Boolean,
            last_id: String,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(data:, first_id:, has_more:, last_id:, object: :list); end

        sig do
          override
            .returns(
              {
                data: T::Array[
                  T.any(
                    OpenAI::Models::Responses::ResponseInputMessageItem,
                    OpenAI::Models::Responses::ResponseOutputMessage,
                    OpenAI::Models::Responses::ResponseFileSearchToolCall,
                    OpenAI::Models::Responses::ResponseComputerToolCall,
                    OpenAI::Models::Responses::ResponseComputerToolCallOutputItem,
                    OpenAI::Models::Responses::ResponseFunctionWebSearch,
                    OpenAI::Models::Responses::ResponseFunctionToolCallItem,
                    OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem
                  )
                ],
                first_id: String,
                has_more: T::Boolean,
                last_id: String,
                object: Symbol
              }
            )
        end
        def to_hash; end
      end
    end

    ResponseItemList = Responses::ResponseItemList
  end
end
