# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeSessionCreateResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute client_secret
        #   Ephemeral key returned by the API.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionClientSecret]
        required :client_secret, -> { OpenAI::Realtime::RealtimeSessionClientSecret }

        # @!attribute type
        #   The type of session to create. Always `realtime` for the Realtime API.
        #
        #   @return [Symbol, :realtime]
        required :type, const: :realtime

        # @!attribute audio
        #   Configuration for input and output audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio, nil]
        optional :audio, -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio }

        # @!attribute include
        #   Additional fields to include in server outputs.
        #
        #   `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        #   transcription.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Include>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeSessionCreateResponse::Include] }

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

        # @!attribute max_output_tokens
        #   Maximum number of output tokens for a single assistant response, inclusive of
        #   tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        #   `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        #
        #   @return [Integer, Symbol, :inf, nil]
        optional :max_output_tokens,
                 union: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::MaxOutputTokens }

        # @!attribute model
        #   The Realtime model used for this session.
        #
        #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model, nil]
        optional :model, union: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Model }

        # @!attribute output_modalities
        #   The set of modalities the model can respond with. It defaults to `["audio"]`,
        #   indicating that the model will respond with audio plus a transcript. `["text"]`
        #   can be used to make the model respond with text only. It is not possible to
        #   request both `text` and `audio` at the same time.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::OutputModality>, nil]
        optional :output_modalities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality] }

        # @!attribute prompt
        #   Reference to a prompt template and its variables.
        #   [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        #
        #   @return [OpenAI::Models::Responses::ResponsePrompt, nil]
        optional :prompt, -> { OpenAI::Responses::ResponsePrompt }, nil?: true

        # @!attribute tool_choice
        #   How the model chooses tools. Provide one of the string modes or force a specific
        #   function/MCP tool.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, nil]
        optional :tool_choice, union: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::ToolChoice }

        # @!attribute tools
        #   Tools available to the model.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool>, nil]
        optional :tools,
                 -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Realtime::RealtimeSessionCreateResponse::Tool] }

        # @!attribute tracing
        #   Realtime API can write session traces to the
        #   [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
        #   tracing is enabled for a session, the configuration cannot be modified.
        #
        #   `auto` will create a trace for the session with default values for the workflow
        #   name, group id, and metadata.
        #
        #   @return [Symbol, :auto, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration, nil]
        optional :tracing, union: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing }, nil?: true

        # @!attribute truncation
        #   When the number of tokens in a conversation exceeds the model's input token
        #   limit, the conversation be truncated, meaning messages (starting from the
        #   oldest) will not be included in the model's context. A 32k context model with
        #   4,096 max output tokens can only include 28,224 tokens in the context before
        #   truncation occurs. Clients can configure truncation behavior to truncate with a
        #   lower max token limit, which is an effective way to control token usage and
        #   cost. Truncation will reduce the number of cached tokens on the next turn
        #   (busting the cache), since messages are dropped from the beginning of the
        #   context. However, clients can also configure truncation to retain messages up to
        #   a fraction of the maximum context size, which will reduce the need for future
        #   truncations and thus improve the cache rate. Truncation can be disabled
        #   entirely, which means the server will never truncate but would instead return an
        #   error if the conversation exceeds the model's input token limit.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio, nil]
        optional :truncation, union: -> { OpenAI::Realtime::RealtimeTruncation }

        # @!method initialize(client_secret:, audio: nil, include: nil, instructions: nil, max_output_tokens: nil, model: nil, output_modalities: nil, prompt: nil, tool_choice: nil, tools: nil, tracing: nil, truncation: nil, type: :realtime)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse} for more details.
        #
        #   A new Realtime session configuration, with an ephemeral key. Default TTL for
        #   keys is one minute.
        #
        #   @param client_secret [OpenAI::Models::Realtime::RealtimeSessionClientSecret] Ephemeral key returned by the API.
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio] Configuration for input and output audio.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Include>] Additional fields to include in server outputs.
        #
        #   @param instructions [String] The default system instructions (i.e. system message) prepended to model calls.
        #
        #   @param max_output_tokens [Integer, Symbol, :inf] Maximum number of output tokens for a single assistant response,
        #
        #   @param model [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model] The Realtime model used for this session.
        #
        #   @param output_modalities [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::OutputModality>] The set of modalities the model can respond with. It defaults to `["audio"]`, in
        #
        #   @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp] How the model chooses tools. Provide one of the string modes or force a specific
        #
        #   @param tools [Array<OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool>] Tools available to the model.
        #
        #   @param tracing [Symbol, :auto, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration, nil] Realtime API can write session traces to the [Traces Dashboard](/logs?api=traces
        #
        #   @param truncation [Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio] When the number of tokens in a conversation exceeds the model's input token limi
        #
        #   @param type [Symbol, :realtime] The type of session to create. Always `realtime` for the Realtime API.

        # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse#audio
        class Audio < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #
          #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input, nil]
          optional :input, -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input }

          # @!attribute output
          #
          #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output, nil]
          optional :output, -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output }

          # @!method initialize(input: nil, output: nil)
          #   Configuration for input and output audio.
          #
          #   @param input [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input]
          #   @param output [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output]

          # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio#input
          class Input < OpenAI::Internal::Type::BaseModel
            # @!attribute format_
            #   The format of the input audio.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA, nil]
            optional :format_, union: -> { OpenAI::Realtime::RealtimeAudioFormats }, api_name: :format

            # @!attribute noise_reduction
            #   Configuration for input audio noise reduction. This can be set to `null` to turn
            #   off. Noise reduction filters audio added to the input audio buffer before it is
            #   sent to VAD and the model. Filtering the audio can improve VAD and turn
            #   detection accuracy (reducing false positives) and model performance by improving
            #   perception of the input audio.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction, nil]
            optional :noise_reduction,
                     -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction }

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
            #   @return [OpenAI::Models::Realtime::AudioTranscription, nil]
            optional :transcription, -> { OpenAI::Realtime::AudioTranscription }

            # @!attribute turn_detection
            #   Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
            #   set to `null` to turn off, in which case the client must manually trigger model
            #   response.
            #
            #   Server VAD means that the model will detect the start and end of speech based on
            #   audio volume and respond at the end of user speech.
            #
            #   Semantic VAD is more advanced and uses a turn detection model (in conjunction
            #   with VAD) to semantically estimate whether the user has finished speaking, then
            #   dynamically sets a timeout based on this probability. For example, if user audio
            #   trails off with "uhhm", the model will score a low probability of turn end and
            #   wait longer for the user to continue speaking. This can be useful for more
            #   natural conversations, but may have a higher latency.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad, nil]
            optional :turn_detection,
                     union: -> {
                       OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection
                     },
                     nil?: true

            # @!method initialize(format_: nil, noise_reduction: nil, transcription: nil, turn_detection: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input} for more
            #   details.
            #
            #   @param format_ [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA] The format of the input audio.
            #
            #   @param noise_reduction [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction] Configuration for input audio noise reduction. This can be set to `null` to turn
            #
            #   @param transcription [OpenAI::Models::Realtime::AudioTranscription] Configuration for input audio transcription, defaults to off and can be set to `
            #
            #   @param turn_detection [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad, nil] Configuration for turn detection, ether Server VAD or Semantic VAD. This can be

            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input#noise_reduction
            class NoiseReduction < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   Type of noise reduction. `near_field` is for close-talking microphones such as
              #   headphones, `far_field` is for far-field microphones such as laptop or
              #   conference room microphones.
              #
              #   @return [Symbol, OpenAI::Models::Realtime::NoiseReductionType, nil]
              optional :type, enum: -> { OpenAI::Realtime::NoiseReductionType }

              # @!method initialize(type: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction}
              #   for more details.
              #
              #   Configuration for input audio noise reduction. This can be set to `null` to turn
              #   off. Noise reduction filters audio added to the input audio buffer before it is
              #   sent to VAD and the model. Filtering the audio can improve VAD and turn
              #   detection accuracy (reducing false positives) and model performance by improving
              #   perception of the input audio.
              #
              #   @param type [Symbol, OpenAI::Models::Realtime::NoiseReductionType] Type of noise reduction. `near_field` is for close-talking microphones such as h
            end

            # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
            # set to `null` to turn off, in which case the client must manually trigger model
            # response.
            #
            # Server VAD means that the model will detect the start and end of speech based on
            # audio volume and respond at the end of user speech.
            #
            # Semantic VAD is more advanced and uses a turn detection model (in conjunction
            # with VAD) to semantically estimate whether the user has finished speaking, then
            # dynamically sets a timeout based on this probability. For example, if user audio
            # trails off with "uhhm", the model will score a low probability of turn end and
            # wait longer for the user to continue speaking. This can be useful for more
            # natural conversations, but may have a higher latency.
            #
            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input#turn_detection
            module TurnDetection
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # Server-side voice activity detection (VAD) which flips on when user speech is detected and off after a period of silence.
              variant :server_vad,
                      -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad }

              # Server-side semantic turn detection which uses a model to determine when the user has finished speaking.
              variant :semantic_vad,
                      -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad }

              class ServerVad < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   Type of turn detection, `server_vad` to turn on simple Server VAD.
                #
                #   @return [Symbol, :server_vad]
                required :type, const: :server_vad

                # @!attribute create_response
                #   Whether or not to automatically generate a response when a VAD stop event
                #   occurs.
                #
                #   @return [Boolean, nil]
                optional :create_response, OpenAI::Internal::Type::Boolean

                # @!attribute idle_timeout_ms
                #   Optional timeout after which a model response will be triggered automatically.
                #   This is useful for situations in which a long pause from the user is unexpected,
                #   such as a phone call. The model will effectively prompt the user to continue the
                #   conversation based on the current context.
                #
                #   The timeout value will be applied after the last model response's audio has
                #   finished playing, i.e. it's set to the `response.done` time plus audio playback
                #   duration.
                #
                #   An `input_audio_buffer.timeout_triggered` event (plus events associated with the
                #   Response) will be emitted when the timeout is reached. Idle timeout is currently
                #   only supported for `server_vad` mode.
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

                # @!method initialize(create_response: nil, idle_timeout_ms: nil, interrupt_response: nil, prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: :server_vad)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad}
                #   for more details.
                #
                #   Server-side voice activity detection (VAD) which flips on when user speech is
                #   detected and off after a period of silence.
                #
                #   @param create_response [Boolean] Whether or not to automatically generate a response when a VAD stop event occurs
                #
                #   @param idle_timeout_ms [Integer, nil] Optional timeout after which a model response will be triggered automatically. T
                #
                #   @param interrupt_response [Boolean] Whether or not to automatically interrupt any ongoing response with output to th
                #
                #   @param prefix_padding_ms [Integer] Used only for `server_vad` mode. Amount of audio to include before the VAD detec
                #
                #   @param silence_duration_ms [Integer] Used only for `server_vad` mode. Duration of silence to detect speech stop (in m
                #
                #   @param threshold [Float] Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
                #
                #   @param type [Symbol, :server_vad] Type of turn detection, `server_vad` to turn on simple Server VAD.
              end

              class SemanticVad < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   Type of turn detection, `semantic_vad` to turn on Semantic VAD.
                #
                #   @return [Symbol, :semantic_vad]
                required :type, const: :semantic_vad

                # @!attribute create_response
                #   Whether or not to automatically generate a response when a VAD stop event
                #   occurs.
                #
                #   @return [Boolean, nil]
                optional :create_response, OpenAI::Internal::Type::Boolean

                # @!attribute eagerness
                #   Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
                #   will wait longer for the user to continue speaking, `high` will respond more
                #   quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
                #   and `high` have max timeouts of 8s, 4s, and 2s respectively.
                #
                #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness, nil]
                optional :eagerness,
                         enum: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness }

                # @!attribute interrupt_response
                #   Whether or not to automatically interrupt any ongoing response with output to
                #   the default conversation (i.e. `conversation` of `auto`) when a VAD start event
                #   occurs.
                #
                #   @return [Boolean, nil]
                optional :interrupt_response, OpenAI::Internal::Type::Boolean

                # @!method initialize(create_response: nil, eagerness: nil, interrupt_response: nil, type: :semantic_vad)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad}
                #   for more details.
                #
                #   Server-side semantic turn detection which uses a model to determine when the
                #   user has finished speaking.
                #
                #   @param create_response [Boolean] Whether or not to automatically generate a response when a VAD stop event occurs
                #
                #   @param eagerness [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness] Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
                #
                #   @param interrupt_response [Boolean] Whether or not to automatically interrupt any ongoing response with output to th
                #
                #   @param type [Symbol, :semantic_vad] Type of turn detection, `semantic_vad` to turn on Semantic VAD.

                # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
                # will wait longer for the user to continue speaking, `high` will respond more
                # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
                # and `high` have max timeouts of 8s, 4s, and 2s respectively.
                #
                # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad#eagerness
                module Eagerness
                  extend OpenAI::Internal::Type::Enum

                  LOW = :low
                  MEDIUM = :medium
                  HIGH = :high
                  AUTO = :auto

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad)]
            end
          end

          # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio#output
          class Output < OpenAI::Internal::Type::BaseModel
            # @!attribute format_
            #   The format of the output audio.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA, nil]
            optional :format_, union: -> { OpenAI::Realtime::RealtimeAudioFormats }, api_name: :format

            # @!attribute speed
            #   The speed of the model's spoken response as a multiple of the original speed.
            #   1.0 is the default speed. 0.25 is the minimum speed. 1.5 is the maximum speed.
            #   This value can only be changed in between model turns, not while a response is
            #   in progress.
            #
            #   This parameter is a post-processing adjustment to the audio after it is
            #   generated, it's also possible to prompt the model to speak faster or slower.
            #
            #   @return [Float, nil]
            optional :speed, Float

            # @!attribute voice
            #   The voice the model uses to respond. Voice cannot be changed during the session
            #   once the model has responded with audio at least once. Current voice options are
            #   `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
            #   and `cedar`. We recommend `marin` and `cedar` for best quality.
            #
            #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice, nil]
            optional :voice, union: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice }

            # @!method initialize(format_: nil, speed: nil, voice: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output} for
            #   more details.
            #
            #   @param format_ [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA] The format of the output audio.
            #
            #   @param speed [Float] The speed of the model's spoken response as a multiple of the original speed.
            #
            #   @param voice [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice] The voice the model uses to respond. Voice cannot be changed during the

            # The voice the model uses to respond. Voice cannot be changed during the session
            # once the model has responded with audio at least once. Current voice options are
            # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
            # and `cedar`. We recommend `marin` and `cedar` for best quality.
            #
            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output#voice
            module Voice
              extend OpenAI::Internal::Type::Union

              variant String

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::ALLOY }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::ASH }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::BALLAD }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::CORAL }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::ECHO }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::SAGE }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::SHIMMER }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::VERSE }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::MARIN }

              variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::CEDAR }

              # @!method self.variants
              #   @return [Array(String, Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias { T.any(String, OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol) }
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

        module Include
          extend OpenAI::Internal::Type::Enum

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS = :"item.input_audio_transcription.logprobs"

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # Maximum number of output tokens for a single assistant response, inclusive of
        # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        #
        # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse#max_output_tokens
        module MaxOutputTokens
          extend OpenAI::Internal::Type::Union

          variant Integer

          variant const: :inf

          # @!method self.variants
          #   @return [Array(Integer, Symbol, :inf)]
        end

        # The Realtime model used for this session.
        #
        # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse#model
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_REALTIME }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_REALTIME_2025_08_28 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_4O_REALTIME_PREVIEW }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_4O_REALTIME_PREVIEW_2024_10_01 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_4O_REALTIME_PREVIEW_2024_12_17 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_4O_REALTIME_PREVIEW_2025_06_03 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_4O_MINI_REALTIME_PREVIEW }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_4O_MINI_REALTIME_PREVIEW_2024_12_17 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_REALTIME_MINI }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_REALTIME_MINI_2025_10_06 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_AUDIO_MINI }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Model::GPT_AUDIO_MINI_2025_10_06 }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol) }
          end

          # @!group

          GPT_REALTIME = :"gpt-realtime"
          GPT_REALTIME_2025_08_28 = :"gpt-realtime-2025-08-28"
          GPT_4O_REALTIME_PREVIEW = :"gpt-4o-realtime-preview"
          GPT_4O_REALTIME_PREVIEW_2024_10_01 = :"gpt-4o-realtime-preview-2024-10-01"
          GPT_4O_REALTIME_PREVIEW_2024_12_17 = :"gpt-4o-realtime-preview-2024-12-17"
          GPT_4O_REALTIME_PREVIEW_2025_06_03 = :"gpt-4o-realtime-preview-2025-06-03"
          GPT_4O_MINI_REALTIME_PREVIEW = :"gpt-4o-mini-realtime-preview"
          GPT_4O_MINI_REALTIME_PREVIEW_2024_12_17 = :"gpt-4o-mini-realtime-preview-2024-12-17"
          GPT_REALTIME_MINI = :"gpt-realtime-mini"
          GPT_REALTIME_MINI_2025_10_06 = :"gpt-realtime-mini-2025-10-06"
          GPT_AUDIO_MINI = :"gpt-audio-mini"
          GPT_AUDIO_MINI_2025_10_06 = :"gpt-audio-mini-2025-10-06"

          # @!endgroup
        end

        module OutputModality
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          AUDIO = :audio

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # How the model chooses tools. Provide one of the string modes or force a specific
        # function/MCP tool.
        #
        # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse#tool_choice
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          # Controls which (if any) tool is called by the model.
          #
          # `none` means the model will not call any tool and instead generates a message.
          #
          # `auto` means the model can pick between generating a message or calling one or
          # more tools.
          #
          # `required` means the model must call one or more tools.
          variant enum: -> { OpenAI::Responses::ToolChoiceOptions }

          # Use this option to force the model to call a specific function.
          variant -> { OpenAI::Responses::ToolChoiceFunction }

          # Use this option to force the model to call a specific tool on a remote MCP server.
          variant -> { OpenAI::Responses::ToolChoiceMcp }

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp)]
        end

        # Give the model access to additional tools via remote Model Context Protocol
        # (MCP) servers.
        # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
        module Tool
          extend OpenAI::Internal::Type::Union

          variant -> { OpenAI::Realtime::RealtimeFunctionTool }

          # Give the model access to additional tools via remote Model Context Protocol
          # (MCP) servers. [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
          variant -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool }

          class McpTool < OpenAI::Internal::Type::BaseModel
            # @!attribute server_label
            #   A label for this MCP server, used to identify it in tool calls.
            #
            #   @return [String]
            required :server_label, String

            # @!attribute type
            #   The type of the MCP tool. Always `mcp`.
            #
            #   @return [Symbol, :mcp]
            required :type, const: :mcp

            # @!attribute allowed_tools
            #   List of allowed tool names or a filter object.
            #
            #   @return [Array<String>, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter, nil]
            optional :allowed_tools,
                     union: -> {
                       OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools
                     },
                     nil?: true

            # @!attribute authorization
            #   An OAuth access token that can be used with a remote MCP server, either with a
            #   custom MCP server URL or a service connector. Your application must handle the
            #   OAuth authorization flow and provide the token here.
            #
            #   @return [String, nil]
            optional :authorization, String

            # @!attribute connector_id
            #   Identifier for service connectors, like those available in ChatGPT. One of
            #   `server_url` or `connector_id` must be provided. Learn more about service
            #   connectors
            #   [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
            #
            #   Currently supported `connector_id` values are:
            #
            #   - Dropbox: `connector_dropbox`
            #   - Gmail: `connector_gmail`
            #   - Google Calendar: `connector_googlecalendar`
            #   - Google Drive: `connector_googledrive`
            #   - Microsoft Teams: `connector_microsoftteams`
            #   - Outlook Calendar: `connector_outlookcalendar`
            #   - Outlook Email: `connector_outlookemail`
            #   - SharePoint: `connector_sharepoint`
            #
            #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID, nil]
            optional :connector_id,
                     enum: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID }

            # @!attribute headers
            #   Optional HTTP headers to send to the MCP server. Use for authentication or other
            #   purposes.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :headers, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!attribute require_approval
            #   Specify which of the MCP server's tools require approval.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting, nil]
            optional :require_approval,
                     union: -> {
                       OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval
                     },
                     nil?: true

            # @!attribute server_description
            #   Optional description of the MCP server, used to provide more context.
            #
            #   @return [String, nil]
            optional :server_description, String

            # @!attribute server_url
            #   The URL for the MCP server. One of `server_url` or `connector_id` must be
            #   provided.
            #
            #   @return [String, nil]
            optional :server_url, String

            # @!method initialize(server_label:, allowed_tools: nil, authorization: nil, connector_id: nil, headers: nil, require_approval: nil, server_description: nil, server_url: nil, type: :mcp)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool} for
            #   more details.
            #
            #   Give the model access to additional tools via remote Model Context Protocol
            #   (MCP) servers.
            #   [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
            #
            #   @param server_label [String] A label for this MCP server, used to identify it in tool calls.
            #
            #   @param allowed_tools [Array<String>, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter, nil] List of allowed tool names or a filter object.
            #
            #   @param authorization [String] An OAuth access token that can be used with a remote MCP server, either
            #
            #   @param connector_id [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID] Identifier for service connectors, like those available in ChatGPT. One of
            #
            #   @param headers [Hash{Symbol=>String}, nil] Optional HTTP headers to send to the MCP server. Use for authentication
            #
            #   @param require_approval [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting, nil] Specify which of the MCP server's tools require approval.
            #
            #   @param server_description [String] Optional description of the MCP server, used to provide more context.
            #
            #   @param server_url [String] The URL for the MCP server. One of `server_url` or `connector_id` must be
            #
            #   @param type [Symbol, :mcp] The type of the MCP tool. Always `mcp`.

            # List of allowed tool names or a filter object.
            #
            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool#allowed_tools
            module AllowedTools
              extend OpenAI::Internal::Type::Union

              # A string array of allowed tool names
              variant -> { OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::StringArray }

              # A filter object to specify which tools are allowed.
              variant -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter }

              class McpToolFilter < OpenAI::Internal::Type::BaseModel
                # @!attribute read_only
                #   Indicates whether or not a tool modifies data or is read-only. If an MCP server
                #   is
                #   [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                #   it will match this filter.
                #
                #   @return [Boolean, nil]
                optional :read_only, OpenAI::Internal::Type::Boolean

                # @!attribute tool_names
                #   List of allowed tool names.
                #
                #   @return [Array<String>, nil]
                optional :tool_names, OpenAI::Internal::Type::ArrayOf[String]

                # @!method initialize(read_only: nil, tool_names: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter}
                #   for more details.
                #
                #   A filter object to specify which tools are allowed.
                #
                #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
                #
                #   @param tool_names [Array<String>] List of allowed tool names.
              end

              # @!method self.variants
              #   @return [Array(Array<String>, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter)]

              # @type [OpenAI::Internal::Type::Converter]
              StringArray = OpenAI::Internal::Type::ArrayOf[String]
            end

            # Identifier for service connectors, like those available in ChatGPT. One of
            # `server_url` or `connector_id` must be provided. Learn more about service
            # connectors
            # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
            #
            # Currently supported `connector_id` values are:
            #
            # - Dropbox: `connector_dropbox`
            # - Gmail: `connector_gmail`
            # - Google Calendar: `connector_googlecalendar`
            # - Google Drive: `connector_googledrive`
            # - Microsoft Teams: `connector_microsoftteams`
            # - Outlook Calendar: `connector_outlookcalendar`
            # - Outlook Email: `connector_outlookemail`
            # - SharePoint: `connector_sharepoint`
            #
            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool#connector_id
            module ConnectorID
              extend OpenAI::Internal::Type::Enum

              CONNECTOR_DROPBOX = :connector_dropbox
              CONNECTOR_GMAIL = :connector_gmail
              CONNECTOR_GOOGLECALENDAR = :connector_googlecalendar
              CONNECTOR_GOOGLEDRIVE = :connector_googledrive
              CONNECTOR_MICROSOFTTEAMS = :connector_microsoftteams
              CONNECTOR_OUTLOOKCALENDAR = :connector_outlookcalendar
              CONNECTOR_OUTLOOKEMAIL = :connector_outlookemail
              CONNECTOR_SHAREPOINT = :connector_sharepoint

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # Specify which of the MCP server's tools require approval.
            #
            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool#require_approval
            module RequireApproval
              extend OpenAI::Internal::Type::Union

              # Specify which of the MCP server's tools require approval. Can be
              # `always`, `never`, or a filter object associated with tools
              # that require approval.
              variant -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter }

              # Specify a single approval policy for all tools. One of `always` or
              # `never`. When set to `always`, all tools will require approval. When
              # set to `never`, all tools will not require approval.
              variant enum: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting }

              class McpToolApprovalFilter < OpenAI::Internal::Type::BaseModel
                # @!attribute always
                #   A filter object to specify which tools are allowed.
                #
                #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always, nil]
                optional :always,
                         -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always }

                # @!attribute never
                #   A filter object to specify which tools are allowed.
                #
                #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never, nil]
                optional :never,
                         -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never }

                # @!method initialize(always: nil, never: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter}
                #   for more details.
                #
                #   Specify which of the MCP server's tools require approval. Can be `always`,
                #   `never`, or a filter object associated with tools that require approval.
                #
                #   @param always [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always] A filter object to specify which tools are allowed.
                #
                #   @param never [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never] A filter object to specify which tools are allowed.

                # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter#always
                class Always < OpenAI::Internal::Type::BaseModel
                  # @!attribute read_only
                  #   Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  #   is
                  #   [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  #   it will match this filter.
                  #
                  #   @return [Boolean, nil]
                  optional :read_only, OpenAI::Internal::Type::Boolean

                  # @!attribute tool_names
                  #   List of allowed tool names.
                  #
                  #   @return [Array<String>, nil]
                  optional :tool_names, OpenAI::Internal::Type::ArrayOf[String]

                  # @!method initialize(read_only: nil, tool_names: nil)
                  #   Some parameter documentations has been truncated, see
                  #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always}
                  #   for more details.
                  #
                  #   A filter object to specify which tools are allowed.
                  #
                  #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
                  #
                  #   @param tool_names [Array<String>] List of allowed tool names.
                end

                # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter#never
                class Never < OpenAI::Internal::Type::BaseModel
                  # @!attribute read_only
                  #   Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  #   is
                  #   [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  #   it will match this filter.
                  #
                  #   @return [Boolean, nil]
                  optional :read_only, OpenAI::Internal::Type::Boolean

                  # @!attribute tool_names
                  #   List of allowed tool names.
                  #
                  #   @return [Array<String>, nil]
                  optional :tool_names, OpenAI::Internal::Type::ArrayOf[String]

                  # @!method initialize(read_only: nil, tool_names: nil)
                  #   Some parameter documentations has been truncated, see
                  #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never}
                  #   for more details.
                  #
                  #   A filter object to specify which tools are allowed.
                  #
                  #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
                  #
                  #   @param tool_names [Array<String>] List of allowed tool names.
                end
              end

              # Specify a single approval policy for all tools. One of `always` or `never`. When
              # set to `always`, all tools will require approval. When set to `never`, all tools
              # will not require approval.
              module McpToolApprovalSetting
                extend OpenAI::Internal::Type::Enum

                ALWAYS = :always
                NEVER = :never

                # @!method self.values
                #   @return [Array<Symbol>]
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting)]
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::McpTool)]
        end

        # Realtime API can write session traces to the
        # [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
        # tracing is enabled for a session, the configuration cannot be modified.
        #
        # `auto` will create a trace for the session with default values for the workflow
        # name, group id, and metadata.
        #
        # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse#tracing
        module Tracing
          extend OpenAI::Internal::Type::Union

          # Enables tracing and sets default values for tracing configuration options. Always `auto`.
          variant const: :auto

          # Granular configuration for tracing.
          variant -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration }

          class TracingConfiguration < OpenAI::Internal::Type::BaseModel
            # @!attribute group_id
            #   The group id to attach to this trace to enable filtering and grouping in the
            #   Traces Dashboard.
            #
            #   @return [String, nil]
            optional :group_id, String

            # @!attribute metadata
            #   The arbitrary metadata to attach to this trace to enable filtering in the Traces
            #   Dashboard.
            #
            #   @return [Object, nil]
            optional :metadata, OpenAI::Internal::Type::Unknown

            # @!attribute workflow_name
            #   The name of the workflow to attach to this trace. This is used to name the trace
            #   in the Traces Dashboard.
            #
            #   @return [String, nil]
            optional :workflow_name, String

            # @!method initialize(group_id: nil, metadata: nil, workflow_name: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration}
            #   for more details.
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
          #   @return [Array(Symbol, :auto, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration)]
        end
      end
    end

    RealtimeSessionCreateResponse = Realtime::RealtimeSessionCreateResponse
  end
end
