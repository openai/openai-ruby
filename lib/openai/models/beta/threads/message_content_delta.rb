# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        # in the content of a message.
        module MessageContentDelta
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # References an image [File](https://platform.openai.com/docs/api-reference/files) in the content of a message.
          variant :image_file, -> { OpenAI::Beta::Threads::ImageFileDeltaBlock }

          # The text content that is part of a message.
          variant :text, -> { OpenAI::Beta::Threads::TextDeltaBlock }

          # The refusal content that is part of a message.
          variant :refusal, -> { OpenAI::Beta::Threads::RefusalDeltaBlock }

          # References an image URL in the content of a message.
          variant :image_url, -> { OpenAI::Beta::Threads::ImageURLDeltaBlock }

          # @!method self.variants
          #   @return [Array(OpenAI::Beta::Threads::ImageFileDeltaBlock, OpenAI::Beta::Threads::TextDeltaBlock, OpenAI::Beta::Threads::RefusalDeltaBlock, OpenAI::Beta::Threads::ImageURLDeltaBlock)]
        end
      end
    end
  end
end
