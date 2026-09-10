# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # Audio encoding and sample rate for audio sent and received over a Live WebSocket
      # connection. WebRTC and SIP negotiate their media format separately.
      module AudioFormat
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Raw, mono 16-bit little-endian PCM audio for a Live WebSocket connection.
        variant :"audio/pcm", -> { OpenAI::Live::AudioFormat::AudioPCM }

        # Raw, mono G.711 μ-law audio for a Live WebSocket connection.
        variant :"audio/pcmu", -> { OpenAI::Live::AudioFormat::AudioPCMU }

        # Raw, mono G.711 A-law audio for a Live WebSocket connection.
        variant :"audio/pcma", -> { OpenAI::Live::AudioFormat::AudioPCMA }

        class AudioPCM < OpenAI::Internal::Type::BaseModel
          # @!attribute rate
          #   Audio sample rate in hertz. Live WebSocket PCM audio supports 16000 or 24000 Hz.
          #
          #   @return [Integer, OpenAI::Models::Live::AudioFormat::AudioPCM::Rate]
          required :rate, enum: -> { OpenAI::Live::AudioFormat::AudioPCM::Rate }

          # @!attribute type
          #   The audio encoding. Always `audio/pcm`.
          #
          #   @return [Symbol, :"audio/pcm"]
          required :type, const: :"audio/pcm"

          # @!method initialize(rate:, type: :"audio/pcm")
          #   Raw, mono 16-bit little-endian PCM audio for a Live WebSocket connection.
          #
          #   @param rate [Integer, OpenAI::Models::Live::AudioFormat::AudioPCM::Rate]
          #     Audio sample rate in hertz. Live WebSocket PCM audio supports 16000 or 24000 Hz.
          #
          #   @param type [Symbol, :"audio/pcm"]
          #     The audio encoding. Always `audio/pcm`.

          # Audio sample rate in hertz. Live WebSocket PCM audio supports 16000 or 24000 Hz.
          #
          # @see OpenAI::Models::Live::AudioFormat::AudioPCM#rate
          module Rate
            extend OpenAI::Internal::Type::Enum

            RATE_16000 = 16_000
            RATE_24000 = 24_000

            # @!method self.values
            #   @return [Array<Integer>]
          end
        end

        class AudioPCMU < OpenAI::Internal::Type::BaseModel
          # @!attribute rate
          #   Audio sample rate in hertz. G.711 audio uses 8000 Hz.
          #
          #   @return [Integer]
          required :rate, Integer

          # @!attribute type
          #   The audio encoding. Always `audio/pcmu`.
          #
          #   @return [Symbol, :"audio/pcmu"]
          required :type, const: :"audio/pcmu"

          # @!method initialize(rate:, type: :"audio/pcmu")
          #   Raw, mono G.711 μ-law audio for a Live WebSocket connection.
          #
          #   @param rate [Integer]
          #     Audio sample rate in hertz. G.711 audio uses 8000 Hz.
          #
          #   @param type [Symbol, :"audio/pcmu"]
          #     The audio encoding. Always `audio/pcmu`.
        end

        class AudioPCMA < OpenAI::Internal::Type::BaseModel
          # @!attribute rate
          #   Audio sample rate in hertz. G.711 audio uses 8000 Hz.
          #
          #   @return [Integer]
          required :rate, Integer

          # @!attribute type
          #   The audio encoding. Always `audio/pcma`.
          #
          #   @return [Symbol, :"audio/pcma"]
          required :type, const: :"audio/pcma"

          # @!method initialize(rate:, type: :"audio/pcma")
          #   Raw, mono G.711 A-law audio for a Live WebSocket connection.
          #
          #   @param rate [Integer]
          #     Audio sample rate in hertz. G.711 audio uses 8000 Hz.
          #
          #   @param type [Symbol, :"audio/pcma"]
          #     The audio encoding. Always `audio/pcma`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Live::AudioFormat::AudioPCM, OpenAI::Models::Live::AudioFormat::AudioPCMU, OpenAI::Models::Live::AudioFormat::AudioPCMA)]
      end
    end
  end
end
