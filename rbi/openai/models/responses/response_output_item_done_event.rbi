# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputItemDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseOutputItemDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The output item that was marked done.
        sig { returns(OpenAI::Responses::ResponseOutputItem::Variants) }
        attr_accessor :item

        # The index of the output item that was marked done.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.output_item.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an output item is marked done.
        sig do
          params(
            item:
              T.any(
                OpenAI::Responses::ResponseOutputMessage::OrHash,
                OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                OpenAI::Responses::ResponseFunctionToolCall::OrHash,
                OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::OrHash,
                OpenAI::Responses::ResponseReasoningItem::OrHash,
                OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::OrHash,
                OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                OpenAI::Responses::ResponseOutputItem::LocalShellCall::OrHash,
                OpenAI::Responses::ResponseOutputItem::McpCall::OrHash,
                OpenAI::Responses::ResponseOutputItem::McpListTools::OrHash,
                OpenAI::Responses::ResponseOutputItem::McpApprovalRequest::OrHash
              ),
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The output item that was marked done.
          item:,
          # The index of the output item that was marked done.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.output_item.done`.
          type: :"response.output_item.done"
        )
        end

        sig do
          override.returns(
            {
              item: OpenAI::Responses::ResponseOutputItem::Variants,
              output_index: Integer,
              sequence_number: Integer,
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
