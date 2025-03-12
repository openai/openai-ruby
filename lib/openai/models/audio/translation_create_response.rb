# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @abstract
      #
      class TranslationCreateResponse < OpenAI::Union
        variant -> { OpenAI::Models::Audio::Translation }

        variant -> { OpenAI::Models::Audio::TranslationVerbose }
      end
    end
  end
end
