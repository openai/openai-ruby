# typed: strong

module OpenAI
  module Models

    module Live

      # Audio encoding and sample rate for audio sent and received over a Live WebSocket
      # connection. WebRTC and SIP negotiate their media format separately.
      module AudioFormat
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::AudioFormat::AudioPCM,
            OpenAI::Live::AudioFormat::AudioPCMU,
            OpenAI::Live::AudioFormat::AudioPCMA
          )
        end

        class AudioPCM < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::AudioFormat::AudioPCM,
              OpenAI::Internal::AnyHash
            )
          end

          # Audio sample rate in hertz. Live WebSocket PCM audio supports 16000 or 24000 Hz.
          sig { returns(OpenAI::Live::AudioFormat::AudioPCM::Rate::OrInteger) }
          attr_accessor :rate

          # The audio encoding. Always `audio/pcm`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Raw, mono 16-bit little-endian PCM audio for a Live WebSocket connection.
          sig do
            params(

              rate: OpenAI::Live::AudioFormat::AudioPCM::Rate::OrInteger,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Audio sample rate in hertz. Live WebSocket PCM audio supports 16000 or 24000 Hz.
            rate:,

            # The audio encoding. Always `audio/pcm`.

            type: :"audio/pcm"
          )
          end

          sig do
            override.returns(
              {rate: OpenAI::Live::AudioFormat::AudioPCM::Rate::OrInteger, type: Symbol}
            )
          end
          def to_hash
          end

          # Audio sample rate in hertz. Live WebSocket PCM audio supports 16000 or 24000 Hz.
          module Rate
            extend OpenAI::Internal::Type::Enum

            TaggedInteger = T.type_alias { T.all(Integer, OpenAI::Live::AudioFormat::AudioPCM::Rate) }
            OrInteger = T.type_alias { Integer }

            RATE_16000 = T.let(16_000, OpenAI::Live::AudioFormat::AudioPCM::Rate::TaggedInteger)
            RATE_24000 = T.let(24_000, OpenAI::Live::AudioFormat::AudioPCM::Rate::TaggedInteger)

            sig { override.returns(T::Array[OpenAI::Live::AudioFormat::AudioPCM::Rate::TaggedInteger]) }
            def self.values
            end
          end
        end

        class AudioPCMU < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::AudioFormat::AudioPCMU,
              OpenAI::Internal::AnyHash
            )
          end

          # Audio sample rate in hertz. G.711 audio uses 8000 Hz.
          sig { returns(Integer) }
          attr_accessor :rate

          # The audio encoding. Always `audio/pcmu`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Raw, mono G.711 μ-law audio for a Live WebSocket connection.
          sig do
            params(

              rate: Integer,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Audio sample rate in hertz. G.711 audio uses 8000 Hz.
            rate:,

            # The audio encoding. Always `audio/pcmu`.

            type: :"audio/pcmu"
          )
          end

          sig do
            override.returns(
              {rate: Integer, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class AudioPCMA < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::AudioFormat::AudioPCMA,
              OpenAI::Internal::AnyHash
            )
          end

          # Audio sample rate in hertz. G.711 audio uses 8000 Hz.
          sig { returns(Integer) }
          attr_accessor :rate

          # The audio encoding. Always `audio/pcma`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Raw, mono G.711 A-law audio for a Live WebSocket connection.
          sig do
            params(

              rate: Integer,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Audio sample rate in hertz. G.711 audio uses 8000 Hz.
            rate:,

            # The audio encoding. Always `audio/pcma`.

            type: :"audio/pcma"
          )
          end

          sig do
            override.returns(
              {rate: Integer, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Live::AudioFormat::Variants]) }
        def self.variants
        end

      end

    end

  end
end
