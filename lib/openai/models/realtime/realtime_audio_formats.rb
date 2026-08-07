# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # The PCM audio format. Only a 24kHz sample rate is supported.
      module RealtimeAudioFormats
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # The PCM audio format. Only a 24kHz sample rate is supported.
        variant :"audio/pcm", -> { OpenAI::Realtime::RealtimeAudioFormats::AudioPCM }

        # The G.711 μ-law format.
        variant :"audio/pcmu", -> { OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU }

        # The G.711 A-law format.
        variant :"audio/pcma", -> { OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA }

        class AudioPCM < OpenAI::Internal::Type::BaseModel
          # @!attribute rate
          #   The sample rate of the audio. Always `24000`.
          #
          #   @return [Integer, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM::Rate, nil]
          optional :rate, enum: -> { OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate }

          # @!attribute type
          #   The audio format. Always `audio/pcm`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type }

          # @!method initialize(rate: nil, type: nil)
          #   The PCM audio format. Only a 24kHz sample rate is supported.
          #
          #   @param rate [Integer, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM::Rate] The sample rate of the audio. Always `24000`.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM::Type] The audio format. Always `audio/pcm`.

          # The sample rate of the audio. Always `24000`.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM#rate
          module Rate
            extend OpenAI::Internal::Type::Enum

            RATE_24000 = 24_000

            # @!method self.values
            #   @return [Array<Integer>]
          end

          # The audio format. Always `audio/pcm`.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM#type
          module Type
            extend OpenAI::Internal::Type::Enum

            AUDIO_PCM = :"audio/pcm"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class AudioPCMU < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The audio format. Always `audio/pcmu`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type }

          # @!method initialize(type: nil)
          #   The G.711 μ-law format.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU::Type] The audio format. Always `audio/pcmu`.

          # The audio format. Always `audio/pcmu`.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU#type
          module Type
            extend OpenAI::Internal::Type::Enum

            AUDIO_PCMU = :"audio/pcmu"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class AudioPCMA < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The audio format. Always `audio/pcma`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type }

          # @!method initialize(type: nil)
          #   The G.711 A-law format.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA::Type] The audio format. Always `audio/pcma`.

          # The audio format. Always `audio/pcma`.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA#type
          module Type
            extend OpenAI::Internal::Type::Enum

            AUDIO_PCMA = :"audio/pcma"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA)]
      end
    end
  end
end
