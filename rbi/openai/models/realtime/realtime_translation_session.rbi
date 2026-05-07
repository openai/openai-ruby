# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSession < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationSession,
              OpenAI::Internal::AnyHash
            )
          end

        # Unique identifier for the session that looks like `sess_1234567890abcdef`.
        sig { returns(String) }
        attr_accessor :id

        # Configuration for translation input and output audio.
        sig { returns(OpenAI::Realtime::RealtimeTranslationSession::Audio) }
        attr_reader :audio

        sig do
          params(
            audio: OpenAI::Realtime::RealtimeTranslationSession::Audio::OrHash
          ).void
        end
        attr_writer :audio

        # Expiration timestamp for the session, in seconds since epoch.
        sig { returns(Integer) }
        attr_accessor :expires_at

        # The Realtime translation model used for this session. This field is set at
        # session creation and cannot be changed with `session.update`.
        sig { returns(String) }
        attr_accessor :model

        # The session type. Always `translation` for Realtime translation sessions.
        sig { returns(Symbol) }
        attr_accessor :type

        # A Realtime translation session. Translation sessions continuously translate
        # input audio into the configured output language.
        sig do
          params(
            id: String,
            audio: OpenAI::Realtime::RealtimeTranslationSession::Audio::OrHash,
            expires_at: Integer,
            model: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the session that looks like `sess_1234567890abcdef`.
          id:,
          # Configuration for translation input and output audio.
          audio:,
          # Expiration timestamp for the session, in seconds since epoch.
          expires_at:,
          # The Realtime translation model used for this session. This field is set at
          # session creation and cannot be changed with `session.update`.
          model:,
          # The session type. Always `translation` for Realtime translation sessions.
          type: :translation
        )
        end

        sig do
          override.returns(
            {
              id: String,
              audio: OpenAI::Realtime::RealtimeTranslationSession::Audio,
              expires_at: Integer,
              model: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Audio < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranslationSession::Audio,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeTranslationSession::Audio::Input
              )
            )
          end
          attr_reader :input

          sig do
            params(
              input:
                OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::OrHash
            ).void
          end
          attr_writer :input

          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeTranslationSession::Audio::Output
              )
            )
          end
          attr_reader :output

          sig do
            params(
              output:
                OpenAI::Realtime::RealtimeTranslationSession::Audio::Output::OrHash
            ).void
          end
          attr_writer :output

          # Configuration for translation input and output audio.
          sig do
            params(
              input:
                OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::OrHash,
              output:
                OpenAI::Realtime::RealtimeTranslationSession::Audio::Output::OrHash
            ).returns(T.attached_class)
          end
          def self.new(input: nil, output: nil)
          end

          sig do
            override.returns(
              {
                input:
                  OpenAI::Realtime::RealtimeTranslationSession::Audio::Input,
                output:
                  OpenAI::Realtime::RealtimeTranslationSession::Audio::Output
              }
            )
          end
          def to_hash
          end

          class Input < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeTranslationSession::Audio::Input,
                  OpenAI::Internal::AnyHash
                )
              end

            # Optional input noise reduction.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction
                )
              )
            end
            attr_reader :noise_reduction

            sig do
              params(
                noise_reduction:
                  T.nilable(
                    OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction::OrHash
                  )
              ).void
            end
            attr_writer :noise_reduction

            # Optional source-language transcription. When configured, the server emits
            # `session.input_transcript.delta` events. Translation itself still runs from the
            # input audio stream.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::Transcription
                )
              )
            end
            attr_reader :transcription

            sig do
              params(
                transcription:
                  T.nilable(
                    OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::Transcription::OrHash
                  )
              ).void
            end
            attr_writer :transcription

            sig do
              params(
                noise_reduction:
                  T.nilable(
                    OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction::OrHash
                  ),
                transcription:
                  T.nilable(
                    OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::Transcription::OrHash
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # Optional input noise reduction.
              noise_reduction: nil,
              # Optional source-language transcription. When configured, the server emits
              # `session.input_transcript.delta` events. Translation itself still runs from the
              # input audio stream.
              transcription: nil
            )
            end

            sig do
              override.returns(
                {
                  noise_reduction:
                    T.nilable(
                      OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction
                    ),
                  transcription:
                    T.nilable(
                      OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::Transcription
                    )
                }
              )
            end
            def to_hash
            end

            class NoiseReduction < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Type of noise reduction. `near_field` is for close-talking microphones such as
              # headphones, `far_field` is for far-field microphones such as laptop or
              # conference room microphones.
              sig { returns(OpenAI::Realtime::NoiseReductionType::OrSymbol) }
              attr_accessor :type

              # Optional input noise reduction.
              sig do
                params(
                  type: OpenAI::Realtime::NoiseReductionType::OrSymbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Type of noise reduction. `near_field` is for close-talking microphones such as
                # headphones, `far_field` is for far-field microphones such as laptop or
                # conference room microphones.
                type:
              )
              end

              sig do
                override.returns(
                  { type: OpenAI::Realtime::NoiseReductionType::OrSymbol }
                )
              end
              def to_hash
              end
            end

            class Transcription < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::Transcription,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The transcription model used for source transcript deltas.
              sig { returns(String) }
              attr_accessor :model

              # Optional source-language transcription. When configured, the server emits
              # `session.input_transcript.delta` events. Translation itself still runs from the
              # input audio stream.
              sig { params(model: String).returns(T.attached_class) }
              def self.new(
                # The transcription model used for source transcript deltas.
                model:
              )
              end

              sig { override.returns({ model: String }) }
              def to_hash
              end
            end
          end

          class Output < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeTranslationSession::Audio::Output,
                  OpenAI::Internal::AnyHash
                )
              end

            # Target language for translated output audio and transcript deltas.
            sig { returns(T.nilable(String)) }
            attr_reader :language

            sig { params(language: String).void }
            attr_writer :language

            sig { params(language: String).returns(T.attached_class) }
            def self.new(
              # Target language for translated output audio and transcript deltas.
              language: nil
            )
            end

            sig { override.returns({ language: String }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
