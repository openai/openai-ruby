# frozen_string_literal: true

module OpenAI
  module Models
    # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
    # File IDs are not supported.
    module DecisionInputPart
      extend OpenAI::Internal::Type::Union

      discriminator :type

      variant :input_text, -> { OpenAI::DecisionInputText }

      # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL. File IDs are not supported.
      variant :input_image, -> { OpenAI::DecisionInputImage }

      # A JSON object or an array of objects rendered as text. Nested values may be any JSON value. Limited to 32 container levels, 10,000 values, and 256 KiB of compact UTF-8 JSON.
      variant :input_json, -> { OpenAI::DecisionInputJSON }

      # @!method self.variants
      #   @return [Array(OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage, OpenAI::Models::DecisionInputJSON)]
    end
  end
end
