# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeSessionCreateResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute audio
        #   Configuration for input and output audio for the session.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio, nil]
        optional :audio, -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio }

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
        #   @return [String, nil]
        optional :model, String

        # @!attribute object
        #   The object type. Always `realtime.session`.
        #
        #   @return [String, nil]
        optional :object, String

        # @!attribute output_modalities
        #   The set of modalities the model can respond with. To disable audio, set this to
        #   ["text"].
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::OutputModality>, nil]
        optional :output_modalities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality] }

        # @!attribute tool_choice
        #   How the model chooses tools. Options are `auto`, `none`, `required`, or specify
        #   a function.
        #
        #   @return [String, nil]
        optional :tool_choice, String

        # @!attribute tools
        #   Tools (functions) available to the model.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool>, nil]
        optional :tools,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::RealtimeSessionCreateResponse::Tool] }

        # @!attribute tracing
        #   Configuration options for tracing. Set to null to disable tracing. Once tracing
        #   is enabled for a session, the configuration cannot be modified.
        #
        #   `auto` will create a trace for the session with default values for the workflow
        #   name, group id, and metadata.
        #
        #   @return [Symbol, :auto, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration, nil]
        optional :tracing, union: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing }

        # @!attribute turn_detection
        #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
        #   means that the model will detect the start and end of speech based on audio
        #   volume and respond at the end of user speech.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::TurnDetection, nil]
        optional :turn_detection, -> { OpenAI::Realtime::RealtimeSessionCreateResponse::TurnDetection }

        # @!method initialize(id: nil, audio: nil, expires_at: nil, include: nil, instructions: nil, max_output_tokens: nil, model: nil, object: nil, output_modalities: nil, tool_choice: nil, tools: nil, tracing: nil, turn_detection: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse} for more details.
        #
        #   A Realtime session configuration object.
        #
        #   @param id [String] Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio] Configuration for input and output audio for the session.
        #
        #   @param expires_at [Integer] Expiration timestamp for the session, in seconds since epoch.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Include>] Additional fields to include in server outputs.
        #
        #   @param instructions [String] The default system instructions (i.e. system message) prepended to model
        #
        #   @param max_output_tokens [Integer, Symbol, :inf] Maximum number of output tokens for a single assistant response,
        #
        #   @param model [String] The Realtime model used for this session.
        #
        #   @param object [String] The object type. Always `realtime.session`.
        #
        #   @param output_modalities [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::OutputModality>] The set of modalities the model can respond with. To disable audio,
        #
        #   @param tool_choice [String] How the model chooses tools. Options are `auto`, `none`, `required`, or
        #
        #   @param tools [Array<OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool>] Tools (functions) available to the model.
        #
        #   @param tracing [Symbol, :auto, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration] Configuration options for tracing. Set to null to disable tracing. Once
        #
        #   @param turn_detection [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::TurnDetection] Configuration for turn detection. Can be set to `null` to turn off. Server

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
          #   Configuration for input and output audio for the session.
          #
          #   @param input [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input]
          #   @param output [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output]

          # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio#input
          class Input < OpenAI::Internal::Type::BaseModel
            # @!attribute format_
            #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            #
            #   @return [String, nil]
            optional :format_, String, api_name: :format

            # @!attribute noise_reduction
            #   Configuration for input audio noise reduction.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction, nil]
            optional :noise_reduction,
                     -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction }

            # @!attribute transcription
            #   Configuration for input audio transcription.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription, nil]
            optional :transcription,
                     -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription }

            # @!attribute turn_detection
            #   Configuration for turn detection.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection, nil]
            optional :turn_detection,
                     -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection }

            # @!method initialize(format_: nil, noise_reduction: nil, transcription: nil, turn_detection: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input} for more
            #   details.
            #
            #   @param format_ [String] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            #
            #   @param noise_reduction [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction] Configuration for input audio noise reduction.
            #
            #   @param transcription [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription] Configuration for input audio transcription.
            #
            #   @param turn_detection [OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection] Configuration for turn detection.

            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input#noise_reduction
            class NoiseReduction < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #
              #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type, nil]
              optional :type,
                       enum: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type }

              # @!method initialize(type: nil)
              #   Configuration for input audio noise reduction.
              #
              #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type]

              # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction#type
              module Type
                extend OpenAI::Internal::Type::Enum

                NEAR_FIELD = :near_field
                FAR_FIELD = :far_field

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input#transcription
            class Transcription < OpenAI::Internal::Type::BaseModel
              # @!attribute language
              #   The language of the input audio.
              #
              #   @return [String, nil]
              optional :language, String

              # @!attribute model
              #   The model to use for transcription.
              #
              #   @return [String, nil]
              optional :model, String

              # @!attribute prompt
              #   Optional text to guide the model's style or continue a previous audio segment.
              #
              #   @return [String, nil]
              optional :prompt, String

              # @!method initialize(language: nil, model: nil, prompt: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription}
              #   for more details.
              #
              #   Configuration for input audio transcription.
              #
              #   @param language [String] The language of the input audio.
              #
              #   @param model [String] The model to use for transcription.
              #
              #   @param prompt [String] Optional text to guide the model's style or continue a previous audio segment.
            end

            # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input#turn_detection
            class TurnDetection < OpenAI::Internal::Type::BaseModel
              # @!attribute prefix_padding_ms
              #
              #   @return [Integer, nil]
              optional :prefix_padding_ms, Integer

              # @!attribute silence_duration_ms
              #
              #   @return [Integer, nil]
              optional :silence_duration_ms, Integer

              # @!attribute threshold
              #
              #   @return [Float, nil]
              optional :threshold, Float

              # @!attribute type
              #   Type of turn detection, only `server_vad` is currently supported.
              #
              #   @return [String, nil]
              optional :type, String

              # @!method initialize(prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection}
              #   for more details.
              #
              #   Configuration for turn detection.
              #
              #   @param prefix_padding_ms [Integer]
              #
              #   @param silence_duration_ms [Integer]
              #
              #   @param threshold [Float]
              #
              #   @param type [String] Type of turn detection, only `server_vad` is currently supported.
            end
          end

          # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio#output
          class Output < OpenAI::Internal::Type::BaseModel
            # @!attribute format_
            #   The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            #
            #   @return [String, nil]
            optional :format_, String, api_name: :format

            # @!attribute speed
            #
            #   @return [Float, nil]
            optional :speed, Float

            # @!attribute voice
            #
            #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice, nil]
            optional :voice, union: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice }

            # @!method initialize(format_: nil, speed: nil, voice: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output} for
            #   more details.
            #
            #   @param format_ [String] The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            #
            #   @param speed [Float]
            #
            #   @param voice [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice]

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

        module OutputModality
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          AUDIO = :audio

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        class Tool < OpenAI::Internal::Type::BaseModel
          # @!attribute description
          #   The description of the function, including guidance on when and how to call it,
          #   and guidance about what to tell the user when calling (if anything).
          #
          #   @return [String, nil]
          optional :description, String

          # @!attribute name
          #   The name of the function.
          #
          #   @return [String, nil]
          optional :name, String

          # @!attribute parameters
          #   Parameters of the function in JSON Schema.
          #
          #   @return [Object, nil]
          optional :parameters, OpenAI::Internal::Type::Unknown

          # @!attribute type
          #   The type of the tool, i.e. `function`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type }

          # @!method initialize(description: nil, name: nil, parameters: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool} for more
          #   details.
          #
          #   @param description [String] The description of the function, including guidance on when and how
          #
          #   @param name [String] The name of the function.
          #
          #   @param parameters [Object] Parameters of the function in JSON Schema.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool::Type] The type of the tool, i.e. `function`.

          # The type of the tool, i.e. `function`.
          #
          # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse::Tool#type
          module Type
            extend OpenAI::Internal::Type::Enum

            FUNCTION = :function

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # Configuration options for tracing. Set to null to disable tracing. Once tracing
        # is enabled for a session, the configuration cannot be modified.
        #
        # `auto` will create a trace for the session with default values for the workflow
        # name, group id, and metadata.
        #
        # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse#tracing
        module Tracing
          extend OpenAI::Internal::Type::Union

          # Default tracing mode for the session.
          variant const: :auto

          # Granular configuration for tracing.
          variant -> { OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration }

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

        # @see OpenAI::Models::Realtime::RealtimeSessionCreateResponse#turn_detection
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
          #   Type of turn detection, only `server_vad` is currently supported.
          #
          #   @return [String, nil]
          optional :type, String

          # @!method initialize(prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeSessionCreateResponse::TurnDetection} for
          #   more details.
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
          #   @param type [String] Type of turn detection, only `server_vad` is currently supported.
        end
      end
    end

    RealtimeSessionCreateResponse = Realtime::RealtimeSessionCreateResponse
  end
end
