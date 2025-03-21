# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Multi-modal input and output contents.
      module ResponseContent
        extend OpenAI::Union

        # A text input to the model.
        variant -> { OpenAI::Models::Responses::ResponseInputText }

        # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant -> { OpenAI::Models::Responses::ResponseInputImage }

        # A file input to the model.
        variant -> { OpenAI::Models::Responses::ResponseInputFile }

        # A text output from the model.
        variant -> { OpenAI::Models::Responses::ResponseOutputText }

        # A refusal from the model.
        variant -> { OpenAI::Models::Responses::ResponseOutputRefusal }

        # @!parse
        #   # @return [Array(OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile, OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
        #   def self.variants; end
      end
    end
  end
end
