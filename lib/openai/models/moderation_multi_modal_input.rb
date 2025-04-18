# frozen_string_literal: true

module OpenAI
  module Models
    # An object describing an image to classify.
    module ModerationMultiModalInput
      extend OpenAI::Internal::Type::Union

      discriminator :type

      # An object describing an image to classify.
      variant :image_url, -> { OpenAI::Models::ModerationImageURLInput }

      # An object describing text to classify.
      variant :text, -> { OpenAI::Models::ModerationTextInput }

      # @!method self.variants
      #   @return [Array(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
    end
  end
end
