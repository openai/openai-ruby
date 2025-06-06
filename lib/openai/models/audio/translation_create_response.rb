# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Translations#create
      module TranslationCreateResponse
        extend OpenAI::Internal::Type::Union

        variant -> { OpenAI::Audio::Translation }

        variant -> { OpenAI::Audio::TranslationVerbose }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose)]
      end
    end
  end
end
