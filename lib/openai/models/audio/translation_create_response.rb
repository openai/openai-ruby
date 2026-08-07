# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
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
