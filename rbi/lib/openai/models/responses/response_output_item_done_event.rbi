# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemDoneEvent < OpenAI::BaseModel
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
        def item
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseReasoningItem
            )
          )
            .returns(
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
        def item=(_)
        end

        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
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
          )
            .returns(T.attached_class)
        end
        def self.new(item:, output_index:, type: :"response.output_item.done")
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
