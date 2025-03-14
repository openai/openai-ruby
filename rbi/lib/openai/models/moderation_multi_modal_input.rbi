# typed: strong

module OpenAI
  module Models
    # An object describing an image to classify.
    class ModerationMultiModalInput < OpenAI::Union
      abstract!

      class << self
        # @api private
        sig do
          override
            .returns(
              [[Symbol, OpenAI::Models::ModerationImageURLInput], [Symbol, OpenAI::Models::ModerationTextInput]]
            )
        end
        private def variants
        end
      end
    end
  end
end
