# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartText = Chat::ChatCompletionContentPartText

    module Chat
      class ChatCompletionContentPartText < OpenAI::Internal::Type::BaseModel
        # The text content.
        sig { returns(String) }
        attr_accessor :text

        # The type of the content part.
        sig { returns(Symbol) }
        attr_accessor :type

        # Learn about
        # [text inputs](https://platform.openai.com/docs/guides/text-generation).
        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The text content.
          text:,
          # The type of the content part.
          type: :text
        ); end
        sig { override.returns({text: String, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end
