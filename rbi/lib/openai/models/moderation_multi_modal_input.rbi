# typed: strong

module OpenAI
  module Models
    class ModerationMultiModalInput < OpenAI::Union
      abstract!

      class << self
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
