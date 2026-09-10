# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Content included in an input message.
      module InputContentParam
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Text input to the model.
        variant :input_text, -> { OpenAI::Beta::InputContentParam::InputText }

        # Image input to the model.
        variant :input_image, -> { OpenAI::Beta::InputContentParam::InputImage }

        class InputText < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text sent to the model.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the object. Always `input_text`.
          #
          #   @return [Symbol, :input_text]
          required :type, const: :input_text

          # @!method initialize(text:, type: :input_text)
          #   Text input to the model.
          #
          #   @param text [String]
          #     The text sent to the model.
          #
          #   @param type [Symbol, :input_text]
          #     The type of the object. Always `input_text`.
        end

        class InputImage < OpenAI::Internal::Type::BaseModel
          # @!attribute image_url
          #   The URL of the image sent to the model.
          #
          #   @return [String]
          required :image_url, String

          # @!attribute type
          #   The type of the object. Always `input_image`.
          #
          #   @return [Symbol, :input_image]
          required :type, const: :input_image

          # @!method initialize(image_url:, type: :input_image)
          #   Image input to the model.
          #
          #   @param image_url [String]
          #     The URL of the image sent to the model.
          #
          #   @param type [Symbol, :input_image]
          #     The type of the object. Always `input_image`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::InputContentParam::InputText, OpenAI::Models::Beta::InputContentParam::InputImage)]
      end
    end
  end
end
