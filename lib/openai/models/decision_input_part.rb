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

      # @!method self.variants
      #   @return [Array(OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage)]
    end
  end
end
