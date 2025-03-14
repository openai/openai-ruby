# typed: strong

module OpenAI
  module Models
    # An object describing an image to classify.
    class ModerationMultiModalInput < OpenAI::Union
      abstract!

      class << self
        sig { override.returns([OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput]) }
        def variants
        end
      end
    end
  end
end
