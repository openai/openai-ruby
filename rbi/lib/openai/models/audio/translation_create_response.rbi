# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationCreateResponse < OpenAI::Union
        abstract!

        class << self
          # @api private
          sig do
            override
              .returns(
                [[NilClass, OpenAI::Models::Audio::Translation], [NilClass, OpenAI::Models::Audio::TranslationVerbose]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
