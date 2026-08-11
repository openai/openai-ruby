# frozen_string_literal: true

module OpenAI
  module Realtime
    # A live connection for the dedicated continuous translation protocol.
    class TranslationConnection < OpenAI::Realtime::BaseConnection
      # @return [OpenAI::Realtime::ConnectionResources::TranslationSession]
      attr_reader :session

      # @return [OpenAI::Realtime::ConnectionResources::TranslationInputAudioBuffer]
      attr_reader :input_audio_buffer

      # @api private
      def initialize(socket:, url:)
        super(
          socket: socket,
          url: url,
          server_event_type: OpenAI::Realtime::RealtimeTranslationServerEvent,
          client_event_type: OpenAI::Realtime::RealtimeTranslationClientEvent
        )
        @session = OpenAI::Realtime::ConnectionResources::TranslationSession.new(self)
        @input_audio_buffer = OpenAI::Realtime::ConnectionResources::TranslationInputAudioBuffer.new(self)
      end
    end
  end
end
