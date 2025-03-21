# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseItemList < OpenAI::BaseModel
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
        def data
        end

        sig do
          params(
            _: T::Array[
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
            .returns(
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
        def data=(_)
        end

        # The ID of the first item in the list.
        sig { returns(String) }
        def first_id
        end

        sig { params(_: String).returns(String) }
        def first_id=(_)
        end

        # Whether there are more items available.
        sig { returns(T::Boolean) }
        def has_more
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def has_more=(_)
        end

        # The ID of the last item in the list.
        sig { returns(String) }
        def last_id
        end

        sig { params(_: String).returns(String) }
        def last_id=(_)
        end

        # The type of object returned, must be `list`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # A list of Response items.
        sig do
          params(
            data: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseInputMessageItem,
              OpenAI::Util::AnyHash,
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
        def self.new(data:, first_id:, has_more:, last_id:, object: :list)
        end

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
        def to_hash
        end
      end
    end

    ResponseItemList = Responses::ResponseItemList
  end
end
