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

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

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
                OpenAI::Responses::ResponseOutputRefusal::OrHash,
                OpenAI::Responses::ResponseContentPartDoneEvent::Part::ReasoningText::OrHash
              ),
            sequence_number: Integer,
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
          # The sequence number of this event.
          sequence_number:,
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
              sequence_number: Integer,
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
                OpenAI::Responses::ResponseOutputRefusal,
                OpenAI::Responses::ResponseContentPartDoneEvent::Part::ReasoningText
              )
            end

          class ReasoningText < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseContentPartDoneEvent::Part::ReasoningText,
                  OpenAI::Internal::AnyHash
                )
              end

            # The reasoning text from the model.
            sig { returns(String) }
            attr_accessor :text

            # The type of the reasoning text. Always `reasoning_text`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Reasoning text from the model.
            sig { params(text: String, type: Symbol).returns(T.attached_class) }
            def self.new(
              # The reasoning text from the model.
              text:,
              # The type of the reasoning text. Always `reasoning_text`.
              type: :reasoning_text
            )
            end

            sig { override.returns({ text: String, type: Symbol }) }
            def to_hash
            end
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
