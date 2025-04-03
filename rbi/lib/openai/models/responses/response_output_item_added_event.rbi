# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemAddedEvent < OpenAI::Internal::Type::BaseModel
        # The output item that was added.
        sig do
          returns(
            T.any(
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseReasoningItem
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
            item: T.any(
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseReasoningItem
            ),
            output_index: Integer,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(item:, output_index:, type: :"response.output_item.added")
        end

        sig do
          override
            .returns(
              {
                item: T.any(
                  OpenAI::Models::Responses::ResponseOutputMessage,
                  OpenAI::Models::Responses::ResponseFileSearchToolCall,
                  OpenAI::Models::Responses::ResponseFunctionToolCall,
                  OpenAI::Models::Responses::ResponseFunctionWebSearch,
                  OpenAI::Models::Responses::ResponseComputerToolCall,
                  OpenAI::Models::Responses::ResponseReasoningItem
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
