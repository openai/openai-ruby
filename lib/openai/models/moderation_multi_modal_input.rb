# frozen_string_literal: true

module OpenAI
  module Models
    # An object describing an image to classify.
    module ModerationMultiModalInput
      extend OpenAI::Internal::Type::Union

      discriminator :type

      # An object describing an image to classify.
      variant :image_url, -> { OpenAI::ModerationImageURLInput }

      # An object describing text to classify.
      variant :text, -> { OpenAI::ModerationTextInput }

      # @!method self.variants
      #   @return [Array(OpenAI::ModerationImageURLInput, OpenAI::ModerationTextInput)]

      define_sorbet_constant!(:Variants) do
        T.type_alias { T.any(OpenAI::ModerationImageURLInput, OpenAI::ModerationTextInput) }
      end
    end
  end
end
