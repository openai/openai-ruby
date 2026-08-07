# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartImage < OpenAI::Internal::Type::BaseModel
        # @!attribute image_url
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL]
        required :image_url, -> { OpenAI::Chat::ChatCompletionContentPartImage::ImageURL }

        # @!attribute type
        #   The type of the content part.
        #
        #   @return [Symbol, :image_url]
        required :type, const: :image_url

        # @!attribute prompt_cache_breakpoint
        #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        #   token block.
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint, nil]
        optional :prompt_cache_breakpoint,
                 -> { OpenAI::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint }

        # @!method initialize(image_url:, prompt_cache_breakpoint: nil, type: :image_url)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionContentPartImage} for more details.
        #
        #   Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        #
        #   @param image_url [OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL]
        #
        #   @param prompt_cache_breakpoint [OpenAI::Models::Chat::ChatCompletionContentPartImage::PromptCacheBreakpoint] Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #
        #   @param type [Symbol, :image_url] The type of the content part.

        # @see OpenAI::Models::Chat::ChatCompletionContentPartImage#image_url
        class ImageURL < OpenAI::Internal::Type::BaseModel
          # @!attribute url
          #   Either a URL of the image or the base64 encoded image data.
          #
          #   @return [String]
          required :url, String

          # @!attribute detail
          #   Specifies the detail level of the image. Learn more in the
          #   [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          #
          #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail, nil]
          optional :detail, enum: -> { OpenAI::Chat::ChatCompletionContentPartImage::ImageURL::Detail }

          # @!method initialize(url:, detail: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL} for more
          #   details.
          #
          #   @param url [String] Either a URL of the image or the base64 encoded image data.
          #
          #   @param detail [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL::Detail] Specifies the detail level of the image. Learn more in the [Vision guide](https:

          # Specifies the detail level of the image. Learn more in the
          # [Vision guide](https://platform.openai.com/docs/guides/vision#low-or-high-fidelity-image-understanding).
          #
          # @see OpenAI::Models::Chat::ChatCompletionContentPartImage::ImageURL#detail
          module Detail
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            LOW = :low
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @see OpenAI::Models::Chat::ChatCompletionContentPartImage#prompt_cache_breakpoint
        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          # @!attribute mode
          #   The breakpoint mode. Always `explicit`.
          #
          #   @return [Symbol, :explicit]
          required :mode, const: :explicit

          # @!method initialize(mode: :explicit)
          #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          #   token block.
          #
          #   @param mode [Symbol, :explicit] The breakpoint mode. Always `explicit`.
        end
      end
    end

    ChatCompletionContentPartImage = Chat::ChatCompletionContentPartImage
  end
end
