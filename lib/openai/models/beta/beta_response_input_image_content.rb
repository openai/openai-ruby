# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseInputImageContent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the input item. Always `input_image`.
        #
        #   @return [Symbol, :input_image]
        required :type, const: :input_image

        # @!attribute detail
        #   The detail level of the image to be sent to the model. One of `high`, `low`,
        #   `auto`, or `original`. Defaults to `auto`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseInputImageContent::Detail, nil]
        optional :detail, enum: -> { OpenAI::Beta::BetaResponseInputImageContent::Detail }, nil?: true

        # @!attribute file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_id, String, nil?: true

        # @!attribute image_url
        #   The URL of the image to be sent to the model. A fully qualified URL or base64
        #   encoded image in a data URL.
        #
        #   @return [String, nil]
        optional :image_url, String, nil?: true

        # @!attribute prompt_cache_breakpoint
        #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        #   token block.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseInputImageContent::PromptCacheBreakpoint, nil]
        optional :prompt_cache_breakpoint,
                 -> { OpenAI::Beta::BetaResponseInputImageContent::PromptCacheBreakpoint },
                 nil?: true

        # @!method initialize(detail: nil, file_id: nil, image_url: nil, prompt_cache_breakpoint: nil, type: :input_image)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseInputImageContent} for more details.
        #
        #   An image input to the model. Learn about
        #   [image inputs](https://platform.openai.com/docs/guides/vision)
        #
        #   @param detail [Symbol, OpenAI::Models::Beta::BetaResponseInputImageContent::Detail, nil] The detail level of the image to be sent to the model. One of `high`, `low`, `au
        #
        #   @param file_id [String, nil] The ID of the file to be sent to the model.
        #
        #   @param image_url [String, nil] The URL of the image to be sent to the model. A fully qualified URL or base64 en
        #
        #   @param prompt_cache_breakpoint [OpenAI::Models::Beta::BetaResponseInputImageContent::PromptCacheBreakpoint, nil] Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #
        #   @param type [Symbol, :input_image] The type of the input item. Always `input_image`.

        # The detail level of the image to be sent to the model. One of `high`, `low`,
        # `auto`, or `original`. Defaults to `auto`.
        #
        # @see OpenAI::Models::Beta::BetaResponseInputImageContent#detail
        module Detail
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          HIGH = :high
          AUTO = :auto
          ORIGINAL = :original

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponseInputImageContent#prompt_cache_breakpoint
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

    BetaResponseInputImageContent = Beta::BetaResponseInputImageContent
  end
end
