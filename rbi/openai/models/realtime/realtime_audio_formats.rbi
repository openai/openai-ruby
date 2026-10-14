# typed: strong

module OpenAI
  module Models

    module Realtime

      # The PCM audio format. Only a 24kHz sample rate is supported.
      module RealtimeAudioFormats
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
            OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
            OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
          )
        end

        class AudioPCM < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
              OpenAI::Internal::AnyHash
            )
          end

          # The sample rate of the audio. Always `24000`.
          sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger)) }
          attr_reader :rate

          sig { params(rate: OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger).void }
          attr_writer :rate

          # The audio format. Always `audio/pcm`.
          sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol).void }
          attr_writer :type

          # The PCM audio format. Only a 24kHz sample rate is supported.
          sig do
            params(

              rate: OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger,

              type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol
            )
              .returns(T.attached_class)
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
                rate: OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::OrInteger,
                type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The sample rate of the audio. Always `24000`.
          module Rate
            extend OpenAI::Internal::Type::Enum

            TaggedInteger = T.type_alias { T.all(Integer, OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate) }
            OrInteger = T.type_alias { Integer }

            RATE_24000 = T.let(24_000, OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::TaggedInteger)

            sig { override.returns(T::Array[OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Rate::TaggedInteger]) }
            def self.values
            end
          end

          # The audio format. Always `audio/pcm`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUDIO_PCM = T.let(:"audio/pcm", OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

        class AudioPCMU < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
              OpenAI::Internal::AnyHash
            )
          end

          # The audio format. Always `audio/pcmu`.
          sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol).void }
          attr_writer :type

          # The G.711 μ-law format.
          sig do
            params(

              type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The audio format. Always `audio/pcmu`.

            type: nil
          )
          end

          sig do
            override.returns(
              {type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::OrSymbol}
            )
          end
          def to_hash
          end

          # The audio format. Always `audio/pcmu`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUDIO_PCMU = T.let(:"audio/pcmu", OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

        class AudioPCMA < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA,
              OpenAI::Internal::AnyHash
            )
          end

          # The audio format. Always `audio/pcma`.
          sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol).void }
          attr_writer :type

          # The G.711 A-law format.
          sig do
            params(

              type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The audio format. Always `audio/pcma`.

            type: nil
          )
          end

          sig do
            override.returns(
              {type: OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::OrSymbol}
            )
          end
          def to_hash
          end

          # The audio format. Always `audio/pcma`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUDIO_PCMA = T.let(:"audio/pcma", OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

        sig { override.returns(T::Array[OpenAI::Realtime::RealtimeAudioFormats::Variants]) }
        def self.variants
        end

      end

    end

  end
end
