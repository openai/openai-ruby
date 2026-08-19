# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::Calls#accept
      class CallAcceptParams < OpenAI::Models::Realtime::RealtimeSessionCreateRequest
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute call_id
        #
        #   @return [String]
        required :call_id, String

        # @!method initialize(call_id:, audio: nil, include: nil, instructions: nil, max_output_tokens: nil, model: nil, output_modalities: nil, parallel_tool_calls: nil, prompt: nil, reasoning: nil, tool_choice: nil, tools: nil, tracing: nil, truncation: nil, type: :realtime, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::CallAcceptParams} for more details.
        #
        #   @param call_id [String]
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
        #   @param parallel_tool_calls [Boolean] Whether the model may call multiple tools in parallel. Only supported by
        #
        #   @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        #   @param reasoning [OpenAI::Models::Realtime::RealtimeReasoning] Configuration for reasoning-capable Realtime models such as `gpt-realtime-2`.
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp] How the model chooses tools. Provide one of the string modes or force a specific
        #
        #   @param tools [Array<OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp>] Tools available to the model.
        #
        #   @param tracing [Symbol, :auto, OpenAI::Models::Realtime::RealtimeTracingConfig::TracingConfiguration, nil] Realtime API can write session traces to the [Traces Dashboard](https://platform
        #
        #   @param truncation [Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio] When the number of tokens in a conversation exceeds the model's input token limi
        #
        #   @param type [Symbol, :realtime] The type of session to create. Always `realtime` for the Realtime API.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
