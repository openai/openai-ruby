# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A content part in a session message.
      module AgentSessionMessageContent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Text supplied by the user.
        variant :input_text, -> { OpenAI::Beta::AgentSessionMessageContent::InputText }

        # An image supplied by the user.
        variant :input_image, -> { OpenAI::Beta::AgentSessionMessageContent::InputImage }

        # Text produced by the assistant.
        variant :output_text, -> { OpenAI::Beta::AgentSessionMessageContent::OutputText }

        class InputText < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text supplied by the user.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the object. Always `input_text`.
          #
          #   @return [Symbol, :input_text]
          required :type, const: :input_text

          # @!method initialize(text:, type: :input_text)
          #   Text supplied by the user.
          #
          #   @param text [String]
          #     The text supplied by the user.
          #
          #   @param type [Symbol, :input_text]
          #     The type of the object. Always `input_text`.
        end

        class InputImage < OpenAI::Internal::Type::BaseModel
          # @!attribute image_url
          #   The URL of the image supplied by the user, which may be a base64-encoded data
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
          #   An image supplied by the user.
          #
          #   @param image_url [String]
          #     The URL of the image supplied by the user, which may be a base64-encoded data
          #     URL.
          #
          #   @param type [Symbol, :input_image]
          #     The type of the object. Always `input_image`.
        end

        class OutputText < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text produced by the assistant.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the object. Always `output_text`.
          #
          #   @return [Symbol, :output_text]
          required :type, const: :output_text

          # @!method initialize(text:, type: :output_text)
          #   Text produced by the assistant.
          #
          #   @param text [String]
          #     The text produced by the assistant.
          #
          #   @param type [Symbol, :output_text]
          #     The type of the object. Always `output_text`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentSessionMessageContent::InputText, OpenAI::Models::Beta::AgentSessionMessageContent::InputImage, OpenAI::Models::Beta::AgentSessionMessageContent::OutputText)]
      end
    end
  end
end
