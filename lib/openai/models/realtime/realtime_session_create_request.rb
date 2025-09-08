# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeSessionCreateRequest < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of session to create. Always `realtime` for the Realtime API.
        #
        #   @return [Symbol, :realtime]
        required :type, const: :realtime

        # @!attribute audio
        #   Configuration for input and output audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeAudioConfig, nil]
        optional :audio, -> { OpenAI::Realtime::RealtimeAudioConfig }

        # @!attribute include
        #   Additional fields to include in server outputs.
        #
        #   `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        #   transcription.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Include>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeSessionCreateRequest::Include] }

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
        optional :max_output_tokens, union: -> { OpenAI::Realtime::RealtimeSessionCreateRequest::MaxOutputTokens }

        # @!attribute model
        #   The Realtime model used for this session.
        #
        #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model, nil]
        optional :model, union: -> { OpenAI::Realtime::RealtimeSessionCreateRequest::Model }

        # @!attribute output_modalities
        #   The set of modalities the model can respond with. It defaults to `["audio"]`,
        #   indicating that the model will respond with audio plus a transcript. `["text"]`
        #   can be used to make the model respond with text only. It is not possible to
        #   request both `text` and `audio` at the same time.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::OutputModality>, nil]
        optional :output_modalities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality] }

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
        optional :tool_choice, union: -> { OpenAI::Realtime::RealtimeToolChoiceConfig }

        # @!attribute tools
        #   Tools available to the model.
        #
        #   @return [Array<OpenAI::Models::Realtime::Models, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp>, nil]
        optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Realtime::RealtimeToolsConfigUnion] }

        # @!attribute tracing
        #   Realtime API can write session traces to the
        #   [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
        #   tracing is enabled for a session, the configuration cannot be modified.
        #
        #   `auto` will create a trace for the session with default values for the workflow
        #   name, group id, and metadata.
        #
        #   @return [Symbol, :auto, OpenAI::Models::Realtime::RealtimeTracingConfig::TracingConfiguration, nil]
        optional :tracing, union: -> { OpenAI::Realtime::RealtimeTracingConfig }, nil?: true

        # @!attribute truncation
        #   Controls how the realtime conversation is truncated prior to model inference.
        #   The default is `auto`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio, nil]
        optional :truncation, union: -> { OpenAI::Realtime::RealtimeTruncation }

        # @!method initialize(audio: nil, include: nil, instructions: nil, max_output_tokens: nil, model: nil, output_modalities: nil, prompt: nil, tool_choice: nil, tools: nil, tracing: nil, truncation: nil, type: :realtime)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeSessionCreateRequest} for more details.
        #
        #   Realtime session object configuration.
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeAudioConfig] Configuration for input and output audio.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Include>] Additional fields to include in server outputs.
        #
        #   @param instructions [String] The default system instructions (i.e. system message) prepended to model calls.
        #
        #   @param max_output_tokens [Integer, Symbol, :inf] Maximum number of output tokens for a single assistant response,
        #
        #   @param model [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model] The Realtime model used for this session.
        #
        #   @param output_modalities [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::OutputModality>] The set of modalities the model can respond with. It defaults to `["audio"]`, in
        #
        #   @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp] How the model chooses tools. Provide one of the string modes or force a specific
        #
        #   @param tools [Array<OpenAI::Models::Realtime::Models, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp>] Tools available to the model.
        #
        #   @param tracing [Symbol, :auto, OpenAI::Models::Realtime::RealtimeTracingConfig::TracingConfiguration, nil] Realtime API can write session traces to the [Traces Dashboard](/logs?api=traces
        #
        #   @param truncation [Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio] Controls how the realtime conversation is truncated prior to model inference.
        #
        #   @param type [Symbol, :realtime] The type of session to create. Always `realtime` for the Realtime API.

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
        # @see OpenAI::Models::Realtime::RealtimeSessionCreateRequest#max_output_tokens
        module MaxOutputTokens
          extend OpenAI::Internal::Type::Union

          variant Integer

          variant const: :inf

          # @!method self.variants
          #   @return [Array(Integer, Symbol, :inf)]
        end

        # The Realtime model used for this session.
        #
        # @see OpenAI::Models::Realtime::RealtimeSessionCreateRequest#model
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_REALTIME }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_REALTIME_2025_08_28 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_4O_REALTIME_PREVIEW }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_4O_REALTIME_PREVIEW_2024_10_01 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_4O_REALTIME_PREVIEW_2024_12_17 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_4O_REALTIME_PREVIEW_2025_06_03 }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_4O_MINI_REALTIME_PREVIEW }

          variant const: -> { OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model::GPT_4O_MINI_REALTIME_PREVIEW_2024_12_17 }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol) }
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

          # @!endgroup
        end

        module OutputModality
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          AUDIO = :audio

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
