# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputTextAnnotationAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The annotation object being added. (See annotation schema for details.)
        sig { returns(T.anything) }
        attr_accessor :annotation

        # The index of the annotation within the content part.
        sig { returns(Integer) }
        attr_accessor :annotation_index

        # The index of the content part within the output item.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique identifier of the item to which the annotation is being added.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.output_text_annotation.added'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an annotation is added to output text content.
        sig do
          params(
            annotation: T.anything,
            annotation_index: Integer,
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The annotation object being added. (See annotation schema for details.)
          annotation:,
          # The index of the annotation within the content part.
          annotation_index:,
          # The index of the content part within the output item.
          content_index:,
          # The unique identifier of the item to which the annotation is being added.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always 'response.output_text_annotation.added'.
          type: :"response.output_text_annotation.added"
        )
        end

        sig do
          override.returns(
            {
              annotation: T.anything,
              annotation_index: Integer,
              content_index: Integer,
              item_id: String,
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
