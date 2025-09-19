# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Multi-modal input and output contents.
      module ResponseContent
        extend OpenAI::Internal::Type::Union

        # A text input to the model.
        variant -> { OpenAI::Responses::ResponseInputText }

        # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant -> { OpenAI::Responses::ResponseInputImage }

        # A file input to the model.
        variant -> { OpenAI::Responses::ResponseInputFile }

        # An audio input to the model.
        variant -> { OpenAI::Responses::ResponseInputAudio }

        # A text output from the model.
        variant -> { OpenAI::Responses::ResponseOutputText }

        # A refusal from the model.
        variant -> { OpenAI::Responses::ResponseOutputRefusal }

        # Reasoning text from the model.
        variant -> { OpenAI::Responses::ResponseContent::ReasoningTextContent }

        class ReasoningTextContent < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The reasoning text from the model.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the reasoning text. Always `reasoning_text`.
          #
          #   @return [Symbol, :reasoning_text]
          required :type, const: :reasoning_text

          # @!method initialize(text:, type: :reasoning_text)
          #   Reasoning text from the model.
          #
          #   @param text [String] The reasoning text from the model.
          #
          #   @param type [Symbol, :reasoning_text] The type of the reasoning text. Always `reasoning_text`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile, OpenAI::Models::Responses::ResponseInputAudio, OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseContent::ReasoningTextContent)]
      end
    end
  end
end
