# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The output item that was added.
        sig do
          returns(
            T.any(
              OpenAI::Responses::ResponseOutputMessage,
              OpenAI::Responses::ResponseFileSearchToolCall,
              OpenAI::Responses::ResponseFunctionToolCall,
              OpenAI::Responses::ResponseFunctionWebSearch,
              OpenAI::Responses::ResponseComputerToolCall,
              OpenAI::Responses::ResponseReasoningItem
            )
          )
        end
        attr_accessor :item

        # The index of the output item that was added.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.output_item.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a new output item is added.
        sig do
          params(
            item:
              T.any(
                OpenAI::Responses::ResponseOutputMessage::OrHash,
                OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                OpenAI::Responses::ResponseFunctionToolCall::OrHash,
                OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::OrHash,
                OpenAI::Responses::ResponseReasoningItem::OrHash
              ),
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The output item that was added.
          item:,
          # The index of the output item that was added.
          output_index:,
          # The type of the event. Always `response.output_item.added`.
          type: :"response.output_item.added"
        )
        end

        sig do
          override.returns(
            {
              item:
                T.any(
                  OpenAI::Responses::ResponseOutputMessage,
                  OpenAI::Responses::ResponseFileSearchToolCall,
                  OpenAI::Responses::ResponseFunctionToolCall,
                  OpenAI::Responses::ResponseFunctionWebSearch,
                  OpenAI::Responses::ResponseComputerToolCall,
                  OpenAI::Responses::ResponseReasoningItem
                ),
              output_index: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
