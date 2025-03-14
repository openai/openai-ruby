# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # @return [OpenAI::Resources::Audio::Transcriptions]
      attr_reader :transcriptions

      # @return [OpenAI::Resources::Audio::Translations]
      attr_reader :translations

      # @return [OpenAI::Resources::Audio::Speech]
      attr_reader :speech

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @transcriptions = OpenAI::Resources::Audio::Transcriptions.new(client: client)
        @translations = OpenAI::Resources::Audio::Translations.new(client: client)
        @speech = OpenAI::Resources::Audio::Speech.new(client: client)
      end
    end
  end
end
