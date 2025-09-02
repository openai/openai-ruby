# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionCreateRequest < OpenAI::Internal::Type::BaseModel
        # @!attribute model
        #   ID of the model to use. The options are `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        #   Whisper V2 model).
        #
        #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Model]
        required :model, union: -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model }

        # @!attribute type
        #   The type of session to create. Always `transcription` for transcription
        #   sessions.
        #
        #   @return [Symbol, :transcription]
        required :type, const: :transcription

        # @!attribute include
        #   The set of items to include in the transcription. Current available items are:
        #
        #   - `item.input_audio_transcription.logprobs`
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Include>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include] }

        # @!attribute input_audio_format
        #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
        #   `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
        #   (mono), and little-endian byte order.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat, nil]
        optional :input_audio_format,
                 enum: -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat }

        # @!attribute input_audio_noise_reduction
        #   Configuration for input audio noise reduction. This can be set to `null` to turn
        #   off. Noise reduction filters audio added to the input audio buffer before it is
        #   sent to VAD and the model. Filtering the audio can improve VAD and turn
        #   detection accuracy (reducing false positives) and model performance by improving
        #   perception of the input audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction, nil]
        optional :input_audio_noise_reduction,
                 -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction }

        # @!attribute input_audio_transcription
        #   Configuration for input audio transcription. The client can optionally set the
        #   language and prompt for transcription, these offer additional guidance to the
        #   transcription service.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription, nil]
        optional :input_audio_transcription,
                 -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription }

        # @!attribute turn_detection
        #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
        #   means that the model will detect the start and end of speech based on audio
        #   volume and respond at the end of user speech.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection, nil]
        optional :turn_detection,
                 -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection }

        # @!method initialize(model:, include: nil, input_audio_format: nil, input_audio_noise_reduction: nil, input_audio_transcription: nil, turn_detection: nil, type: :transcription)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest} for more
        #   details.
        #
        #   Realtime transcription session object configuration.
        #
        #   @param model [String, Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Model] ID of the model to use. The options are `gpt-4o-transcribe`, `gpt-4o-mini-transc
        #
        #   @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Include>] The set of items to include in the transcription. Current available items are:
        #
        #   @param input_audio_format [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        #
        #   @param input_audio_noise_reduction [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction] Configuration for input audio noise reduction. This can be set to `null` to turn
        #
        #   @param input_audio_transcription [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription] Configuration for input audio transcription. The client can optionally set the l
        #
        #   @param turn_detection [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection] Configuration for turn detection. Can be set to `null` to turn off. Server VAD m
        #
        #   @param type [Symbol, :transcription] The type of session to create. Always `transcription` for transcription sessions

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        # Whisper V2 model).
        #
        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest#model
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::WHISPER_1 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::GPT_4O_TRANSCRIBE }

          variant const: -> { OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::GPT_4O_MINI_TRANSCRIBE }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::TaggedSymbol) }
          end

          # @!group

          WHISPER_1 = :"whisper-1"
          GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
          GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"

          # @!endgroup
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS = :"item.input_audio_transcription.logprobs"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
        # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
        # (mono), and little-endian byte order.
        #
        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest#input_audio_format
        module InputAudioFormat
          extend OpenAI::Internal::Type::Enum

          PCM16 = :pcm16
          G711_ULAW = :g711_ulaw
          G711_ALAW = :g711_alaw

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest#input_audio_noise_reduction
        class InputAudioNoiseReduction < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   Type of noise reduction. `near_field` is for close-talking microphones such as
          #   headphones, `far_field` is for far-field microphones such as laptop or
          #   conference room microphones.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type, nil]
          optional :type,
                   enum: -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type }

          # @!method initialize(type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction}
          #   for more details.
          #
          #   Configuration for input audio noise reduction. This can be set to `null` to turn
          #   off. Noise reduction filters audio added to the input audio buffer before it is
          #   sent to VAD and the model. Filtering the audio can improve VAD and turn
          #   detection accuracy (reducing false positives) and model performance by improving
          #   perception of the input audio.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type] Type of noise reduction. `near_field` is for close-talking microphones such as h

          # Type of noise reduction. `near_field` is for close-talking microphones such as
          # headphones, `far_field` is for far-field microphones such as laptop or
          # conference room microphones.
          #
          # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction#type
          module Type
            extend OpenAI::Internal::Type::Enum

            NEAR_FIELD = :near_field
            FAR_FIELD = :far_field

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest#input_audio_transcription
        class InputAudioTranscription < OpenAI::Internal::Type::BaseModel
          # @!attribute language
          #   The language of the input audio. Supplying the input language in
          #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          #   format will improve accuracy and latency.
          #
          #   @return [String, nil]
          optional :language, String

          # @!attribute model
          #   The model to use for transcription, current options are `gpt-4o-transcribe`,
          #   `gpt-4o-mini-transcribe`, and `whisper-1`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model, nil]
          optional :model,
                   enum: -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model }

          # @!attribute prompt
          #   An optional text to guide the model's style or continue a previous audio
          #   segment. For `whisper-1`, the
          #   [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
          #   For `gpt-4o-transcribe` models, the prompt is a free text string, for example
          #   "expect words related to technology".
          #
          #   @return [String, nil]
          optional :prompt, String

          # @!method initialize(language: nil, model: nil, prompt: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription}
          #   for more details.
          #
          #   Configuration for input audio transcription. The client can optionally set the
          #   language and prompt for transcription, these offer additional guidance to the
          #   transcription service.
          #
          #   @param language [String] The language of the input audio. Supplying the input language in
          #
          #   @param model [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model] The model to use for transcription, current options are `gpt-4o-transcribe`, `gp
          #
          #   @param prompt [String] An optional text to guide the model's style or continue a previous audio

          # The model to use for transcription, current options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1`.
          #
          # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription#model
          module Model
            extend OpenAI::Internal::Type::Enum

            GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
            GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
            WHISPER_1 = :"whisper-1"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest#turn_detection
        class TurnDetection < OpenAI::Internal::Type::BaseModel
          # @!attribute prefix_padding_ms
          #   Amount of audio to include before the VAD detected speech (in milliseconds).
          #   Defaults to 300ms.
          #
          #   @return [Integer, nil]
          optional :prefix_padding_ms, Integer

          # @!attribute silence_duration_ms
          #   Duration of silence to detect speech stop (in milliseconds). Defaults to 500ms.
          #   With shorter values the model will respond more quickly, but may jump in on
          #   short pauses from the user.
          #
          #   @return [Integer, nil]
          optional :silence_duration_ms, Integer

          # @!attribute threshold
          #   Activation threshold for VAD (0.0 to 1.0), this defaults to 0.5. A higher
          #   threshold will require louder audio to activate the model, and thus might
          #   perform better in noisy environments.
          #
          #   @return [Float, nil]
          optional :threshold, Float

          # @!attribute type
          #   Type of turn detection. Only `server_vad` is currently supported for
          #   transcription sessions.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type, nil]
          optional :type,
                   enum: -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type }

          # @!method initialize(prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection}
          #   for more details.
          #
          #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          #   means that the model will detect the start and end of speech based on audio
          #   volume and respond at the end of user speech.
          #
          #   @param prefix_padding_ms [Integer] Amount of audio to include before the VAD detected speech (in
          #
          #   @param silence_duration_ms [Integer] Duration of silence to detect speech stop (in milliseconds). Defaults
          #
          #   @param threshold [Float] Activation threshold for VAD (0.0 to 1.0), this defaults to 0.5. A
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type] Type of turn detection. Only `server_vad` is currently supported for transcripti

          # Type of turn detection. Only `server_vad` is currently supported for
          # transcription sessions.
          #
          # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection#type
          module Type
            extend OpenAI::Internal::Type::Enum

            SERVER_VAD = :server_vad

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
