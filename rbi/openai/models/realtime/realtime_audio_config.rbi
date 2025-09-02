# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeAudioConfig < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioConfig,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioConfig::Input)) }
        attr_reader :input

        sig do
          params(
            input: OpenAI::Realtime::RealtimeAudioConfig::Input::OrHash
          ).void
        end
        attr_writer :input

        sig do
          returns(T.nilable(OpenAI::Realtime::RealtimeAudioConfig::Output))
        end
        attr_reader :output

        sig do
          params(
            output: OpenAI::Realtime::RealtimeAudioConfig::Output::OrHash
          ).void
        end
        attr_writer :output

        # Configuration for input and output audio.
        sig do
          params(
            input: OpenAI::Realtime::RealtimeAudioConfig::Input::OrHash,
            output: OpenAI::Realtime::RealtimeAudioConfig::Output::OrHash
          ).returns(T.attached_class)
        end
        def self.new(input: nil, output: nil)
        end

        sig do
          override.returns(
            {
              input: OpenAI::Realtime::RealtimeAudioConfig::Input,
              output: OpenAI::Realtime::RealtimeAudioConfig::Output
            }
          )
        end
        def to_hash
        end

        class Input < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeAudioConfig::Input,
                OpenAI::Internal::AnyHash
              )
            end

          # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          # (mono), and little-endian byte order.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioConfig::Input::Format::OrSymbol
              )
            )
          end
          attr_reader :format_

          sig do
            params(
              format_:
                OpenAI::Realtime::RealtimeAudioConfig::Input::Format::OrSymbol
            ).void
          end
          attr_writer :format_

          # Configuration for input audio noise reduction. This can be set to `null` to turn
          # off. Noise reduction filters audio added to the input audio buffer before it is
          # sent to VAD and the model. Filtering the audio can improve VAD and turn
          # detection accuracy (reducing false positives) and model performance by improving
          # perception of the input audio.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction
              )
            )
          end
          attr_reader :noise_reduction

          sig do
            params(
              noise_reduction:
                OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::OrHash
            ).void
          end
          attr_writer :noise_reduction

          # Configuration for input audio transcription, defaults to off and can be set to
          # `null` to turn off once on. Input audio transcription is not native to the
          # model, since the model consumes audio directly. Transcription runs
          # asynchronously through
          # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
          # and should be treated as guidance of input audio content rather than precisely
          # what the model heard. The client can optionally set the language and prompt for
          # transcription, these offer additional guidance to the transcription service.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription
              )
            )
          end
          attr_reader :transcription

          sig do
            params(
              transcription:
                OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::OrHash
            ).void
          end
          attr_writer :transcription

          # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
          # set to `null` to turn off, in which case the client must manually trigger model
          # response. Server VAD means that the model will detect the start and end of
          # speech based on audio volume and respond at the end of user speech. Semantic VAD
          # is more advanced and uses a turn detection model (in conjunction with VAD) to
          # semantically estimate whether the user has finished speaking, then dynamically
          # sets a timeout based on this probability. For example, if user audio trails off
          # with "uhhm", the model will score a low probability of turn end and wait longer
          # for the user to continue speaking. This can be useful for more natural
          # conversations, but may have a higher latency.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection
              )
            )
          end
          attr_reader :turn_detection

          sig do
            params(
              turn_detection:
                OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::OrHash
            ).void
          end
          attr_writer :turn_detection

          sig do
            params(
              format_:
                OpenAI::Realtime::RealtimeAudioConfig::Input::Format::OrSymbol,
              noise_reduction:
                OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::OrHash,
              transcription:
                OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::OrHash,
              turn_detection:
                OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
            # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
            # (mono), and little-endian byte order.
            format_: nil,
            # Configuration for input audio noise reduction. This can be set to `null` to turn
            # off. Noise reduction filters audio added to the input audio buffer before it is
            # sent to VAD and the model. Filtering the audio can improve VAD and turn
            # detection accuracy (reducing false positives) and model performance by improving
            # perception of the input audio.
            noise_reduction: nil,
            # Configuration for input audio transcription, defaults to off and can be set to
            # `null` to turn off once on. Input audio transcription is not native to the
            # model, since the model consumes audio directly. Transcription runs
            # asynchronously through
            # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
            # and should be treated as guidance of input audio content rather than precisely
            # what the model heard. The client can optionally set the language and prompt for
            # transcription, these offer additional guidance to the transcription service.
            transcription: nil,
            # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
            # set to `null` to turn off, in which case the client must manually trigger model
            # response. Server VAD means that the model will detect the start and end of
            # speech based on audio volume and respond at the end of user speech. Semantic VAD
            # is more advanced and uses a turn detection model (in conjunction with VAD) to
            # semantically estimate whether the user has finished speaking, then dynamically
            # sets a timeout based on this probability. For example, if user audio trails off
            # with "uhhm", the model will score a low probability of turn end and wait longer
            # for the user to continue speaking. This can be useful for more natural
            # conversations, but may have a higher latency.
            turn_detection: nil
          )
          end

          sig do
            override.returns(
              {
                format_:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Format::OrSymbol,
                noise_reduction:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction,
                transcription:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription,
                turn_detection:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection
              }
            )
          end
          def to_hash
          end

          # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          # (mono), and little-endian byte order.
          module Format
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Format
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PCM16 =
              T.let(
                :pcm16,
                OpenAI::Realtime::RealtimeAudioConfig::Input::Format::TaggedSymbol
              )
            G711_ULAW =
              T.let(
                :g711_ulaw,
                OpenAI::Realtime::RealtimeAudioConfig::Input::Format::TaggedSymbol
              )
            G711_ALAW =
              T.let(
                :g711_alaw,
                OpenAI::Realtime::RealtimeAudioConfig::Input::Format::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Format::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class NoiseReduction < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction,
                  OpenAI::Internal::AnyHash
                )
              end

            # Type of noise reduction. `near_field` is for close-talking microphones such as
            # headphones, `far_field` is for far-field microphones such as laptop or
            # conference room microphones.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type::OrSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type::OrSymbol
              ).void
            end
            attr_writer :type

            # Configuration for input audio noise reduction. This can be set to `null` to turn
            # off. Noise reduction filters audio added to the input audio buffer before it is
            # sent to VAD and the model. Filtering the audio can improve VAD and turn
            # detection accuracy (reducing false positives) and model performance by improving
            # perception of the input audio.
            sig do
              params(
                type:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Type of noise reduction. `near_field` is for close-talking microphones such as
              # headphones, `far_field` is for far-field microphones such as laptop or
              # conference room microphones.
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  type:
                    OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # Type of noise reduction. `near_field` is for close-talking microphones such as
            # headphones, `far_field` is for far-field microphones such as laptop or
            # conference room microphones.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              NEAR_FIELD =
                T.let(
                  :near_field,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type::TaggedSymbol
                )
              FAR_FIELD =
                T.let(
                  :far_field,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type::TaggedSymbol
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
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription,
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

            # The model to use for transcription. Current options are `whisper-1`,
            # `gpt-4o-transcribe-latest`, `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and
            # `gpt-4o-transcribe-diarize`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::OrSymbol
                )
              )
            end
            attr_reader :model

            sig do
              params(
                model:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::OrSymbol
              ).void
            end
            attr_writer :model

            # An optional text to guide the model's style or continue a previous audio
            # segment. For `whisper-1`, the
            # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
            # For `gpt-4o-transcribe` models, the prompt is a free text string, for example
            # "expect words related to technology".
            sig { returns(T.nilable(String)) }
            attr_reader :prompt

            sig { params(prompt: String).void }
            attr_writer :prompt

            # Configuration for input audio transcription, defaults to off and can be set to
            # `null` to turn off once on. Input audio transcription is not native to the
            # model, since the model consumes audio directly. Transcription runs
            # asynchronously through
            # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
            # and should be treated as guidance of input audio content rather than precisely
            # what the model heard. The client can optionally set the language and prompt for
            # transcription, these offer additional guidance to the transcription service.
            sig do
              params(
                language: String,
                model:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::OrSymbol,
                prompt: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The language of the input audio. Supplying the input language in
              # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
              # format will improve accuracy and latency.
              language: nil,
              # The model to use for transcription. Current options are `whisper-1`,
              # `gpt-4o-transcribe-latest`, `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and
              # `gpt-4o-transcribe-diarize`.
              model: nil,
              # An optional text to guide the model's style or continue a previous audio
              # segment. For `whisper-1`, the
              # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
              # For `gpt-4o-transcribe` models, the prompt is a free text string, for example
              # "expect words related to technology".
              prompt: nil
            )
            end

            sig do
              override.returns(
                {
                  language: String,
                  model:
                    OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::OrSymbol,
                  prompt: String
                }
              )
            end
            def to_hash
            end

            # The model to use for transcription. Current options are `whisper-1`,
            # `gpt-4o-transcribe-latest`, `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and
            # `gpt-4o-transcribe-diarize`.
            module Model
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              WHISPER_1 =
                T.let(
                  :"whisper-1",
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::TaggedSymbol
                )
              GPT_4O_TRANSCRIBE_LATEST =
                T.let(
                  :"gpt-4o-transcribe-latest",
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::TaggedSymbol
                )
              GPT_4O_MINI_TRANSCRIBE =
                T.let(
                  :"gpt-4o-mini-transcribe",
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::TaggedSymbol
                )
              GPT_4O_TRANSCRIBE =
                T.let(
                  :"gpt-4o-transcribe",
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::TaggedSymbol
                )
              GPT_4O_TRANSCRIBE_DIARIZE =
                T.let(
                  :"gpt-4o-transcribe-diarize",
                  OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model::TaggedSymbol
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
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether or not to automatically generate a response when a VAD stop event
            # occurs.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :create_response

            sig { params(create_response: T::Boolean).void }
            attr_writer :create_response

            # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
            # will wait longer for the user to continue speaking, `high` will respond more
            # quickly. `auto` is the default and is equivalent to `medium`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::OrSymbol
                )
              )
            end
            attr_reader :eagerness

            sig do
              params(
                eagerness:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::OrSymbol
              ).void
            end
            attr_writer :eagerness

            # Optional idle timeout after which turn detection will auto-timeout when no
            # additional audio is received.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :idle_timeout_ms

            # Whether or not to automatically interrupt any ongoing response with output to
            # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
            # occurs.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :interrupt_response

            sig { params(interrupt_response: T::Boolean).void }
            attr_writer :interrupt_response

            # Used only for `server_vad` mode. Amount of audio to include before the VAD
            # detected speech (in milliseconds). Defaults to 300ms.
            sig { returns(T.nilable(Integer)) }
            attr_reader :prefix_padding_ms

            sig { params(prefix_padding_ms: Integer).void }
            attr_writer :prefix_padding_ms

            # Used only for `server_vad` mode. Duration of silence to detect speech stop (in
            # milliseconds). Defaults to 500ms. With shorter values the model will respond
            # more quickly, but may jump in on short pauses from the user.
            sig { returns(T.nilable(Integer)) }
            attr_reader :silence_duration_ms

            sig { params(silence_duration_ms: Integer).void }
            attr_writer :silence_duration_ms

            # Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
            # defaults to 0.5. A higher threshold will require louder audio to activate the
            # model, and thus might perform better in noisy environments.
            sig { returns(T.nilable(Float)) }
            attr_reader :threshold

            sig { params(threshold: Float).void }
            attr_writer :threshold

            # Type of turn detection.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type::OrSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type::OrSymbol
              ).void
            end
            attr_writer :type

            # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
            # set to `null` to turn off, in which case the client must manually trigger model
            # response. Server VAD means that the model will detect the start and end of
            # speech based on audio volume and respond at the end of user speech. Semantic VAD
            # is more advanced and uses a turn detection model (in conjunction with VAD) to
            # semantically estimate whether the user has finished speaking, then dynamically
            # sets a timeout based on this probability. For example, if user audio trails off
            # with "uhhm", the model will score a low probability of turn end and wait longer
            # for the user to continue speaking. This can be useful for more natural
            # conversations, but may have a higher latency.
            sig do
              params(
                create_response: T::Boolean,
                eagerness:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::OrSymbol,
                idle_timeout_ms: T.nilable(Integer),
                interrupt_response: T::Boolean,
                prefix_padding_ms: Integer,
                silence_duration_ms: Integer,
                threshold: Float,
                type:
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Whether or not to automatically generate a response when a VAD stop event
              # occurs.
              create_response: nil,
              # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
              # will wait longer for the user to continue speaking, `high` will respond more
              # quickly. `auto` is the default and is equivalent to `medium`.
              eagerness: nil,
              # Optional idle timeout after which turn detection will auto-timeout when no
              # additional audio is received.
              idle_timeout_ms: nil,
              # Whether or not to automatically interrupt any ongoing response with output to
              # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
              # occurs.
              interrupt_response: nil,
              # Used only for `server_vad` mode. Amount of audio to include before the VAD
              # detected speech (in milliseconds). Defaults to 300ms.
              prefix_padding_ms: nil,
              # Used only for `server_vad` mode. Duration of silence to detect speech stop (in
              # milliseconds). Defaults to 500ms. With shorter values the model will respond
              # more quickly, but may jump in on short pauses from the user.
              silence_duration_ms: nil,
              # Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
              # defaults to 0.5. A higher threshold will require louder audio to activate the
              # model, and thus might perform better in noisy environments.
              threshold: nil,
              # Type of turn detection.
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  create_response: T::Boolean,
                  eagerness:
                    OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::OrSymbol,
                  idle_timeout_ms: T.nilable(Integer),
                  interrupt_response: T::Boolean,
                  prefix_padding_ms: Integer,
                  silence_duration_ms: Integer,
                  threshold: Float,
                  type:
                    OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
            # will wait longer for the user to continue speaking, `high` will respond more
            # quickly. `auto` is the default and is equivalent to `medium`.
            module Eagerness
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              LOW =
                T.let(
                  :low,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::TaggedSymbol
                )
              MEDIUM =
                T.let(
                  :medium,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::TaggedSymbol
                )
              HIGH =
                T.let(
                  :high,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::TaggedSymbol
                )
              AUTO =
                T.let(
                  :auto,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # Type of turn detection.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              SERVER_VAD =
                T.let(
                  :server_vad,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type::TaggedSymbol
                )
              SEMANTIC_VAD =
                T.let(
                  :semantic_vad,
                  OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end
        end

        class Output < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeAudioConfig::Output,
                OpenAI::Internal::AnyHash
              )
            end

          # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          # For `pcm16`, output audio is sampled at a rate of 24kHz.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeAudioConfig::Output::Format::OrSymbol
              )
            )
          end
          attr_reader :format_

          sig do
            params(
              format_:
                OpenAI::Realtime::RealtimeAudioConfig::Output::Format::OrSymbol
            ).void
          end
          attr_writer :format_

          # The speed of the model's spoken response. 1.0 is the default speed. 0.25 is the
          # minimum speed. 1.5 is the maximum speed. This value can only be changed in
          # between model turns, not while a response is in progress.
          sig { returns(T.nilable(Float)) }
          attr_reader :speed

          sig { params(speed: Float).void }
          attr_writer :speed

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
          # and `cedar`.
          sig do
            returns(
              T.nilable(
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::OrSymbol
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
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::OrSymbol
                )
            ).void
          end
          attr_writer :voice

          sig do
            params(
              format_:
                OpenAI::Realtime::RealtimeAudioConfig::Output::Format::OrSymbol,
              speed: Float,
              voice:
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::OrSymbol
                )
            ).returns(T.attached_class)
          end
          def self.new(
            # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            # For `pcm16`, output audio is sampled at a rate of 24kHz.
            format_: nil,
            # The speed of the model's spoken response. 1.0 is the default speed. 0.25 is the
            # minimum speed. 1.5 is the maximum speed. This value can only be changed in
            # between model turns, not while a response is in progress.
            speed: nil,
            # The voice the model uses to respond. Voice cannot be changed during the session
            # once the model has responded with audio at least once. Current voice options are
            # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
            # and `cedar`.
            voice: nil
          )
          end

          sig do
            override.returns(
              {
                format_:
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Format::OrSymbol,
                speed: Float,
                voice:
                  T.any(
                    String,
                    OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::OrSymbol
                  )
              }
            )
          end
          def to_hash
          end

          # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          # For `pcm16`, output audio is sampled at a rate of 24kHz.
          module Format
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Format
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PCM16 =
              T.let(
                :pcm16,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Format::TaggedSymbol
              )
            G711_ULAW =
              T.let(
                :g711_ulaw,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Format::TaggedSymbol
              )
            G711_ALAW =
              T.let(
                :g711_alaw,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Format::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Format::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
          # and `cedar`.
          module Voice
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::Variants
                ]
              )
            end
            def self.variants
            end

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeAudioConfig::Output::Voice
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ALLOY =
              T.let(
                :alloy,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            ASH =
              T.let(
                :ash,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            BALLAD =
              T.let(
                :ballad,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            CORAL =
              T.let(
                :coral,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            ECHO =
              T.let(
                :echo,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            SAGE =
              T.let(
                :sage,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            SHIMMER =
              T.let(
                :shimmer,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            VERSE =
              T.let(
                :verse,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            MARIN =
              T.let(
                :marin,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
            CEDAR =
              T.let(
                :cedar,
                OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol
              )
          end
        end
      end
    end
  end
end
