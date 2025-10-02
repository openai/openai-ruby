# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class Calls
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Realtime::CallAcceptParams} for more details.
        #
        # Accept an incoming SIP call and configure the realtime session that will handle
        # it.
        #
        # @overload accept(call_id, audio: nil, include: nil, instructions: nil, max_output_tokens: nil, model: nil, output_modalities: nil, prompt: nil, tool_choice: nil, tools: nil, tracing: nil, truncation: nil, type: :realtime, request_options: {})
        #
        # @param call_id [String] The identifier for the call provided in the
        #
        # @param audio [OpenAI::Models::Realtime::RealtimeAudioConfig] Configuration for input and output audio.
        #
        # @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Include>] Additional fields to include in server outputs.
        #
        # @param instructions [String] The default system instructions (i.e. system message) prepended to model calls.
        #
        # @param max_output_tokens [Integer, Symbol, :inf] Maximum number of output tokens for a single assistant response,
        #
        # @param model [String, Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::Model] The Realtime model used for this session.
        #
        # @param output_modalities [Array<Symbol, OpenAI::Models::Realtime::RealtimeSessionCreateRequest::OutputModality>] The set of modalities the model can respond with. It defaults to `["audio"]`, in
        #
        # @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        # @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp] How the model chooses tools. Provide one of the string modes or force a specific
        #
        # @param tools [Array<OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp>] Tools available to the model.
        #
        # @param tracing [Symbol, :auto, OpenAI::Models::Realtime::RealtimeTracingConfig::TracingConfiguration, nil] Realtime API can write session traces to the [Traces Dashboard](/logs?api=traces
        #
        # @param truncation [Symbol, OpenAI::Models::Realtime::RealtimeTruncation::RealtimeTruncationStrategy, OpenAI::Models::Realtime::RealtimeTruncationRetentionRatio] Controls how the realtime conversation is truncated prior to model inference.
        #
        # @param type [Symbol, :realtime] The type of session to create. Always `realtime` for the Realtime API.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Realtime::CallAcceptParams
        def accept(call_id, params)
          parsed, options = OpenAI::Realtime::CallAcceptParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["realtime/calls/%1$s/accept", call_id],
            body: parsed,
            model: NilClass,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Realtime::CallHangupParams} for more details.
        #
        # End an active Realtime API call, whether it was initiated over SIP or WebRTC.
        #
        # @overload hangup(call_id, request_options: {})
        #
        # @param call_id [String] The identifier for the call. For SIP calls, use the value provided in the
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Realtime::CallHangupParams
        def hangup(call_id, params = {})
          @client.request(
            method: :post,
            path: ["realtime/calls/%1$s/hangup", call_id],
            model: NilClass,
            options: params[:request_options]
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Realtime::CallReferParams} for more details.
        #
        # Transfer an active SIP call to a new destination using the SIP REFER verb.
        #
        # @overload refer(call_id, target_uri:, request_options: {})
        #
        # @param call_id [String] The identifier for the call provided in the
        #
        # @param target_uri [String] URI that should appear in the SIP Refer-To header. Supports values like
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Realtime::CallReferParams
        def refer(call_id, params)
          parsed, options = OpenAI::Realtime::CallReferParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["realtime/calls/%1$s/refer", call_id],
            body: parsed,
            model: NilClass,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Realtime::CallRejectParams} for more details.
        #
        # Decline an incoming SIP call by returning a SIP status code to the caller.
        #
        # @overload reject(call_id, status_code: nil, request_options: {})
        #
        # @param call_id [String] The identifier for the call provided in the
        #
        # @param status_code [Integer] SIP response code to send back to the caller. Defaults to `603` (Decline)
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Realtime::CallRejectParams
        def reject(call_id, params = {})
          parsed, options = OpenAI::Realtime::CallRejectParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["realtime/calls/%1$s/reject", call_id],
            body: parsed,
            model: NilClass,
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
