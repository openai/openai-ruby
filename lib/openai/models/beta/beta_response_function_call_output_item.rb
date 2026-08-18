# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A piece of message content, such as text, an image, or a file.
      module BetaResponseFunctionCallOutputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A text input to the model.
        variant :input_text, -> { OpenAI::Beta::BetaResponseInputTextContent }

        # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision)
        variant :input_image, -> { OpenAI::Beta::BetaResponseInputImageContent }

        # A file input to the model.
        variant :input_file, -> { OpenAI::Beta::BetaResponseInputFileContent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaResponseInputTextContent, OpenAI::Models::Beta::BetaResponseInputImageContent, OpenAI::Models::Beta::BetaResponseInputFileContent)]
      end
    end

    BetaResponseFunctionCallOutputItem = Beta::BetaResponseFunctionCallOutputItem
  end
end
