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

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile, OpenAI::Models::Responses::ResponseInputAudio, OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
      end
    end
  end
end
