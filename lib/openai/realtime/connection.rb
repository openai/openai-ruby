# frozen_string_literal: true

module OpenAI
  module Realtime
    # A live, typed Realtime WebSocket connection.
    class Connection < OpenAI::Realtime::BaseConnection
      # @return [OpenAI::Realtime::ConnectionResources::Session]
      attr_reader :session

      # @return [OpenAI::Realtime::ConnectionResources::Response]
      attr_reader :response

      # @return [OpenAI::Realtime::ConnectionResources::InputAudioBuffer]
      attr_reader :input_audio_buffer

      # @return [OpenAI::Realtime::ConnectionResources::Conversation]
      attr_reader :conversation

      # @api private
      def initialize(socket:, url:)
        super(
          socket: socket,
          url: url,
          server_event_type: OpenAI::Realtime::RealtimeServerEvent,
          client_event_type: OpenAI::Realtime::RealtimeClientEvent
        )
        @session = OpenAI::Realtime::ConnectionResources::Session.new(self)
        @response = OpenAI::Realtime::ConnectionResources::Response.new(self)
        @input_audio_buffer = OpenAI::Realtime::ConnectionResources::InputAudioBuffer.new(self)
        @conversation = OpenAI::Realtime::ConnectionResources::Conversation.new(self)
      end
    end
  end
end
