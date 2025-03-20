# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      module TranslationCreateResponse
        extend OpenAI::Union

        variant -> { OpenAI::Models::Audio::Translation }

        variant -> { OpenAI::Models::Audio::TranslationVerbose }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose)]
        #     def variants; end
        #   end
      end
    end
  end
end
