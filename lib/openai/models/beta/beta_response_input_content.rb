# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A text input to the model.
      module BetaResponseInputContent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A text input to the model.
        variant :input_text, -> { OpenAI::Beta::BetaResponseInputText }

        # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant :input_image, -> { OpenAI::Beta::BetaResponseInputImage }

        # A file input to the model.
        variant :input_file, -> { OpenAI::Beta::BetaResponseInputFile }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaResponseInputText, OpenAI::Models::Beta::BetaResponseInputImage, OpenAI::Models::Beta::BetaResponseInputFile)]
      end
    end

    BetaResponseInputContent = Beta::BetaResponseInputContent
  end
end
