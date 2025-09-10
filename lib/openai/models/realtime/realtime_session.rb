# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeSession < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute expires_at
        #   Expiration timestamp for the session, in seconds since epoch.
        #
        #   @return [Integer, nil]
        optional :expires_at, Integer

        # @!attribute include
        #   Additional fields to include in server outputs.
        #
        #   - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        #     transcription.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeSession::Include>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeSession::Include] },
                 nil?: true

        # @!attribute input_audio_format
        #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
        #   `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
        #   (mono), and little-endian byte order.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSession::InputAudioFormat, nil]
        optional :input_audio_format, enum: -> { OpenAI::Realtime::RealtimeSession::InputAudioFormat }

        # @!attribute input_audio_noise_reduction
        #   Configuration for input audio noise reduction. This can be set to `null` to turn
        #   off. Noise reduction filters audio added to the input audio buffer before it is
        #   sent to VAD and the model. Filtering the audio can improve VAD and turn
        #   detection accuracy (reducing false positives) and model performance by improving
        #   perception of the input audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSession::InputAudioNoiseReduction, nil]
        optional :input_audio_noise_reduction, -> { OpenAI::Realtime::RealtimeSession::InputAudioNoiseReduction }

        # @!attribute input_audio_transcription
        #   Configuration for input audio transcription, defaults to off and can be set to
        #   `null` to turn off once on. Input audio transcription is not native to the
        #   model, since the model consumes audio directly. Transcription runs
        #   asynchronously through
        #   [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
        #   and should be treated as guidance of input audio content rather than precisely
        #   what the model heard. The client can optionally set the language and prompt for
        #   transcription, these offer additional guidance to the transcription service.
        #
        #   @return [OpenAI::Models::Realtime::AudioTranscription, nil]
        optional :input_audio_transcription, -> { OpenAI::Realtime::AudioTranscription }, nil?: true

        # @!attribute instructions
        #   The default system instructions (i.e. system message) prepended to model calls.
        #   This field allows the client to guide the model on desired responses. The model
        #   can be instructed on response content and format, (e.g. "be extremely succinct",
        #   "act friendly", "here are examples of good responses") and on audio behavior
        #   (e.g. "talk quickly", "inject emotion into your voice", "laugh frequently"). The
        #   instructions are not guaranteed to be followed by the model, but they provide
        #   guidance to the model on the desired behavior.
        #
        #   Note that the server sets default instructions which will be used if this field
        #   is not set and are visible in the `session.created` event at the start of the
        #   session.
        #
        #   @return [String, nil]
        optional :instructions, String

        # @!attribute max_response_output_tokens
        #   Maximum number of output tokens for a single assistant response, inclusive of
        #   tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        #   `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        #
        #   @return [Integer, Symbol, :inf, nil]
        optional :max_response_output_tokens,
                 union: -> { OpenAI::Realtime::RealtimeSession::MaxResponseOutputTokens }

        # @!attribute modalities
        #   The set of modalities the model can respond with. To disable audio, set this to
        #   ["text"].
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeSession::Modality>, nil]
        optional :modalities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeSession::Modality] }

        # @!attribute model
        #   The Realtime model used for this session.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSession::Model, nil]
        optional :model, enum: -> { OpenAI::Realtime::RealtimeSession::Model }

        # @!attribute object
        #   The object type. Always `realtime.session`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSession::Object, nil]
        optional :object, enum: -> { OpenAI::Realtime::RealtimeSession::Object }

        # @!attribute output_audio_format
        #   The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        #   For `pcm16`, output audio is sampled at a rate of 24kHz.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSession::OutputAudioFormat, nil]
        optional :output_audio_format, enum: -> { OpenAI::Realtime::RealtimeSession::OutputAudioFormat }

        # @!attribute prompt
        #   Reference to a prompt template and its variables.
        #   [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        #
        #   @return [OpenAI::Models::Responses::ResponsePrompt, nil]
        optional :prompt, -> { OpenAI::Responses::ResponsePrompt }, nil?: true

        # @!attribute speed
        #   The speed of the model's spoken response. 1.0 is the default speed. 0.25 is the
        #   minimum speed. 1.5 is the maximum speed. This value can only be changed in
        #   between model turns, not while a response is in progress.
        #
        #   @return [Float, nil]
        optional :speed, Float

        # @!attribute temperature
        #   Sampling temperature for the model, limited to [0.6, 1.2]. For audio models a
        #   temperature of 0.8 is highly recommended for best performance.
        #
        #   @return [Float, nil]
        optional :temperature, Float

        # @!attribute tool_choice
        #   How the model chooses tools. Options are `auto`, `none`, `required`, or specify
        #   a function.
        #
        #   @return [String, nil]
        optional :tool_choice, String

        # @!attribute tools
        #   Tools (functions) available to the model.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeFunctionTool>, nil]
        optional :tools, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::RealtimeFunctionTool] }

        # @!attribute tracing
        #   Configuration options for tracing. Set to null to disable tracing. Once tracing
        #   is enabled for a session, the configuration cannot be modified.
        #
        #   `auto` will create a trace for the session with default values for the workflow
        #   name, group id, and metadata.
        #
        #   @return [Symbol, :auto, OpenAI::Models::Realtime::RealtimeSession::Tracing::TracingConfiguration, nil]
        optional :tracing, union: -> { OpenAI::Realtime::RealtimeSession::Tracing }, nil?: true

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
        #   @return [OpenAI::Models::Realtime::RealtimeSession::TurnDetection, nil]
        optional :turn_detection, -> { OpenAI::Realtime::RealtimeSession::TurnDetection }, nil?: true

        # @!attribute voice
        #   The voice the model uses to respond. Voice cannot be changed during the session
        #   once the model has responded with audio at least once. Current voice options are
        #   `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
        #
        #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeSession::Voice, nil]
        optional :voice, union: -> { OpenAI::Realtime::RealtimeSession::Voice }

        # @!method initialize(id: nil, expires_at: nil, include: nil, input_audio_format: nil, input_audio_noise_reduction: nil, input_audio_transcription: nil, instructions: nil, max_response_output_tokens: nil, modalities: nil, model: nil, object: nil, output_audio_format: nil, prompt: nil, speed: nil, temperature: nil, tool_choice: nil, tools: nil, tracing: nil, turn_detection: nil, voice: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeSession} for more details.
        #
        #   Realtime session object.
        #
        #   @param id [String] Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @param expires_at [Integer] Expiration timestamp for the session, in seconds since epoch.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeSession::Include>, nil] Additional fields to include in server outputs.
        #
        #   @param input_audio_format [Symbol, OpenAI::Models::Realtime::RealtimeSession::InputAudioFormat] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        #
        #   @param input_audio_noise_reduction [OpenAI::Models::Realtime::RealtimeSession::InputAudioNoiseReduction] Configuration for input audio noise reduction. This can be set to `null` to turn
        #
        #   @param input_audio_transcription [OpenAI::Models::Realtime::AudioTranscription, nil] Configuration for input audio transcription, defaults to off and can be set to `
        #
        #   @param instructions [String] The default system instructions (i.e. system message) prepended to model
        #
        #   @param max_response_output_tokens [Integer, Symbol, :inf] Maximum number of output tokens for a single assistant response,
        #
        #   @param modalities [Array<Symbol, OpenAI::Models::Realtime::RealtimeSession::Modality>] The set of modalities the model can respond with. To disable audio,
        #
        #   @param model [Symbol, OpenAI::Models::Realtime::RealtimeSession::Model] The Realtime model used for this session.
        #
        #   @param object [Symbol, OpenAI::Models::Realtime::RealtimeSession::Object] The object type. Always `realtime.session`.
        #
        #   @param output_audio_format [Symbol, OpenAI::Models::Realtime::RealtimeSession::OutputAudioFormat] The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        #
        #   @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        #   @param speed [Float] The speed of the model's spoken response. 1.0 is the default speed. 0.25 is
        #
        #   @param temperature [Float] Sampling temperature for the model, limited to [0.6, 1.2]. For audio models a te
        #
        #   @param tool_choice [String] How the model chooses tools. Options are `auto`, `none`, `required`, or
        #
        #   @param tools [Array<OpenAI::Models::Realtime::RealtimeFunctionTool>] Tools (functions) available to the model.
        #
        #   @param tracing [Symbol, :auto, OpenAI::Models::Realtime::RealtimeSession::Tracing::TracingConfiguration, nil] Configuration options for tracing. Set to null to disable tracing. Once
        #
        #   @param turn_detection [OpenAI::Models::Realtime::RealtimeSession::TurnDetection, nil] Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
        #
        #   @param voice [String, Symbol, OpenAI::Models::Realtime::RealtimeSession::Voice] The voice the model uses to respond. Voice cannot be changed during the

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
        # @see OpenAI::Models::Realtime::RealtimeSession#input_audio_format
        module InputAudioFormat
          extend OpenAI::Internal::Type::Enum

          PCM16 = :pcm16
          G711_ULAW = :g711_ulaw
          G711_ALAW = :g711_alaw

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Realtime::RealtimeSession#input_audio_noise_reduction
        class InputAudioNoiseReduction < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   Type of noise reduction. `near_field` is for close-talking microphones such as
          #   headphones, `far_field` is for far-field microphones such as laptop or
          #   conference room microphones.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::NoiseReductionType, nil]
          optional :type, enum: -> { OpenAI::Realtime::NoiseReductionType }

          # @!method initialize(type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeSession::InputAudioNoiseReduction} for more
          #   details.
          #
          #   Configuration for input audio noise reduction. This can be set to `null` to turn
          #   off. Noise reduction filters audio added to the input audio buffer before it is
          #   sent to VAD and the model. Filtering the audio can improve VAD and turn
          #   detection accuracy (reducing false positives) and model performance by improving
          #   perception of the input audio.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::NoiseReductionType] Type of noise reduction. `near_field` is for close-talking microphones such as h
        end

        # Maximum number of output tokens for a single assistant response, inclusive of
        # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        #
        # @see OpenAI::Models::Realtime::RealtimeSession#max_response_output_tokens
        module MaxResponseOutputTokens
          extend OpenAI::Internal::Type::Union

          variant Integer

          variant const: :inf

          # @!method self.variants
          #   @return [Array(Integer, Symbol, :inf)]
        end

        module Modality
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          AUDIO = :audio

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The Realtime model used for this session.
        #
        # @see OpenAI::Models::Realtime::RealtimeSession#model
        module Model
          extend OpenAI::Internal::Type::Enum

          GPT_REALTIME = :"gpt-realtime"
          GPT_REALTIME_2025_08_28 = :"gpt-realtime-2025-08-28"
          GPT_4O_REALTIME_PREVIEW = :"gpt-4o-realtime-preview"
          GPT_4O_REALTIME_PREVIEW_2024_10_01 = :"gpt-4o-realtime-preview-2024-10-01"
          GPT_4O_REALTIME_PREVIEW_2024_12_17 = :"gpt-4o-realtime-preview-2024-12-17"
          GPT_4O_REALTIME_PREVIEW_2025_06_03 = :"gpt-4o-realtime-preview-2025-06-03"
          GPT_4O_MINI_REALTIME_PREVIEW = :"gpt-4o-mini-realtime-preview"
          GPT_4O_MINI_REALTIME_PREVIEW_2024_12_17 = :"gpt-4o-mini-realtime-preview-2024-12-17"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The object type. Always `realtime.session`.
        #
        # @see OpenAI::Models::Realtime::RealtimeSession#object
        module Object
          extend OpenAI::Internal::Type::Enum

          REALTIME_SESSION = :"realtime.session"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        # For `pcm16`, output audio is sampled at a rate of 24kHz.
        #
        # @see OpenAI::Models::Realtime::RealtimeSession#output_audio_format
        module OutputAudioFormat
          extend OpenAI::Internal::Type::Enum

          PCM16 = :pcm16
          G711_ULAW = :g711_ulaw
          G711_ALAW = :g711_alaw

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # Configuration options for tracing. Set to null to disable tracing. Once tracing
        # is enabled for a session, the configuration cannot be modified.
        #
        # `auto` will create a trace for the session with default values for the workflow
        # name, group id, and metadata.
        #
        # @see OpenAI::Models::Realtime::RealtimeSession#tracing
        module Tracing
          extend OpenAI::Internal::Type::Union

          # Default tracing mode for the session.
          variant const: :auto

          # Granular configuration for tracing.
          variant -> { OpenAI::Realtime::RealtimeSession::Tracing::TracingConfiguration }

          class TracingConfiguration < OpenAI::Internal::Type::BaseModel
            # @!attribute group_id
            #   The group id to attach to this trace to enable filtering and grouping in the
            #   traces dashboard.
            #
            #   @return [String, nil]
            optional :group_id, String

            # @!attribute metadata
            #   The arbitrary metadata to attach to this trace to enable filtering in the traces
            #   dashboard.
            #
            #   @return [Object, nil]
            optional :metadata, OpenAI::Internal::Type::Unknown

            # @!attribute workflow_name
            #   The name of the workflow to attach to this trace. This is used to name the trace
            #   in the traces dashboard.
            #
            #   @return [String, nil]
            optional :workflow_name, String

            # @!method initialize(group_id: nil, metadata: nil, workflow_name: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeSession::Tracing::TracingConfiguration} for
            #   more details.
            #
            #   Granular configuration for tracing.
            #
            #   @param group_id [String] The group id to attach to this trace to enable filtering and
            #
            #   @param metadata [Object] The arbitrary metadata to attach to this trace to enable
            #
            #   @param workflow_name [String] The name of the workflow to attach to this trace. This is used to
          end

          # @!method self.variants
          #   @return [Array(Symbol, :auto, OpenAI::Models::Realtime::RealtimeSession::Tracing::TracingConfiguration)]
        end

        # @see OpenAI::Models::Realtime::RealtimeSession#turn_detection
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
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSession::TurnDetection::Eagerness, nil]
          optional :eagerness, enum: -> { OpenAI::Realtime::RealtimeSession::TurnDetection::Eagerness }

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
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSession::TurnDetection::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeSession::TurnDetection::Type }

          # @!method initialize(create_response: nil, eagerness: nil, idle_timeout_ms: nil, interrupt_response: nil, prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeSession::TurnDetection} for more details.
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
          #   @param eagerness [Symbol, OpenAI::Models::Realtime::RealtimeSession::TurnDetection::Eagerness] Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
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
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeSession::TurnDetection::Type] Type of turn detection.

          # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
          # will wait longer for the user to continue speaking, `high` will respond more
          # quickly. `auto` is the default and is equivalent to `medium`.
          #
          # @see OpenAI::Models::Realtime::RealtimeSession::TurnDetection#eagerness
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
          # @see OpenAI::Models::Realtime::RealtimeSession::TurnDetection#type
          module Type
            extend OpenAI::Internal::Type::Enum

            SERVER_VAD = :server_vad
            SEMANTIC_VAD = :semantic_vad

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # The voice the model uses to respond. Voice cannot be changed during the session
        # once the model has responded with audio at least once. Current voice options are
        # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
        #
        # @see OpenAI::Models::Realtime::RealtimeSession#voice
        module Voice
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::ALLOY }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::ASH }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::BALLAD }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::CORAL }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::ECHO }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::SAGE }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::SHIMMER }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::VERSE }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::MARIN }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSession::Voice::CEDAR }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Realtime::RealtimeSession::Voice::TaggedSymbol) }
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
