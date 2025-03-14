# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextDoneEvent < OpenAI::BaseModel
        # The index of the content part that the text content is finalized.
        sig { returns(Integer) }
        def content_index
        end

        sig { params(_: Integer).returns(Integer) }
        def content_index=(_)
        end

        # The ID of the output item that the text content is finalized.
        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        # The index of the output item that the text content is finalized.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The text content that is finalized.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # The type of the event. Always `response.output_text.done`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

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
