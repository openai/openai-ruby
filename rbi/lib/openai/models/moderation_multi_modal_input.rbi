# typed: strong

module OpenAI
  module Models
    # An object describing an image to classify.
    class ModerationMultiModalInput < OpenAI::Union
      abstract!

      Variants = type_template(:out) { {fixed: T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)} }
    end
  end
end
