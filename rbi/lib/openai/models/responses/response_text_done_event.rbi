# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # The index of the content part that the text content is finalized.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the text content is finalized.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the text content is finalized.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The text content that is finalized.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `response.output_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when text content is finalized.
        sig do
          params(content_index: Integer, item_id: String, output_index: Integer, text: String, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(content_index:, item_id:, output_index:, text:, type: :"response.output_text.done")
        end

        sig do
          override
            .returns({
                       content_index: Integer,
                       item_id: String,
                       output_index: Integer,
                       text: String,
                       type: Symbol
                     })
        end
        def to_hash
        end
      end
    end
  end
end
