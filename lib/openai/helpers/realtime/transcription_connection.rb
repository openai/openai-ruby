# frozen_string_literal: true

module OpenAI
  module Realtime
    # A live connection for streaming transcription sessions.
    class TranscriptionConnection < OpenAI::Realtime::BaseConnection
      # @return [OpenAI::Realtime::ConnectionResources::TranscriptionSession]
      attr_reader :session

      # @return [OpenAI::Realtime::ConnectionResources::InputAudioBuffer]
      attr_reader :input_audio_buffer

      # @api private
      def initialize(socket:, url:)
        super(
          socket: socket,
          url: url,
          server_event_type: OpenAI::Realtime::RealtimeServerEvent,
          client_event_type: OpenAI::Realtime::RealtimeClientEvent
        )
        @session = OpenAI::Realtime::ConnectionResources::TranscriptionSession.new(self)
        @input_audio_buffer = OpenAI::Realtime::ConnectionResources::InputAudioBuffer.new(self)
      end
    end
  end
end
