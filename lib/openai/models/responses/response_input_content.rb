# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # A text input to the model.
      module ResponseInputContent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A text input to the model.
        variant :input_text, -> { OpenAI::Models::Responses::ResponseInputText }

        # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant :input_image, -> { OpenAI::Models::Responses::ResponseInputImage }

        # A file input to the model.
        variant :input_file, -> { OpenAI::Models::Responses::ResponseInputFile }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile)]
      end
    end
  end
end
