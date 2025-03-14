# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPart = T.type_alias { Chat::ChatCompletionContentPart }

    module Chat
      # Learn about
      #   [text inputs](https://platform.openai.com/docs/guides/text-generation).
      class ChatCompletionContentPart < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
