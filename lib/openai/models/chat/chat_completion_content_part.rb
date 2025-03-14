# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @abstract
      #
      # Learn about
      #   [text inputs](https://platform.openai.com/docs/guides/text-generation).
      class ChatCompletionContentPart < OpenAI::Union
        discriminator :type

        # Learn about [text inputs](https://platform.openai.com/docs/guides/text-generation).
        variant :text, -> { OpenAI::Models::Chat::ChatCompletionContentPartText }

        # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant :image_url, -> { OpenAI::Models::Chat::ChatCompletionContentPartImage }

        # Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        variant :input_audio, -> { OpenAI::Models::Chat::ChatCompletionContentPartInputAudio }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio)]
        #     def variants; end
        #   end
      end
    end

    ChatCompletionContentPart = Chat::ChatCompletionContentPart
  end
end
