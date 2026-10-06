# frozen_string_literal: true

module OpenAI
  module Models
    # An inline image. External URLs and file IDs are not supported.
    module DecisionInputPart
      extend OpenAI::Internal::Type::Union

      discriminator :type

      variant :input_text, -> { OpenAI::DecisionInputText }

      # An inline image. External URLs and file IDs are not supported.
      variant :input_image, -> { OpenAI::DecisionInputImage }

      # @!method self.variants
      #   @return [Array(OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage)]
    end
  end
end
