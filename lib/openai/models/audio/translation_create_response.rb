# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Translations#create
      module TranslationCreateResponse
        extend OpenAI::Internal::Type::Union

        variant -> { OpenAI::Models::Audio::Translation }

        variant -> { OpenAI::Models::Audio::TranslationVerbose }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose)]
      end
    end
  end
end
