# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @abstract
      #
      # Multi-modal input and output contents.
      class ResponseContent < OpenAI::Union
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
      end
    end
  end
end
