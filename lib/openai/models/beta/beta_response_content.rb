# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Multi-modal input and output contents.
      module BetaResponseContent
        extend OpenAI::Internal::Type::Union

        # A text input to the model.
        variant -> { OpenAI::Beta::BetaResponseInputText }

        # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant -> { OpenAI::Beta::BetaResponseInputImage }

        # A file input to the model.
        variant -> { OpenAI::Beta::BetaResponseInputFile }

        # A text output from the model.
        variant -> { OpenAI::Beta::BetaResponseOutputText }

        # A refusal from the model.
        variant -> { OpenAI::Beta::BetaResponseOutputRefusal }

        # Reasoning text from the model.
        variant -> { OpenAI::Beta::BetaResponseContent::ReasoningText }

        class ReasoningText < OpenAI::Internal::Type::BaseModel
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
        #   @return [Array(OpenAI::Models::Beta::BetaResponseInputText, OpenAI::Models::Beta::BetaResponseInputImage, OpenAI::Models::Beta::BetaResponseInputFile, OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal, OpenAI::Models::Beta::BetaResponseContent::ReasoningText)]
      end
    end

    BetaResponseContent = Beta::BetaResponseContent
  end
end
