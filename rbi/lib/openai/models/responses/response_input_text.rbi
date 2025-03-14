# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputText < OpenAI::BaseModel
        # The text input to the model.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # The type of the input item. Always `input_text`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A text input to the model.
        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(text:, type: :input_text)
        end

        sig { override.returns({text: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
