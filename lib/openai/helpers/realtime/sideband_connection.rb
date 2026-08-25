# frozen_string_literal: true

module OpenAI
  module Realtime
    # A server-side control connection attached to an existing WebRTC or SIP call.
    class SidebandConnection < OpenAI::Realtime::Connection
      # @return [OpenAI::Realtime::ConnectionResources::OutputAudioBuffer]
      attr_reader :output_audio_buffer

      # @api private
      def initialize(socket:, url:)
        super
        @output_audio_buffer = OpenAI::Realtime::ConnectionResources::OutputAudioBuffer.new(self)
      end
    end
  end
end
