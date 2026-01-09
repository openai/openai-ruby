# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeAudioConfigOutput < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioConfigOutput,
              OpenAI::Internal::AnyHash
            )
          end

        # The format of the output audio.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
              )
            )
          )
        end
        attr_reader :format_

        sig do
          params(
            format_:
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
              )
          ).void
        end
        attr_writer :format_

        # The speed of the model's spoken response as a multiple of the original speed.
        # 1.0 is the default speed. 0.25 is the minimum speed. 1.5 is the maximum speed.
        # This value can only be changed in between model turns, not while a response is
        # in progress.
        #
        # This parameter is a post-processing adjustment to the audio after it is
        # generated, it's also possible to prompt the model to speak faster or slower.
        sig { returns(T.nilable(Float)) }
        attr_reader :speed

        sig { params(speed: Float).void }
        attr_writer :speed

        # The voice the model uses to respond. Supported built-in voices are `alloy`,
        # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
        # `cedar`. Voice cannot be changed during the session once the model has responded
        # with audio at least once. We recommend `marin` and `cedar` for best quality.
        sig do
          returns(
            T.nilable(
              T.any(
                String,
                OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::OrSymbol
              )
            )
          )
        end
        attr_reader :voice

        sig do
          params(
            voice:
              T.any(
                String,
                OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::OrSymbol
              )
          ).void
        end
        attr_writer :voice

        sig do
          params(
            format_:
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
              ),
            speed: Float,
            voice:
              T.any(
                String,
                OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::OrSymbol
              )
          ).returns(T.attached_class)
        end
        def self.new(
          # The format of the output audio.
          format_: nil,
          # The speed of the model's spoken response as a multiple of the original speed.
          # 1.0 is the default speed. 0.25 is the minimum speed. 1.5 is the maximum speed.
          # This value can only be changed in between model turns, not while a response is
          # in progress.
          #
          # This parameter is a post-processing adjustment to the audio after it is
          # generated, it's also possible to prompt the model to speak faster or slower.
          speed: nil,
          # The voice the model uses to respond. Supported built-in voices are `alloy`,
          # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
          # `cedar`. Voice cannot be changed during the session once the model has responded
          # with audio at least once. We recommend `marin` and `cedar` for best quality.
          voice: nil
        )
        end

        sig do
          override.returns(
            {
              format_:
                T.any(
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
                ),
              speed: Float,
              voice:
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::OrSymbol
                )
            }
          )
        end
        def to_hash
        end

        # The voice the model uses to respond. Supported built-in voices are `alloy`,
        # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
        # `cedar`. Voice cannot be changed during the session once the model has responded
        # with audio at least once. We recommend `marin` and `cedar` for best quality.
        module Voice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::Variants
              ]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeAudioConfigOutput::Voice)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ALLOY =
            T.let(
              :alloy,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          ASH =
            T.let(
              :ash,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          BALLAD =
            T.let(
              :ballad,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          CORAL =
            T.let(
              :coral,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          ECHO =
            T.let(
              :echo,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          SAGE =
            T.let(
              :sage,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          SHIMMER =
            T.let(
              :shimmer,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          VERSE =
            T.let(
              :verse,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          MARIN =
            T.let(
              :marin,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
          CEDAR =
            T.let(
              :cedar,
              OpenAI::Realtime::RealtimeAudioConfigOutput::Voice::TaggedSymbol
            )
        end
      end
    end
  end
end
