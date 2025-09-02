# typed: strong

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # A Realtime transcription session configuration object.
        sig do
          returns(OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session)
        end
        attr_reader :session

        sig do
          params(
            session:
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::OrHash
          ).void
        end
        attr_writer :session

        # The event type, must be `transcription_session.updated`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a transcription session is updated with a
        # `transcription_session.update` event, unless there is an error.
        sig do
          params(
            event_id: String,
            session:
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # A Realtime transcription session configuration object.
          session:,
          # The event type, must be `transcription_session.updated`.
          type: :"transcription_session.updated"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Session < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session,
                OpenAI::Internal::AnyHash
              )
            end

          # Unique identifier for the session that looks like `sess_1234567890abcdef`.
          sig { returns(T.nilable(String)) }
          attr_reader :id

          sig { params(id: String).void }
          attr_writer :id

          # Configuration for input audio for the session.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio
              )
            )
          end
          attr_reader :audio

          sig do
            params(
              audio:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::OrHash
            ).void
          end
          attr_writer :audio

          # Expiration timestamp for the session, in seconds since epoch.
          sig { returns(T.nilable(Integer)) }
          attr_reader :expires_at

          sig { params(expires_at: Integer).void }
          attr_writer :expires_at

          # Additional fields to include in server outputs.
          #
          # - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          #   transcription.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Include::OrSymbol
                ]
              )
            )
          end
          attr_reader :include

          sig do
            params(
              include:
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Include::OrSymbol
                ]
            ).void
          end
          attr_writer :include

          # The object type. Always `realtime.transcription_session`.
          sig { returns(T.nilable(String)) }
          attr_reader :object

          sig { params(object: String).void }
          attr_writer :object

          # A Realtime transcription session configuration object.
          sig do
            params(
              id: String,
              audio:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::OrHash,
              expires_at: Integer,
              include:
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Include::OrSymbol
                ],
              object: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique identifier for the session that looks like `sess_1234567890abcdef`.
            id: nil,
            # Configuration for input audio for the session.
            audio: nil,
            # Expiration timestamp for the session, in seconds since epoch.
            expires_at: nil,
            # Additional fields to include in server outputs.
            #
            # - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
            #   transcription.
            include: nil,
            # The object type. Always `realtime.transcription_session`.
            object: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                audio:
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio,
                expires_at: Integer,
                include:
                  T::Array[
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Include::OrSymbol
                  ],
                object: String
              }
            )
          end
          def to_hash
          end

          class Audio < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio,
                  OpenAI::Internal::AnyHash
                )
              end

            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input
                )
              )
            end
            attr_reader :input

            sig do
              params(
                input:
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::OrHash
              ).void
            end
            attr_writer :input

            # Configuration for input audio for the session.
            sig do
              params(
                input:
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::OrHash
              ).returns(T.attached_class)
            end
            def self.new(input: nil)
            end

            sig do
              override.returns(
                {
                  input:
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input
                }
              )
            end
            def to_hash
            end

            class Input < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
              sig { returns(T.nilable(String)) }
              attr_reader :format_

              sig { params(format_: String).void }
              attr_writer :format_

              # Configuration for input audio noise reduction.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction
                  )
                )
              end
              attr_reader :noise_reduction

              sig do
                params(
                  noise_reduction:
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::OrHash
                ).void
              end
              attr_writer :noise_reduction

              # Configuration of the transcription model.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription
                  )
                )
              end
              attr_reader :transcription

              sig do
                params(
                  transcription:
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::OrHash
                ).void
              end
              attr_writer :transcription

              # Configuration for turn detection.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::TurnDetection
                  )
                )
              end
              attr_reader :turn_detection

              sig do
                params(
                  turn_detection:
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::TurnDetection::OrHash
                ).void
              end
              attr_writer :turn_detection

              sig do
                params(
                  format_: String,
                  noise_reduction:
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::OrHash,
                  transcription:
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::OrHash,
                  turn_detection:
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::TurnDetection::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
                format_: nil,
                # Configuration for input audio noise reduction.
                noise_reduction: nil,
                # Configuration of the transcription model.
                transcription: nil,
                # Configuration for turn detection.
                turn_detection: nil
              )
              end

              sig do
                override.returns(
                  {
                    format_: String,
                    noise_reduction:
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction,
                    transcription:
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription,
                    turn_detection:
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::TurnDetection
                  }
                )
              end
              def to_hash
              end

              class NoiseReduction < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction,
                      OpenAI::Internal::AnyHash
                    )
                  end

                sig do
                  returns(
                    T.nilable(
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type::OrSymbol
                    )
                  )
                end
                attr_reader :type

                sig do
                  params(
                    type:
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type::OrSymbol
                  ).void
                end
                attr_writer :type

                # Configuration for input audio noise reduction.
                sig do
                  params(
                    type:
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type::OrSymbol
                  ).returns(T.attached_class)
                end
                def self.new(type: nil)
                end

                sig do
                  override.returns(
                    {
                      type:
                        OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type::OrSymbol
                    }
                  )
                end
                def to_hash
                end

                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(
                        Symbol,
                        OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  NEAR_FIELD =
                    T.let(
                      :near_field,
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type::TaggedSymbol
                    )
                  FAR_FIELD =
                    T.let(
                      :far_field,
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::NoiseReduction::Type::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end
              end

              class Transcription < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The language of the input audio. Supplying the input language in
                # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
                # format will improve accuracy and latency.
                sig { returns(T.nilable(String)) }
                attr_reader :language

                sig { params(language: String).void }
                attr_writer :language

                # The model to use for transcription. Can be `gpt-4o-transcribe`,
                # `gpt-4o-mini-transcribe`, or `whisper-1`.
                sig do
                  returns(
                    T.nilable(
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::OrSymbol
                    )
                  )
                end
                attr_reader :model

                sig do
                  params(
                    model:
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::OrSymbol
                  ).void
                end
                attr_writer :model

                # An optional text to guide the model's style or continue a previous audio
                # segment. The
                # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
                # should match the audio language.
                sig { returns(T.nilable(String)) }
                attr_reader :prompt

                sig { params(prompt: String).void }
                attr_writer :prompt

                # Configuration of the transcription model.
                sig do
                  params(
                    language: String,
                    model:
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::OrSymbol,
                    prompt: String
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The language of the input audio. Supplying the input language in
                  # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
                  # format will improve accuracy and latency.
                  language: nil,
                  # The model to use for transcription. Can be `gpt-4o-transcribe`,
                  # `gpt-4o-mini-transcribe`, or `whisper-1`.
                  model: nil,
                  # An optional text to guide the model's style or continue a previous audio
                  # segment. The
                  # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
                  # should match the audio language.
                  prompt: nil
                )
                end

                sig do
                  override.returns(
                    {
                      language: String,
                      model:
                        OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::OrSymbol,
                      prompt: String
                    }
                  )
                end
                def to_hash
                end

                # The model to use for transcription. Can be `gpt-4o-transcribe`,
                # `gpt-4o-mini-transcribe`, or `whisper-1`.
                module Model
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(
                        Symbol,
                        OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  GPT_4O_TRANSCRIBE =
                    T.let(
                      :"gpt-4o-transcribe",
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::TaggedSymbol
                    )
                  GPT_4O_MINI_TRANSCRIBE =
                    T.let(
                      :"gpt-4o-mini-transcribe",
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::TaggedSymbol
                    )
                  WHISPER_1 =
                    T.let(
                      :"whisper-1",
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::Transcription::Model::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end
              end

              class TurnDetection < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Audio::Input::TurnDetection,
                      OpenAI::Internal::AnyHash
                    )
                  end

                sig { returns(T.nilable(Integer)) }
                attr_reader :prefix_padding_ms

                sig { params(prefix_padding_ms: Integer).void }
                attr_writer :prefix_padding_ms

                sig { returns(T.nilable(Integer)) }
                attr_reader :silence_duration_ms

                sig { params(silence_duration_ms: Integer).void }
                attr_writer :silence_duration_ms

                sig { returns(T.nilable(Float)) }
                attr_reader :threshold

                sig { params(threshold: Float).void }
                attr_writer :threshold

                # Type of turn detection, only `server_vad` is currently supported.
                sig { returns(T.nilable(String)) }
                attr_reader :type

                sig { params(type: String).void }
                attr_writer :type

                # Configuration for turn detection.
                sig do
                  params(
                    prefix_padding_ms: Integer,
                    silence_duration_ms: Integer,
                    threshold: Float,
                    type: String
                  ).returns(T.attached_class)
                end
                def self.new(
                  prefix_padding_ms: nil,
                  silence_duration_ms: nil,
                  threshold: nil,
                  # Type of turn detection, only `server_vad` is currently supported.
                  type: nil
                )
                end

                sig do
                  override.returns(
                    {
                      prefix_padding_ms: Integer,
                      silence_duration_ms: Integer,
                      threshold: Float,
                      type: String
                    }
                  )
                end
                def to_hash
                end
              end
            end
          end

          module Include
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Include
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
              T.let(
                :"item.input_audio_transcription.logprobs",
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Include::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Include::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
