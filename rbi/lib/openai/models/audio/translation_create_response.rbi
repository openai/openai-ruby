# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationCreateResponse < OpenAI::Union
        abstract!

        Variants = type_template(:out) { {fixed: T.any(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose)} }
      end
    end
  end
end
