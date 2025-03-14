# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    #
    # An object describing an image to classify.
    class ModerationMultiModalInput < OpenAI::Union
      discriminator :type

      # An object describing an image to classify.
      variant :image_url, -> { OpenAI::Models::ModerationImageURLInput }

      # An object describing text to classify.
      variant :text, -> { OpenAI::Models::ModerationTextInput }

      # @!parse
      #   class << self
      #     # @return [Array(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
      #     def variants; end
      #   end
    end
  end
end
