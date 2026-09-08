# frozen_string_literal: true

require_relative "../../openai"
require_relative "local_audio"
require_relative "realtime_audio/configuration"
require_relative "realtime_audio/output"
require_relative "realtime_audio/session"

module OpenAI
  module Helpers
    module Realtime
      module AudioConnections
        def connect_audio(
          model:,
          voice:,
          mode: :server_vad,
          input_device: nil,
          output_device: nil,
          playback_policy: :duplex,
          turn_detection: {},
          session: {},
          audio_options: {},
          websocket_base_url: nil,
          request_options: nil,
          transport_options: {}
        )
          raise ArgumentError, "A block is required." unless block_given?
          configuration = OpenAI::Realtime::AudioConfiguration.new(
            voice: voice,
            mode: mode,
            playback_policy: playback_policy,
            turn_detection: turn_detection,
            session: session,
            audio_options: audio_options
          )
          audio = OpenAI::Realtime::AudioSession.new(
            resource: self,
            configuration: configuration,
            input_device: input_device,
            output_device: output_device,
            connection_options: {
              model: model,
              websocket_base_url: websocket_base_url,
              request_options: request_options,
              transport_options: transport_options
            }
          )
          begin
            yield audio
          ensure
            pending = $!
            begin
              audio.close
              audio.raise_failure
            rescue StandardError
              raise unless pending
            end
          end
        end
      end
    end
  end
end

OpenAI::Resources::Realtime.include(OpenAI::Helpers::Realtime::AudioConnections)
