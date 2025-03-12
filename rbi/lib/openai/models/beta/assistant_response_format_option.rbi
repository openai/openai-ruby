# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantResponseFormatOption < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[NilClass, Symbol], [NilClass, OpenAI::Models::ResponseFormatText], [NilClass, OpenAI::Models::ResponseFormatJSONObject], [NilClass, OpenAI::Models::ResponseFormatJSONSchema]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
