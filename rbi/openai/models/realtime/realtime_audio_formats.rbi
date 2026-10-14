# typed: strong

module OpenAI
  module Models
    module Realtime
      # The PCM audio format. Only a 24kHz sample rate is supported.
      module RealtimeAudioFormats
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
              OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
              OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
            )
          end

        class AudioPCM < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
                OpenAI::Internal::AnyHash
              )
            end

          # The sample rate of the audio. Always `24000`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger
              )
            )
          end
          attr_reader :rate

          sig do
            params(
              rate:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger
            ).void
          end
          attr_writer :rate

          # The audio format. Always `audio/pcm`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol
            ).void
          end
          attr_writer :type

          # The PCM audio format. Only a 24kHz sample rate is supported.
          sig do
            params(
              rate:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger,
              type:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The sample rate of the audio. Always `24000`.
            rate: nil,
            # The audio format. Always `audio/pcm`.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                rate:
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger,
                type:
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The sample rate of the audio. Always `24000`.
          module Rate
            extend OpenAI::Internal::Type::Enum

            TaggedInteger =
              T.type_alias do
                T.all(
                  Integer,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate
                )
              end
            OrInteger = T.type_alias { Integer }

            RATE_24000 =
              T.let(
                24_000,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::TaggedInteger
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::TaggedInteger
                ]
              )
            end
            def self.values
            end
          end

          # The audio format. Always `audio/pcm`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUDIO_PCM =
              T.let(
                :"audio/pcm",
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class AudioPCMU < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
                OpenAI::Internal::AnyHash
              )
            end

          # The audio format. Always `audio/pcmu`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol
            ).void
          end
          attr_writer :type

          # The G.711 μ-law format.
          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The audio format. Always `audio/pcmu`.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                type:
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The audio format. Always `audio/pcmu`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUDIO_PCMU =
              T.let(
                :"audio/pcmu",
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class AudioPCMA < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA,
                OpenAI::Internal::AnyHash
              )
            end

          # The audio format. Always `audio/pcma`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol
            ).void
          end
          attr_writer :type

          # The G.711 A-law format.
          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The audio format. Always `audio/pcma`.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                type:
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The audio format. Always `audio/pcma`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUDIO_PCMA =
              T.let(
                :"audio/pcma",
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeAudioFormats::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
