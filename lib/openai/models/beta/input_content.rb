# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # User-provided content recorded in a session item.
      module InputContent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Text input recorded in a session item.
        variant :input_text, -> { OpenAI::Beta::InputContent::InputText }

        # Image input recorded in a session item.
        variant :input_image, -> { OpenAI::Beta::InputContent::InputImage }

        class InputText < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text supplied to the agent.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the object. Always `input_text`.
          #
          #   @return [Symbol, :input_text]
          required :type, const: :input_text

          # @!method initialize(text:, type: :input_text)
          #   Text input recorded in a session item.
          #
          #   @param text [String]
          #     The text supplied to the agent.
          #
          #   @param type [Symbol, :input_text]
          #     The type of the object. Always `input_text`.
        end

        class InputImage < OpenAI::Internal::Type::BaseModel
          # @!attribute image_url
          #   The URL of the image supplied to the agent, which may be a base64-encoded data
          #   URL.
          #
          #   @return [String]
          required :image_url, String

          # @!attribute type
          #   The type of the object. Always `input_image`.
          #
          #   @return [Symbol, :input_image]
          required :type, const: :input_image

          # @!method initialize(image_url:, type: :input_image)
          #   Image input recorded in a session item.
          #
          #   @param image_url [String]
          #     The URL of the image supplied to the agent, which may be a base64-encoded data
          #     URL.
          #
          #   @param type [Symbol, :input_image]
          #     The type of the object. Always `input_image`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::InputContent::InputText, OpenAI::Models::Beta::InputContent::InputImage)]
      end
    end
  end
end
