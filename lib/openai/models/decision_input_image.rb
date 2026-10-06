# frozen_string_literal: true

module OpenAI
  module Models
    class DecisionInputImage < OpenAI::Internal::Type::BaseModel
      # @!attribute image_url
      #   A base64-encoded image in a data URL.
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

      # @!method initialize(image_url:, detail: nil, type: :input_image)
      #   An inline image. External URLs and file IDs are not supported.
      #
      #   @param image_url [String]
      #     A base64-encoded image in a data URL.
      #
      #   @param detail [Symbol, OpenAI::Models::DecisionInputImage::Detail, nil]
      #     The image detail level, using the selected model's image profile. Defaults to
      #     auto.
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
