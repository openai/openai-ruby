# typed: strong

module OpenAI
  module Models
    ResponseItemList = Responses::ResponseItemList

    module Responses
      class ResponseItemList < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # A list of items used to generate this response.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Responses::ResponseInputMessageItem,
                OpenAI::Responses::ResponseOutputMessage,
                OpenAI::Responses::ResponseFileSearchToolCall,
                OpenAI::Responses::ResponseComputerToolCall,
                OpenAI::Responses::ResponseComputerToolCallOutputItem,
                OpenAI::Responses::ResponseFunctionWebSearch,
                OpenAI::Responses::ResponseFunctionToolCallItem,
                OpenAI::Responses::ResponseFunctionToolCallOutputItem
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
            data:
              T::Array[
                T.any(
                  OpenAI::Responses::ResponseInputMessageItem::OrHash,
                  OpenAI::Responses::ResponseOutputMessage::OrHash,
                  OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                  OpenAI::Responses::ResponseComputerToolCall::OrHash,
                  OpenAI::Responses::ResponseComputerToolCallOutputItem::OrHash,
                  OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCallItem::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCallOutputItem::OrHash
                )
              ],
            first_id: String,
            has_more: T::Boolean,
            last_id: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A list of items used to generate this response.
          data:,
          # The ID of the first item in the list.
          first_id:,
          # Whether there are more items available.
          has_more:,
          # The ID of the last item in the list.
          last_id:,
          # The type of object returned, must be `list`.
          object: :list
        )
        end

        sig do
          override.returns(
            {
              data:
                T::Array[
                  T.any(
                    OpenAI::Responses::ResponseInputMessageItem,
                    OpenAI::Responses::ResponseOutputMessage,
                    OpenAI::Responses::ResponseFileSearchToolCall,
                    OpenAI::Responses::ResponseComputerToolCall,
                    OpenAI::Responses::ResponseComputerToolCallOutputItem,
                    OpenAI::Responses::ResponseFunctionWebSearch,
                    OpenAI::Responses::ResponseFunctionToolCallItem,
                    OpenAI::Responses::ResponseFunctionToolCallOutputItem
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
  end
end
