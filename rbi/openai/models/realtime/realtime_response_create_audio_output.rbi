# typed: strong

module OpenAI
  module Models

    module Realtime

      class RealtimeResponseCreateAudioOutput < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Realtime::RealtimeResponseCreateAudioOutput,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(T.nilable(OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output)) }
        attr_reader :output

        sig { params(output: OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::OrHash).void }
        attr_writer :output

        # Configuration for audio input and output.
        sig do
          params(

            output: OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          output: nil
        )
        end

        sig do
          override.returns(
            {output: OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output}
          )
        end
        def to_hash
        end

        class Output < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output,
              OpenAI::Internal::AnyHash
            )
          end

          # The format of the output audio.
          sig {
            returns(
              T.nilable(
                T.any(
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
                )
              )
            )
          }
          attr_reader :format_

          sig {
            params(
              format_: T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
              )
            )
              .void
          }
          attr_writer :format_

          # The voice the model uses to respond. Supported built-in voices are `alloy`,
          # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
          # `cedar`. You may also provide a custom voice object with an `id`, for example
          # `{ "id": "voice_1234" }`. Voice cannot be changed during the session once the
          # model has responded with audio at least once. We recommend `marin` and `cedar`
          # for best quality.
          sig {
            returns(
              T.nilable(
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID
                )
              )
            )
          }
          attr_reader :voice

          sig {
            params(
              voice: T.any(
                String,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID::OrHash
              )
            )
              .void
          }
          attr_writer :voice

          sig do
            params(

              format_: T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
              ),

              voice: T.any(
                String,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID::OrHash
              )
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The format of the output audio.
            format_: nil,

            # The voice the model uses to respond. Supported built-in voices are `alloy`,
            # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
            # `cedar`. You may also provide a custom voice object with an `id`, for example
            # `{ "id": "voice_1234" }`. Voice cannot be changed during the session once the
            # model has responded with audio at least once. We recommend `marin` and `cedar`
            # for best quality.

            voice: nil
          )
          end

          sig do
            override.returns(
              {
                format_: T.any(
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
                ),
                voice: T.any(
                  String,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::OrSymbol,
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID
                )
              }
            )
          end
          def to_hash
          end

          # The voice the model uses to respond. Supported built-in voices are `alloy`,
          # `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`, and
          # `cedar`. You may also provide a custom voice object with an `id`, for example
          # `{ "id": "voice_1234" }`. Voice cannot be changed during the session once the
          # model has responded with audio at least once. We recommend `marin` and `cedar`
          # for best quality.
          module Voice
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                String,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol,
                OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID
              )
            }

            class ID < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::ID,
                  OpenAI::Internal::AnyHash
                )
              end

              # The custom voice ID, e.g. `voice_1234`.
              sig { returns(String) }
              attr_accessor :id

              # Custom voice reference.
              sig do
                params(

                  id: String
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The custom voice ID, e.g. `voice_1234`.

                id:
              )
              end

              sig do
                override.returns(
                  {id: String}
                )
              end
              def to_hash
              end

            end

            sig {
              override.returns(T::Array[OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::Variants])
            }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ALLOY = T.let(:alloy, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            ASH = T.let(:ash, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            BALLAD = T.let(:ballad, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            CORAL = T.let(:coral, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            ECHO = T.let(:echo, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            SAGE = T.let(:sage, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            SHIMMER = T.let(:shimmer, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            VERSE = T.let(:verse, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            MARIN = T.let(:marin, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)
            CEDAR = T.let(:cedar, OpenAI::Realtime::RealtimeResponseCreateAudioOutput::Output::Voice::TaggedSymbol)

          end
        end

      end

    end

  end
end
