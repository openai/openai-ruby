# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseCreateAudioOutput < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeResponseCreateAudioOutput,
              OpenAI::Internal::AnyHash
            )
          end

        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output
            )
          )
        end
        attr_reader :output

        sig do
          params(
            output:
              OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::OrHash
          ).void
        end
        attr_writer :output

        # Configuration for audio input and output.
        sig do
          params(
            output:
              OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::OrHash
          ).returns(T.attached_class)
        end
        def self.new(output: nil)
        end

        sig do
          override.returns(
            {
              output:
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output
            }
          )
        end
        def to_hash
        end

        class Output < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output,
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

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
          # and `cedar`. We recommend `marin` and `cedar` for best quality.
          sig do
            returns(
              T.nilable(
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol
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
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol
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
              voice:
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol
                )
            ).returns(T.attached_class)
          end
          def self.new(
            # The format of the output audio.
            format_: nil,
            # The voice the model uses to respond. Voice cannot be changed during the session
            # once the model has responded with audio at least once. Current voice options are
            # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
            # and `cedar`. We recommend `marin` and `cedar` for best quality.
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
                voice:
                  T.any(
                    String,
                    OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol
                  )
              }
            )
          end
          def to_hash
          end

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
          # and `cedar`. We recommend `marin` and `cedar` for best quality.
          module Voice
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::Variants
                ]
              )
            end
            def self.variants
            end

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ALLOY =
              T.let(
                :alloy,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            ASH =
              T.let(
                :ash,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            BALLAD =
              T.let(
                :ballad,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            CORAL =
              T.let(
                :coral,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            ECHO =
              T.let(
                :echo,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            SAGE =
              T.let(
                :sage,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            SHIMMER =
              T.let(
                :shimmer,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            VERSE =
              T.let(
                :verse,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            MARIN =
              T.let(
                :marin,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
            CEDAR =
              T.let(
                :cedar,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol
              )
          end
        end
      end
    end
  end
end
