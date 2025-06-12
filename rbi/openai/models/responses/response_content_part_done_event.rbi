# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseContentPartDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseContentPartDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part that is done.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the content part was added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the content part was added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The content part that is done.
        sig do
          returns(
            OpenAI::Responses::ResponseContentPartDoneEvent::Part::Variants
          )
        end
        attr_accessor :part

        # The type of the event. Always `response.content_part.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a content part is done.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            part:
              T.any(
                OpenAI::Responses::ResponseOutputText::OrHash,
                OpenAI::Responses::ResponseOutputRefusal::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that is done.
          content_index:,
          # The ID of the output item that the content part was added to.
          item_id:,
          # The index of the output item that the content part was added to.
          output_index:,
          # The content part that is done.
          part:,
          # The type of the event. Always `response.content_part.done`.
          type: :"response.content_part.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Responses::ResponseContentPartDoneEvent::Part::Variants,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The content part that is done.
        module Part
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseOutputText,
                OpenAI::Responses::ResponseOutputRefusal
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseContentPartDoneEvent::Part::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
