# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRefusalDoneEvent < OpenAI::Internal::Type::BaseModel
        # The index of the content part that the refusal text is finalized.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the refusal text is finalized.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the refusal text is finalized.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The refusal text that is finalized.
        sig { returns(String) }
        attr_accessor :refusal

        # The type of the event. Always `response.refusal.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when refusal text is finalized.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            refusal: String,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that the refusal text is finalized.
          content_index:,
          # The ID of the output item that the refusal text is finalized.
          item_id:,
          # The index of the output item that the refusal text is finalized.
          output_index:,
          # The refusal text that is finalized.
          refusal:,
          # The type of the event. Always `response.refusal.done`.
          type: :"response.refusal.done"
        ); end
        sig do
          override
            .returns({
                       content_index: Integer,
                       item_id: String,
                       output_index: Integer,
                       refusal: String,
                       type: Symbol
                     })
        end
        def to_hash; end
      end
    end
  end
end
