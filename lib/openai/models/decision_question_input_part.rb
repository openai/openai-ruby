# frozen_string_literal: true

module OpenAI
  module Models
    # A text, image, or JSON content part in a question instruction.
    module DecisionQuestionInputPart
      extend OpenAI::Internal::Type::Union

      discriminator :type

      variant :input_text, -> { OpenAI::DecisionQuestionInputText }

      # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL. File IDs are not supported.
      variant :input_image, -> { OpenAI::DecisionQuestionInputImage }

      # A JSON object or an array of objects rendered as text. Nested values may be any JSON value. Limited to 32 container levels, 10,000 values, and 256 KiB of compact UTF-8 JSON.
      variant :input_json, -> { OpenAI::DecisionInputJSON }

      # @!method self.variants
      #   @return [Array(OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON)]
    end
  end
end
