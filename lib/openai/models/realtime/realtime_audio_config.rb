# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeAudioConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #
        #   @return [OpenAI::Models::Realtime::RealtimeAudioConfig::Input, nil]
        optional :input, -> { OpenAI::Realtime::RealtimeAudioConfig::Input }

        # @!attribute output
        #
        #   @return [OpenAI::Models::Realtime::RealtimeAudioConfig::Output, nil]
        optional :output, -> { OpenAI::Realtime::RealtimeAudioConfig::Output }

        # @!method initialize(input: nil, output: nil)
        #   Configuration for input and output audio.
        #
        #   @param input [OpenAI::Models::Realtime::RealtimeAudioConfig::Input]
        #   @param output [OpenAI::Models::Realtime::RealtimeAudioConfig::Output]

        # @see OpenAI::Models::Realtime::RealtimeAudioConfig#input
        class Input < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          #   `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          #   (mono), and little-endian byte order.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Format, nil]
          optional :format_,
                   enum: -> {
                     OpenAI::Realtime::RealtimeAudioConfig::Input::Format
                   },
                   api_name: :format

          # @!attribute noise_reduction
          #   Configuration for input audio noise reduction. This can be set to `null` to turn
          #   off. Noise reduction filters audio added to the input audio buffer before it is
          #   sent to VAD and the model. Filtering the audio can improve VAD and turn
          #   detection accuracy (reducing false positives) and model performance by improving
          #   perception of the input audio.
          #
          #   @return [OpenAI::Models::Realtime::RealtimeAudioConfig::Input::NoiseReduction, nil]
          optional :noise_reduction, -> { OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction }

          # @!attribute transcription
          #   Configuration for input audio transcription, defaults to off and can be set to
          #   `null` to turn off once on. Input audio transcription is not native to the
          #   model, since the model consumes audio directly. Transcription runs
          #   asynchronously through
          #   [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
          #   and should be treated as guidance of input audio content rather than precisely
          #   what the model heard. The client can optionally set the language and prompt for
          #   transcription, these offer additional guidance to the transcription service.
          #
          #   @return [OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Transcription, nil]
          optional :transcription, -> { OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription }

          # @!attribute turn_detection
          #   Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
          #   set to `null` to turn off, in which case the client must manually trigger model
          #   response. Server VAD means that the model will detect the start and end of
          #   speech based on audio volume and respond at the end of user speech. Semantic VAD
          #   is more advanced and uses a turn detection model (in conjunction with VAD) to
          #   semantically estimate whether the user has finished speaking, then dynamically
          #   sets a timeout based on this probability. For example, if user audio trails off
          #   with "uhhm", the model will score a low probability of turn end and wait longer
          #   for the user to continue speaking. This can be useful for more natural
          #   conversations, but may have a higher latency.
          #
          #   @return [OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection, nil]
          optional :turn_detection, -> { OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection }

          # @!method initialize(format_: nil, noise_reduction: nil, transcription: nil, turn_detection: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeAudioConfig::Input} for more details.
          #
          #   @param format_ [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Format] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          #   @param noise_reduction [OpenAI::Models::Realtime::RealtimeAudioConfig::Input::NoiseReduction] Configuration for input audio noise reduction. This can be set to `null` to turn
          #
          #   @param transcription [OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Transcription] Configuration for input audio transcription, defaults to off and can be set to `
          #
          #   @param turn_detection [OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection] Configuration for turn detection, ether Server VAD or Semantic VAD. This can be

          # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          # (mono), and little-endian byte order.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input#format_
          module Format
            extend OpenAI::Internal::Type::Enum

            PCM16 = :pcm16
            G711_ULAW = :g711_ulaw
            G711_ALAW = :g711_alaw

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input#noise_reduction
          class NoiseReduction < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Type of noise reduction. `near_field` is for close-talking microphones such as
            #   headphones, `far_field` is for far-field microphones such as laptop or
            #   conference room microphones.
            #
            #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type, nil]
            optional :type, enum: -> { OpenAI::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type }

            # @!method initialize(type: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeAudioConfig::Input::NoiseReduction} for more
            #   details.
            #
            #   Configuration for input audio noise reduction. This can be set to `null` to turn
            #   off. Noise reduction filters audio added to the input audio buffer before it is
            #   sent to VAD and the model. Filtering the audio can improve VAD and turn
            #   detection accuracy (reducing false positives) and model performance by improving
            #   perception of the input audio.
            #
            #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::NoiseReduction::Type] Type of noise reduction. `near_field` is for close-talking microphones such as h

            # Type of noise reduction. `near_field` is for close-talking microphones such as
            # headphones, `far_field` is for far-field microphones such as laptop or
            # conference room microphones.
            #
            # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input::NoiseReduction#type
            module Type
              extend OpenAI::Internal::Type::Enum

              NEAR_FIELD = :near_field
              FAR_FIELD = :far_field

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input#transcription
          class Transcription < OpenAI::Internal::Type::BaseModel
            # @!attribute language
            #   The language of the input audio. Supplying the input language in
            #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
            #   format will improve accuracy and latency.
            #
            #   @return [String, nil]
            optional :language, String

            # @!attribute model
            #   The model to use for transcription. Current options are `whisper-1`,
            #   `gpt-4o-transcribe-latest`, `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and
            #   `gpt-4o-transcribe-diarize`.
            #
            #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Transcription::Model, nil]
            optional :model, enum: -> { OpenAI::Realtime::RealtimeAudioConfig::Input::Transcription::Model }

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
            #   {OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Transcription} for more
            #   details.
            #
            #   Configuration for input audio transcription, defaults to off and can be set to
            #   `null` to turn off once on. Input audio transcription is not native to the
            #   model, since the model consumes audio directly. Transcription runs
            #   asynchronously through
            #   [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
            #   and should be treated as guidance of input audio content rather than precisely
            #   what the model heard. The client can optionally set the language and prompt for
            #   transcription, these offer additional guidance to the transcription service.
            #
            #   @param language [String] The language of the input audio. Supplying the input language in
            #
            #   @param model [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Transcription::Model] The model to use for transcription. Current options are
            #
            #   @param prompt [String] An optional text to guide the model's style or continue a previous audio

            # The model to use for transcription. Current options are `whisper-1`,
            # `gpt-4o-transcribe-latest`, `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and
            # `gpt-4o-transcribe-diarize`.
            #
            # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input::Transcription#model
            module Model
              extend OpenAI::Internal::Type::Enum

              WHISPER_1 = :"whisper-1"
              GPT_4O_TRANSCRIBE_LATEST = :"gpt-4o-transcribe-latest"
              GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
              GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
              GPT_4O_TRANSCRIBE_DIARIZE = :"gpt-4o-transcribe-diarize"

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input#turn_detection
          class TurnDetection < OpenAI::Internal::Type::BaseModel
            # @!attribute create_response
            #   Whether or not to automatically generate a response when a VAD stop event
            #   occurs.
            #
            #   @return [Boolean, nil]
            optional :create_response, OpenAI::Internal::Type::Boolean

            # @!attribute eagerness
            #   Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
            #   will wait longer for the user to continue speaking, `high` will respond more
            #   quickly. `auto` is the default and is equivalent to `medium`.
            #
            #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness, nil]
            optional :eagerness, enum: -> { OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness }

            # @!attribute idle_timeout_ms
            #   Optional idle timeout after which turn detection will auto-timeout when no
            #   additional audio is received.
            #
            #   @return [Integer, nil]
            optional :idle_timeout_ms, Integer, nil?: true

            # @!attribute interrupt_response
            #   Whether or not to automatically interrupt any ongoing response with output to
            #   the default conversation (i.e. `conversation` of `auto`) when a VAD start event
            #   occurs.
            #
            #   @return [Boolean, nil]
            optional :interrupt_response, OpenAI::Internal::Type::Boolean

            # @!attribute prefix_padding_ms
            #   Used only for `server_vad` mode. Amount of audio to include before the VAD
            #   detected speech (in milliseconds). Defaults to 300ms.
            #
            #   @return [Integer, nil]
            optional :prefix_padding_ms, Integer

            # @!attribute silence_duration_ms
            #   Used only for `server_vad` mode. Duration of silence to detect speech stop (in
            #   milliseconds). Defaults to 500ms. With shorter values the model will respond
            #   more quickly, but may jump in on short pauses from the user.
            #
            #   @return [Integer, nil]
            optional :silence_duration_ms, Integer

            # @!attribute threshold
            #   Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
            #   defaults to 0.5. A higher threshold will require louder audio to activate the
            #   model, and thus might perform better in noisy environments.
            #
            #   @return [Float, nil]
            optional :threshold, Float

            # @!attribute type
            #   Type of turn detection.
            #
            #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type, nil]
            optional :type, enum: -> { OpenAI::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type }

            # @!method initialize(create_response: nil, eagerness: nil, idle_timeout_ms: nil, interrupt_response: nil, prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection} for more
            #   details.
            #
            #   Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
            #   set to `null` to turn off, in which case the client must manually trigger model
            #   response. Server VAD means that the model will detect the start and end of
            #   speech based on audio volume and respond at the end of user speech. Semantic VAD
            #   is more advanced and uses a turn detection model (in conjunction with VAD) to
            #   semantically estimate whether the user has finished speaking, then dynamically
            #   sets a timeout based on this probability. For example, if user audio trails off
            #   with "uhhm", the model will score a low probability of turn end and wait longer
            #   for the user to continue speaking. This can be useful for more natural
            #   conversations, but may have a higher latency.
            #
            #   @param create_response [Boolean] Whether or not to automatically generate a response when a VAD stop event occurs
            #
            #   @param eagerness [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection::Eagerness] Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
            #
            #   @param idle_timeout_ms [Integer, nil] Optional idle timeout after which turn detection will auto-timeout when
            #
            #   @param interrupt_response [Boolean] Whether or not to automatically interrupt any ongoing response with output to th
            #
            #   @param prefix_padding_ms [Integer] Used only for `server_vad` mode. Amount of audio to include before the VAD detec
            #
            #   @param silence_duration_ms [Integer] Used only for `server_vad` mode. Duration of silence to detect speech stop (in m
            #
            #   @param threshold [Float] Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
            #
            #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection::Type] Type of turn detection.

            # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
            # will wait longer for the user to continue speaking, `high` will respond more
            # quickly. `auto` is the default and is equivalent to `medium`.
            #
            # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection#eagerness
            module Eagerness
              extend OpenAI::Internal::Type::Enum

              LOW = :low
              MEDIUM = :medium
              HIGH = :high
              AUTO = :auto

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # Type of turn detection.
            #
            # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Input::TurnDetection#type
            module Type
              extend OpenAI::Internal::Type::Enum

              SERVER_VAD = :server_vad
              SEMANTIC_VAD = :semantic_vad

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end

        # @see OpenAI::Models::Realtime::RealtimeAudioConfig#output
        class Output < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #   For `pcm16`, output audio is sampled at a rate of 24kHz.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Format, nil]
          optional :format_,
                   enum: -> {
                     OpenAI::Realtime::RealtimeAudioConfig::Output::Format
                   },
                   api_name: :format

          # @!attribute speed
          #   The speed of the model's spoken response. 1.0 is the default speed. 0.25 is the
          #   minimum speed. 1.5 is the maximum speed. This value can only be changed in
          #   between model turns, not while a response is in progress.
          #
          #   @return [Float, nil]
          optional :speed, Float

          # @!attribute voice
          #   The voice the model uses to respond. Voice cannot be changed during the session
          #   once the model has responded with audio at least once. Current voice options are
          #   `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
          #   and `cedar`.
          #
          #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice, nil]
          optional :voice, union: -> { OpenAI::Realtime::RealtimeAudioConfig::Output::Voice }

          # @!method initialize(format_: nil, speed: nil, voice: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeAudioConfig::Output} for more details.
          #
          #   @param format_ [Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Format] The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          #   @param speed [Float] The speed of the model's spoken response. 1.0 is the default speed. 0.25 is
          #
          #   @param voice [String, Symbol, OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice] The voice the model uses to respond. Voice cannot be changed during the

          # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          # For `pcm16`, output audio is sampled at a rate of 24kHz.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Output#format_
          module Format
            extend OpenAI::Internal::Type::Enum

            PCM16 = :pcm16
            G711_ULAW = :g711_ulaw
            G711_ALAW = :g711_alaw

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
          # and `cedar`.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioConfig::Output#voice
          module Voice
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::ALLOY }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::ASH }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::BALLAD }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::CORAL }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::ECHO }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::SAGE }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::SHIMMER }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::VERSE }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::MARIN }

            variant const: -> { OpenAI::Models::Realtime::RealtimeAudioConfig::Output::Voice::CEDAR }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Realtime::RealtimeAudioConfig::Output::Voice::TaggedSymbol) }
            end

            # @!group

            ALLOY = :alloy
            ASH = :ash
            BALLAD = :ballad
            CORAL = :coral
            ECHO = :echo
            SAGE = :sage
            SHIMMER = :shimmer
            VERSE = :verse
            MARIN = :marin
            CEDAR = :cedar

            # @!endgroup
          end
        end
      end
    end
  end
end
