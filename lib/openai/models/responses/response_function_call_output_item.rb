# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # A piece of message content, such as text, an image, or a file.
      module ResponseFunctionCallOutputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A text input to the model.
        variant :input_text, -> { OpenAI::Responses::ResponseInputTextContent }

        # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision)
        variant :input_image, -> { OpenAI::Responses::ResponseInputImageContent }

        # A file input to the model.
        variant :input_file, -> { OpenAI::Responses::ResponseInputFileContent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponseInputTextContent, OpenAI::Models::Responses::ResponseInputImageContent, OpenAI::Models::Responses::ResponseInputFileContent)]
      end
    end
  end
end
