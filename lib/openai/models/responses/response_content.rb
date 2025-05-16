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

        # A text output from the model.
        variant -> { OpenAI::Responses::ResponseOutputText }

        # A refusal from the model.
        variant -> { OpenAI::Responses::ResponseOutputRefusal }

        # @!method self.variants
        #   @return [Array(OpenAI::Responses::ResponseInputText, OpenAI::Responses::ResponseInputImage, OpenAI::Responses::ResponseInputFile, OpenAI::Responses::ResponseOutputText, OpenAI::Responses::ResponseOutputRefusal)]

        define_sorbet_constant!(:Variants) do
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputText,
              OpenAI::Responses::ResponseInputImage,
              OpenAI::Responses::ResponseInputFile,
              OpenAI::Responses::ResponseOutputText,
              OpenAI::Responses::ResponseOutputRefusal
            )
          end
        end
      end
    end
  end
end
