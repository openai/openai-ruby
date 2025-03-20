# typed: strong

module OpenAI
  module Models
    # An object describing an image to classify.
    module ModerationMultiModalInput
      extend OpenAI::Union

      Variants =
        type_template(:out) { {fixed: T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)} }

      class << self
        sig { override.returns([OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput]) }
        def variants
        end
      end
    end
  end
end
