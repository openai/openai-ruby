# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Translations#create
      module TranslationCreateResponse
        extend OpenAI::Union

        variant -> { OpenAI::Models::Audio::Translation }

        variant -> { OpenAI::Models::Audio::TranslationVerbose }

        # @!parse
        #   # @return [Array(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose)]
        #   def self.variants; end
      end
    end
  end
end
