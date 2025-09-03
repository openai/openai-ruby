# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeSession < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::RealtimeSession, OpenAI::Internal::AnyHash)
          end

        # Unique identifier for the session that looks like `sess_1234567890abcdef`.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

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
              T::Array[OpenAI::Realtime::RealtimeSession::Include::OrSymbol]
            )
          )
        end
        attr_accessor :include

        # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
        # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
        # (mono), and little-endian byte order.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeSession::InputAudioFormat::OrSymbol
            )
          )
        end
        attr_reader :input_audio_format

        sig do
          params(
            input_audio_format:
              OpenAI::Realtime::RealtimeSession::InputAudioFormat::OrSymbol
          ).void
        end
        attr_writer :input_audio_format

        # Configuration for input audio noise reduction. This can be set to `null` to turn
        # off. Noise reduction filters audio added to the input audio buffer before it is
        # sent to VAD and the model. Filtering the audio can improve VAD and turn
        # detection accuracy (reducing false positives) and model performance by improving
        # perception of the input audio.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction
            )
          )
        end
        attr_reader :input_audio_noise_reduction

        sig do
          params(
            input_audio_noise_reduction:
              OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::OrHash
          ).void
        end
        attr_writer :input_audio_noise_reduction

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
              OpenAI::Realtime::RealtimeSession::InputAudioTranscription
            )
          )
        end
        attr_reader :input_audio_transcription

        sig do
          params(
            input_audio_transcription:
              T.nilable(
                OpenAI::Realtime::RealtimeSession::InputAudioTranscription::OrHash
              )
          ).void
        end
        attr_writer :input_audio_transcription

        # The default system instructions (i.e. system message) prepended to model calls.
        # This field allows the client to guide the model on desired responses. The model
        # can be instructed on response content and format, (e.g. "be extremely succinct",
        # "act friendly", "here are examples of good responses") and on audio behavior
        # (e.g. "talk quickly", "inject emotion into your voice", "laugh frequently"). The
        # instructions are not guaranteed to be followed by the model, but they provide
        # guidance to the model on the desired behavior.
        #
        # Note that the server sets default instructions which will be used if this field
        # is not set and are visible in the `session.created` event at the start of the
        # session.
        sig { returns(T.nilable(String)) }
        attr_reader :instructions

        sig { params(instructions: String).void }
        attr_writer :instructions

        # Maximum number of output tokens for a single assistant response, inclusive of
        # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        sig { returns(T.nilable(T.any(Integer, Symbol))) }
        attr_reader :max_response_output_tokens

        sig { params(max_response_output_tokens: T.any(Integer, Symbol)).void }
        attr_writer :max_response_output_tokens

        # The set of modalities the model can respond with. To disable audio, set this to
        # ["text"].
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Realtime::RealtimeSession::Modality::OrSymbol]
            )
          )
        end
        attr_reader :modalities

        sig do
          params(
            modalities:
              T::Array[OpenAI::Realtime::RealtimeSession::Modality::OrSymbol]
          ).void
        end
        attr_writer :modalities

        # The Realtime model used for this session.
        sig do
          returns(T.nilable(OpenAI::Realtime::RealtimeSession::Model::OrSymbol))
        end
        attr_reader :model

        sig do
          params(model: OpenAI::Realtime::RealtimeSession::Model::OrSymbol).void
        end
        attr_writer :model

        # The object type. Always `realtime.session`.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeSession::Object::OrSymbol)
          )
        end
        attr_reader :object

        sig do
          params(
            object: OpenAI::Realtime::RealtimeSession::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        # For `pcm16`, output audio is sampled at a rate of 24kHz.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeSession::OutputAudioFormat::OrSymbol
            )
          )
        end
        attr_reader :output_audio_format

        sig do
          params(
            output_audio_format:
              OpenAI::Realtime::RealtimeSession::OutputAudioFormat::OrSymbol
          ).void
        end
        attr_writer :output_audio_format

        # Reference to a prompt template and its variables.
        # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        sig { returns(T.nilable(OpenAI::Responses::ResponsePrompt)) }
        attr_reader :prompt

        sig do
          params(
            prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash)
          ).void
        end
        attr_writer :prompt

        # The speed of the model's spoken response. 1.0 is the default speed. 0.25 is the
        # minimum speed. 1.5 is the maximum speed. This value can only be changed in
        # between model turns, not while a response is in progress.
        sig { returns(T.nilable(Float)) }
        attr_reader :speed

        sig { params(speed: Float).void }
        attr_writer :speed

        # Sampling temperature for the model, limited to [0.6, 1.2]. For audio models a
        # temperature of 0.8 is highly recommended for best performance.
        sig { returns(T.nilable(Float)) }
        attr_reader :temperature

        sig { params(temperature: Float).void }
        attr_writer :temperature

        # How the model chooses tools. Options are `auto`, `none`, `required`, or specify
        # a function.
        sig { returns(T.nilable(String)) }
        attr_reader :tool_choice

        sig { params(tool_choice: String).void }
        attr_writer :tool_choice

        # Tools (functions) available to the model.
        sig do
          returns(T.nilable(T::Array[OpenAI::Realtime::RealtimeSession::Tool]))
        end
        attr_reader :tools

        sig do
          params(
            tools: T::Array[OpenAI::Realtime::RealtimeSession::Tool::OrHash]
          ).void
        end
        attr_writer :tools

        # Configuration options for tracing. Set to null to disable tracing. Once tracing
        # is enabled for a session, the configuration cannot be modified.
        #
        # `auto` will create a trace for the session with default values for the workflow
        # name, group id, and metadata.
        sig do
          returns(
            T.nilable(
              T.any(
                Symbol,
                OpenAI::Realtime::RealtimeSession::Tracing::TracingConfiguration
              )
            )
          )
        end
        attr_accessor :tracing

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
          returns(T.nilable(OpenAI::Realtime::RealtimeSession::TurnDetection))
        end
        attr_reader :turn_detection

        sig do
          params(
            turn_detection:
              T.nilable(
                OpenAI::Realtime::RealtimeSession::TurnDetection::OrHash
              )
          ).void
        end
        attr_writer :turn_detection

        # The voice the model uses to respond. Voice cannot be changed during the session
        # once the model has responded with audio at least once. Current voice options are
        # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
        sig do
          returns(
            T.nilable(
              T.any(String, OpenAI::Realtime::RealtimeSession::Voice::OrSymbol)
            )
          )
        end
        attr_reader :voice

        sig do
          params(
            voice:
              T.any(String, OpenAI::Realtime::RealtimeSession::Voice::OrSymbol)
          ).void
        end
        attr_writer :voice

        # Realtime session object.
        sig do
          params(
            id: String,
            expires_at: Integer,
            include:
              T.nilable(
                T::Array[OpenAI::Realtime::RealtimeSession::Include::OrSymbol]
              ),
            input_audio_format:
              OpenAI::Realtime::RealtimeSession::InputAudioFormat::OrSymbol,
            input_audio_noise_reduction:
              OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::OrHash,
            input_audio_transcription:
              T.nilable(
                OpenAI::Realtime::RealtimeSession::InputAudioTranscription::OrHash
              ),
            instructions: String,
            max_response_output_tokens: T.any(Integer, Symbol),
            modalities:
              T::Array[OpenAI::Realtime::RealtimeSession::Modality::OrSymbol],
            model: OpenAI::Realtime::RealtimeSession::Model::OrSymbol,
            object: OpenAI::Realtime::RealtimeSession::Object::OrSymbol,
            output_audio_format:
              OpenAI::Realtime::RealtimeSession::OutputAudioFormat::OrSymbol,
            prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
            speed: Float,
            temperature: Float,
            tool_choice: String,
            tools: T::Array[OpenAI::Realtime::RealtimeSession::Tool::OrHash],
            tracing:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Realtime::RealtimeSession::Tracing::TracingConfiguration::OrHash
                )
              ),
            turn_detection:
              T.nilable(
                OpenAI::Realtime::RealtimeSession::TurnDetection::OrHash
              ),
            voice:
              T.any(String, OpenAI::Realtime::RealtimeSession::Voice::OrSymbol)
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the session that looks like `sess_1234567890abcdef`.
          id: nil,
          # Expiration timestamp for the session, in seconds since epoch.
          expires_at: nil,
          # Additional fields to include in server outputs.
          #
          # - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          #   transcription.
          include: nil,
          # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          # (mono), and little-endian byte order.
          input_audio_format: nil,
          # Configuration for input audio noise reduction. This can be set to `null` to turn
          # off. Noise reduction filters audio added to the input audio buffer before it is
          # sent to VAD and the model. Filtering the audio can improve VAD and turn
          # detection accuracy (reducing false positives) and model performance by improving
          # perception of the input audio.
          input_audio_noise_reduction: nil,
          # Configuration for input audio transcription, defaults to off and can be set to
          # `null` to turn off once on. Input audio transcription is not native to the
          # model, since the model consumes audio directly. Transcription runs
          # asynchronously through
          # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
          # and should be treated as guidance of input audio content rather than precisely
          # what the model heard. The client can optionally set the language and prompt for
          # transcription, these offer additional guidance to the transcription service.
          input_audio_transcription: nil,
          # The default system instructions (i.e. system message) prepended to model calls.
          # This field allows the client to guide the model on desired responses. The model
          # can be instructed on response content and format, (e.g. "be extremely succinct",
          # "act friendly", "here are examples of good responses") and on audio behavior
          # (e.g. "talk quickly", "inject emotion into your voice", "laugh frequently"). The
          # instructions are not guaranteed to be followed by the model, but they provide
          # guidance to the model on the desired behavior.
          #
          # Note that the server sets default instructions which will be used if this field
          # is not set and are visible in the `session.created` event at the start of the
          # session.
          instructions: nil,
          # Maximum number of output tokens for a single assistant response, inclusive of
          # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
          # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
          max_response_output_tokens: nil,
          # The set of modalities the model can respond with. To disable audio, set this to
          # ["text"].
          modalities: nil,
          # The Realtime model used for this session.
          model: nil,
          # The object type. Always `realtime.session`.
          object: nil,
          # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          # For `pcm16`, output audio is sampled at a rate of 24kHz.
          output_audio_format: nil,
          # Reference to a prompt template and its variables.
          # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
          prompt: nil,
          # The speed of the model's spoken response. 1.0 is the default speed. 0.25 is the
          # minimum speed. 1.5 is the maximum speed. This value can only be changed in
          # between model turns, not while a response is in progress.
          speed: nil,
          # Sampling temperature for the model, limited to [0.6, 1.2]. For audio models a
          # temperature of 0.8 is highly recommended for best performance.
          temperature: nil,
          # How the model chooses tools. Options are `auto`, `none`, `required`, or specify
          # a function.
          tool_choice: nil,
          # Tools (functions) available to the model.
          tools: nil,
          # Configuration options for tracing. Set to null to disable tracing. Once tracing
          # is enabled for a session, the configuration cannot be modified.
          #
          # `auto` will create a trace for the session with default values for the workflow
          # name, group id, and metadata.
          tracing: nil,
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
          turn_detection: nil,
          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
          voice: nil
        )
        end

        sig do
          override.returns(
            {
              id: String,
              expires_at: Integer,
              include:
                T.nilable(
                  T::Array[OpenAI::Realtime::RealtimeSession::Include::OrSymbol]
                ),
              input_audio_format:
                OpenAI::Realtime::RealtimeSession::InputAudioFormat::OrSymbol,
              input_audio_noise_reduction:
                OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction,
              input_audio_transcription:
                T.nilable(
                  OpenAI::Realtime::RealtimeSession::InputAudioTranscription
                ),
              instructions: String,
              max_response_output_tokens: T.any(Integer, Symbol),
              modalities:
                T::Array[OpenAI::Realtime::RealtimeSession::Modality::OrSymbol],
              model: OpenAI::Realtime::RealtimeSession::Model::OrSymbol,
              object: OpenAI::Realtime::RealtimeSession::Object::OrSymbol,
              output_audio_format:
                OpenAI::Realtime::RealtimeSession::OutputAudioFormat::OrSymbol,
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt),
              speed: Float,
              temperature: Float,
              tool_choice: String,
              tools: T::Array[OpenAI::Realtime::RealtimeSession::Tool],
              tracing:
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Realtime::RealtimeSession::Tracing::TracingConfiguration
                  )
                ),
              turn_detection:
                T.nilable(OpenAI::Realtime::RealtimeSession::TurnDetection),
              voice:
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeSession::Voice::OrSymbol
                )
            }
          )
        end
        def to_hash
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeSession::Include)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
            T.let(
              :"item.input_audio_transcription.logprobs",
              OpenAI::Realtime::RealtimeSession::Include::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::RealtimeSession::Include::TaggedSymbol]
            )
          end
          def self.values
          end
        end

        # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
        # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
        # (mono), and little-endian byte order.
        module InputAudioFormat
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeSession::InputAudioFormat)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          PCM16 =
            T.let(
              :pcm16,
              OpenAI::Realtime::RealtimeSession::InputAudioFormat::TaggedSymbol
            )
          G711_ULAW =
            T.let(
              :g711_ulaw,
              OpenAI::Realtime::RealtimeSession::InputAudioFormat::TaggedSymbol
            )
          G711_ALAW =
            T.let(
              :g711_alaw,
              OpenAI::Realtime::RealtimeSession::InputAudioFormat::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSession::InputAudioFormat::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class InputAudioNoiseReduction < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction,
                OpenAI::Internal::AnyHash
              )
            end

          # Type of noise reduction. `near_field` is for close-talking microphones such as
          # headphones, `far_field` is for far-field microphones such as laptop or
          # conference room microphones.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type::OrSymbol
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
                OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type::OrSymbol
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
                  OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type::OrSymbol
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
                  OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NEAR_FIELD =
              T.let(
                :near_field,
                OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type::TaggedSymbol
              )
            FAR_FIELD =
              T.let(
                :far_field,
                OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class InputAudioTranscription < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSession::InputAudioTranscription,
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

          # The model to use for transcription, current options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1`.
          sig { returns(T.nilable(String)) }
          attr_reader :model

          sig { params(model: String).void }
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
            params(language: String, model: String, prompt: String).returns(
              T.attached_class
            )
          end
          def self.new(
            # The language of the input audio. Supplying the input language in
            # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
            # format will improve accuracy and latency.
            language: nil,
            # The model to use for transcription, current options are `gpt-4o-transcribe`,
            # `gpt-4o-mini-transcribe`, and `whisper-1`.
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
              { language: String, model: String, prompt: String }
            )
          end
          def to_hash
          end
        end

        # Maximum number of output tokens for a single assistant response, inclusive of
        # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        module MaxResponseOutputTokens
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Integer, Symbol) }

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSession::MaxResponseOutputTokens::Variants
              ]
            )
          end
          def self.variants
          end
        end

        module Modality
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeSession::Modality)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Realtime::RealtimeSession::Modality::TaggedSymbol
            )
          AUDIO =
            T.let(
              :audio,
              OpenAI::Realtime::RealtimeSession::Modality::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSession::Modality::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The Realtime model used for this session.
        module Model
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeSession::Model)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_REALTIME =
            T.let(
              :"gpt-realtime",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )
          GPT_REALTIME_2025_08_28 =
            T.let(
              :"gpt-realtime-2025-08-28",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW =
            T.let(
              :"gpt-4o-realtime-preview",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2024_10_01 =
            T.let(
              :"gpt-4o-realtime-preview-2024-10-01",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-realtime-preview-2024-12-17",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2025_06_03 =
            T.let(
              :"gpt-4o-realtime-preview-2025-06-03",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )
          GPT_4O_MINI_REALTIME_PREVIEW =
            T.let(
              :"gpt-4o-mini-realtime-preview",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )
          GPT_4O_MINI_REALTIME_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-mini-realtime-preview-2024-12-17",
              OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::RealtimeSession::Model::TaggedSymbol]
            )
          end
          def self.values
          end
        end

        # The object type. Always `realtime.session`.
        module Object
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeSession::Object)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          REALTIME_SESSION =
            T.let(
              :"realtime.session",
              OpenAI::Realtime::RealtimeSession::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::RealtimeSession::Object::TaggedSymbol]
            )
          end
          def self.values
          end
        end

        # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        # For `pcm16`, output audio is sampled at a rate of 24kHz.
        module OutputAudioFormat
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeSession::OutputAudioFormat
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          PCM16 =
            T.let(
              :pcm16,
              OpenAI::Realtime::RealtimeSession::OutputAudioFormat::TaggedSymbol
            )
          G711_ULAW =
            T.let(
              :g711_ulaw,
              OpenAI::Realtime::RealtimeSession::OutputAudioFormat::TaggedSymbol
            )
          G711_ALAW =
            T.let(
              :g711_alaw,
              OpenAI::Realtime::RealtimeSession::OutputAudioFormat::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSession::OutputAudioFormat::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class Tool < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSession::Tool,
                OpenAI::Internal::AnyHash
              )
            end

          # The description of the function, including guidance on when and how to call it,
          # and guidance about what to tell the user when calling (if anything).
          sig { returns(T.nilable(String)) }
          attr_reader :description

          sig { params(description: String).void }
          attr_writer :description

          # The name of the function.
          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Parameters of the function in JSON Schema.
          sig { returns(T.nilable(T.anything)) }
          attr_reader :parameters

          sig { params(parameters: T.anything).void }
          attr_writer :parameters

          # The type of the tool, i.e. `function`.
          sig do
            returns(
              T.nilable(OpenAI::Realtime::RealtimeSession::Tool::Type::OrSymbol)
            )
          end
          attr_reader :type

          sig do
            params(
              type: OpenAI::Realtime::RealtimeSession::Tool::Type::OrSymbol
            ).void
          end
          attr_writer :type

          sig do
            params(
              description: String,
              name: String,
              parameters: T.anything,
              type: OpenAI::Realtime::RealtimeSession::Tool::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The description of the function, including guidance on when and how to call it,
            # and guidance about what to tell the user when calling (if anything).
            description: nil,
            # The name of the function.
            name: nil,
            # Parameters of the function in JSON Schema.
            parameters: nil,
            # The type of the tool, i.e. `function`.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                description: String,
                name: String,
                parameters: T.anything,
                type: OpenAI::Realtime::RealtimeSession::Tool::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The type of the tool, i.e. `function`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Realtime::RealtimeSession::Tool::Type)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FUNCTION =
              T.let(
                :function,
                OpenAI::Realtime::RealtimeSession::Tool::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeSession::Tool::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # Configuration options for tracing. Set to null to disable tracing. Once tracing
        # is enabled for a session, the configuration cannot be modified.
        #
        # `auto` will create a trace for the session with default values for the workflow
        # name, group id, and metadata.
        module Tracing
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                Symbol,
                OpenAI::Realtime::RealtimeSession::Tracing::TracingConfiguration
              )
            end

          class TracingConfiguration < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeSession::Tracing::TracingConfiguration,
                  OpenAI::Internal::AnyHash
                )
              end

            # The group id to attach to this trace to enable filtering and grouping in the
            # traces dashboard.
            sig { returns(T.nilable(String)) }
            attr_reader :group_id

            sig { params(group_id: String).void }
            attr_writer :group_id

            # The arbitrary metadata to attach to this trace to enable filtering in the traces
            # dashboard.
            sig { returns(T.nilable(T.anything)) }
            attr_reader :metadata

            sig { params(metadata: T.anything).void }
            attr_writer :metadata

            # The name of the workflow to attach to this trace. This is used to name the trace
            # in the traces dashboard.
            sig { returns(T.nilable(String)) }
            attr_reader :workflow_name

            sig { params(workflow_name: String).void }
            attr_writer :workflow_name

            # Granular configuration for tracing.
            sig do
              params(
                group_id: String,
                metadata: T.anything,
                workflow_name: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The group id to attach to this trace to enable filtering and grouping in the
              # traces dashboard.
              group_id: nil,
              # The arbitrary metadata to attach to this trace to enable filtering in the traces
              # dashboard.
              metadata: nil,
              # The name of the workflow to attach to this trace. This is used to name the trace
              # in the traces dashboard.
              workflow_name: nil
            )
            end

            sig do
              override.returns(
                {
                  group_id: String,
                  metadata: T.anything,
                  workflow_name: String
                }
              )
            end
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::RealtimeSession::Tracing::Variants]
            )
          end
          def self.variants
          end
        end

        class TurnDetection < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSession::TurnDetection,
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
                OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::OrSymbol
              )
            )
          end
          attr_reader :eagerness

          sig do
            params(
              eagerness:
                OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::OrSymbol
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
                OpenAI::Realtime::RealtimeSession::TurnDetection::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeSession::TurnDetection::Type::OrSymbol
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
                OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::OrSymbol,
              idle_timeout_ms: T.nilable(Integer),
              interrupt_response: T::Boolean,
              prefix_padding_ms: Integer,
              silence_duration_ms: Integer,
              threshold: Float,
              type:
                OpenAI::Realtime::RealtimeSession::TurnDetection::Type::OrSymbol
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
                  OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::OrSymbol,
                idle_timeout_ms: T.nilable(Integer),
                interrupt_response: T::Boolean,
                prefix_padding_ms: Integer,
                silence_duration_ms: Integer,
                threshold: Float,
                type:
                  OpenAI::Realtime::RealtimeSession::TurnDetection::Type::OrSymbol
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
                  OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW =
              T.let(
                :low,
                OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::TaggedSymbol
              )
            MEDIUM =
              T.let(
                :medium,
                OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::TaggedSymbol
              )
            AUTO =
              T.let(
                :auto,
                OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness::TaggedSymbol
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
                  OpenAI::Realtime::RealtimeSession::TurnDetection::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SERVER_VAD =
              T.let(
                :server_vad,
                OpenAI::Realtime::RealtimeSession::TurnDetection::Type::TaggedSymbol
              )
            SEMANTIC_VAD =
              T.let(
                :semantic_vad,
                OpenAI::Realtime::RealtimeSession::TurnDetection::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeSession::TurnDetection::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # The voice the model uses to respond. Voice cannot be changed during the session
        # once the model has responded with audio at least once. Current voice options are
        # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
        module Voice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::RealtimeSession::Voice::Variants]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::RealtimeSession::Voice)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ALLOY =
            T.let(
              :alloy,
              OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
            )
          ASH =
            T.let(:ash, OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol)
          BALLAD =
            T.let(
              :ballad,
              OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
            )
          CORAL =
            T.let(
              :coral,
              OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
            )
          ECHO =
            T.let(:echo, OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol)
          SAGE =
            T.let(:sage, OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol)
          SHIMMER =
            T.let(
              :shimmer,
              OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
            )
          VERSE =
            T.let(
              :verse,
              OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
            )
          MARIN =
            T.let(
              :marin,
              OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
            )
          CEDAR =
            T.let(
              :cedar,
              OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol
            )
        end
      end
    end
  end
end
