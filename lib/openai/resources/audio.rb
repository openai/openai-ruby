# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [Audio::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: Audio.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # Turn audio into text or text into audio.
      # @return [OpenAI::Resources::Audio::Transcriptions]
      attr_reader :transcriptions

      # Turn audio into text or text into audio.
      # @return [OpenAI::Resources::Audio::Translations]
      attr_reader :translations

      # Turn audio into text or text into audio.
      # @return [OpenAI::Resources::Audio::Speech]
      attr_reader :speech

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
        @transcriptions = OpenAI::Resources::Audio::Transcriptions.new(client: client)
        @translations = OpenAI::Resources::Audio::Translations.new(client: client)
        @speech = OpenAI::Resources::Audio::Speech.new(client: client)
      end

      class WithRawResponse
        # Turn audio into text or text into audio.
        # @return [OpenAI::Resources::Audio::Transcriptions::WithRawResponse]
        attr_reader :transcriptions

        # Turn audio into text or text into audio.
        # @return [OpenAI::Resources::Audio::Translations::WithRawResponse]
        attr_reader :translations

        # Turn audio into text or text into audio.
        # @return [OpenAI::Resources::Audio::Speech::WithRawResponse]
        attr_reader :speech

        # @api private
        #
        # @param resource [Audio]
        def initialize(resource:)
          @resource = resource

          @transcriptions =
            OpenAI::Resources::Audio::Transcriptions::WithRawResponse.new(
              resource: @resource.transcriptions
            )

          @translations =
            OpenAI::Resources::Audio::Translations::WithRawResponse.new(
              resource: @resource.translations
            )

          @speech =
            OpenAI::Resources::Audio::Speech::WithRawResponse.new(
              resource: @resource.speech
            )
        end
      end
    end
  end
end
