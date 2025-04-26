# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemDoneEvent < OpenAI::Internal::Type::BaseModel
        # The output item that was marked done.
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

        # The index of the output item that was marked done.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.output_item.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an output item is marked done.
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
        def self.new(
          # The output item that was marked done.
          item:,
          # The index of the output item that was marked done.
          output_index:,
          # The type of the event. Always `response.output_item.done`.
          type: :"response.output_item.done"
        ); end
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
        def to_hash; end
      end
    end
  end
end
