# frozen_string_literal: true

module OpenAI
  module Models
    class DecisionInputImage < OpenAI::Internal::Type::BaseModel
      # @!attribute image_url
      #   A base64-encoded image in a data URL or a publicly accessible HTTP(S) image URL.
      #
      #   @return [String]
      required :image_url, String

      # @!attribute type
      #
      #   @return [Symbol, :input_image]
      required :type, const: :input_image

      # @!attribute detail
      #   The image detail level, using the selected model's image profile. Defaults to
      #   auto.
      #
      #   @return [Symbol, OpenAI::Models::DecisionInputImage::Detail, nil]
      optional :detail, enum: -> { OpenAI::DecisionInputImage::Detail }, nil?: true

      # @!attribute prompt_cache_breakpoint
      #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      #   token block.
      #
      #   @return [OpenAI::Models::DecisionPromptCacheBreakpoint, nil]
      optional :prompt_cache_breakpoint, -> { OpenAI::DecisionPromptCacheBreakpoint }, nil?: true

      # @!method initialize(image_url:, detail: nil, prompt_cache_breakpoint: nil, type: :input_image)
      #   An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
      #   File IDs are not supported.
      #
      #   @param image_url [String]
      #     A base64-encoded image in a data URL or a publicly accessible HTTP(S) image URL.
      #
      #   @param detail [Symbol, OpenAI::Models::DecisionInputImage::Detail, nil]
      #     The image detail level, using the selected model's image profile. Defaults to
      #     auto.
      #
      #   @param prompt_cache_breakpoint [OpenAI::Models::DecisionPromptCacheBreakpoint, nil]
      #     Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      #     from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      #     token block.
      #
      #   @param type [Symbol, :input_image]

      # The image detail level, using the selected model's image profile. Defaults to
      # auto.
      #
      # @see OpenAI::Models::DecisionInputImage#detail
      module Detail
        extend OpenAI::Internal::Type::Enum

        LOW = :low
        HIGH = :high
        AUTO = :auto
        ORIGINAL = :original

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
