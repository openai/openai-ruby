# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartText = T.type_alias { Chat::ChatCompletionContentPartText }

    module Chat
      class ChatCompletionContentPartText < OpenAI::BaseModel
        # The text content.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # The type of the content part.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Learn about
        #   [text inputs](https://platform.openai.com/docs/guides/text-generation).
        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(text:, type: :text)
        end

        sig { override.returns({text: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
