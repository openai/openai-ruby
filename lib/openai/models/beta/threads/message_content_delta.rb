# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # @abstract
        #
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        #   in the content of a message.
        class MessageContentDelta < OpenAI::Union
          discriminator :type

          # References an image [File](https://platform.openai.com/docs/api-reference/files) in the content of a message.
          variant :image_file, -> { OpenAI::Models::Beta::Threads::ImageFileDeltaBlock }

          # The text content that is part of a message.
          variant :text, -> { OpenAI::Models::Beta::Threads::TextDeltaBlock }

          # The refusal content that is part of a message.
          variant :refusal, -> { OpenAI::Models::Beta::Threads::RefusalDeltaBlock }

          # References an image URL in the content of a message.
          variant :image_url, -> { OpenAI::Models::Beta::Threads::ImageURLDeltaBlock }

          # @!parse
          #   class << self
          #     # @return [Array(OpenAI::Models::Beta::Threads::ImageFileDeltaBlock, OpenAI::Models::Beta::Threads::TextDeltaBlock, OpenAI::Models::Beta::Threads::RefusalDeltaBlock, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock)]
          #     def variants; end
          #   end
        end
      end
    end
  end
end
