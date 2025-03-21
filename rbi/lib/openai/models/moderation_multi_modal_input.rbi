# typed: strong

module OpenAI
  module Models
    # An object describing an image to classify.
    module ModerationMultiModalInput
      extend OpenAI::Union

      sig { override.returns([OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput]) }
      def self.variants
      end
    end
  end
end
