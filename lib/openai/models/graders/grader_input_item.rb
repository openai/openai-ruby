# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      # A single content item: input text, output text, input image, or input audio.
      module GraderInputItem
        extend OpenAI::Internal::Type::Union

        # A text input to the model.
        variant String

        # A text input to the model.
        variant -> { OpenAI::Responses::ResponseInputText }

        # A text output from the model.
        variant -> { OpenAI::Graders::GraderInputItem::OutputText }

        # An image input block used within EvalItem content arrays.
        variant -> { OpenAI::Graders::GraderInputItem::InputImage }

        # An audio input to the model.
        variant -> { OpenAI::Responses::ResponseInputAudio }

        class OutputText < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text output from the model.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the output text. Always `output_text`.
          #
          #   @return [Symbol, :output_text]
          required :type, const: :output_text

          # @!method initialize(text:, type: :output_text)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Graders::GraderInputItem::OutputText} for more details.
          #
          #   A text output from the model.
          #
          #   @param text [String] The text output from the model.
          #
          #   @param type [Symbol, :output_text] The type of the output text. Always `output_text`.
        end

        class InputImage < OpenAI::Internal::Type::BaseModel
          # @!attribute image_url
          #   The URL of the image input.
          #
          #   @return [String]
          required :image_url, String

          # @!attribute type
          #   The type of the image input. Always `input_image`.
          #
          #   @return [Symbol, :input_image]
          required :type, const: :input_image

          # @!attribute detail
          #   The detail level of the image to be sent to the model. One of `high`, `low`, or
          #   `auto`. Defaults to `auto`.
          #
          #   @return [String, nil]
          optional :detail, String

          # @!method initialize(image_url:, detail: nil, type: :input_image)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Graders::GraderInputItem::InputImage} for more details.
          #
          #   An image input block used within EvalItem content arrays.
          #
          #   @param image_url [String] The URL of the image input.
          #
          #   @param detail [String] The detail level of the image to be sent to the model. One of `high`, `low`, or
          #
          #   @param type [Symbol, :input_image] The type of the image input. Always `input_image`.
        end

        # @!method self.variants
        #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Graders::GraderInputItem::OutputText, OpenAI::Models::Graders::GraderInputItem::InputImage, OpenAI::Models::Responses::ResponseInputAudio)]
      end
    end
  end
end
