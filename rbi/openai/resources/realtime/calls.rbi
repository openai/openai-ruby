# typed: strong

module OpenAI
  module Resources
    class Realtime
      class Calls
        # Accept an incoming SIP call and configure the realtime session that will handle
        # it.
        sig do
          params(
            call_id: String,
            audio: OpenAI::Realtime::RealtimeAudioConfig::OrHash,
            include:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::Include::OrSymbol
              ],
            instructions: String,
            max_output_tokens: T.any(Integer, Symbol),
            model:
              T.any(
                String,
                OpenAI::Realtime::RealtimeSessionCreateRequest::Model::OrSymbol
              ),
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::OrSymbol
              ],
            prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
            tool_choice:
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceFunction::OrHash,
                OpenAI::Responses::ToolChoiceMcp::OrHash
              ),
            tools:
              T::Array[
                T.any(
                  OpenAI::Realtime::RealtimeFunctionTool::OrHash,
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::OrHash
                )
              ],
            tracing:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration::OrHash
                )
              ),
            truncation:
              T.any(
                OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::OrSymbol,
                OpenAI::Realtime::RealtimeTruncationRetentionRatio::OrHash
              ),
            type: Symbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).void
        end
        def accept(
          # The identifier for the call provided in the
          # [`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook-events/realtime/call/incoming)
          # webhook.
          call_id,
          # Configuration for input and output audio.
          audio: nil,
          # Additional fields to include in server outputs.
          #
          # `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          # transcription.
          include: nil,
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
          max_output_tokens: nil,
          # The Realtime model used for this session.
          model: nil,
          # The set of modalities the model can respond with. It defaults to `["audio"]`,
          # indicating that the model will respond with audio plus a transcript. `["text"]`
          # can be used to make the model respond with text only. It is not possible to
          # request both `text` and `audio` at the same time.
          output_modalities: nil,
          # Reference to a prompt template and its variables.
          # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
          prompt: nil,
          # How the model chooses tools. Provide one of the string modes or force a specific
          # function/MCP tool.
          tool_choice: nil,
          # Tools available to the model.
          tools: nil,
          # Realtime API can write session traces to the
          # [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
          # tracing is enabled for a session, the configuration cannot be modified.
          #
          # `auto` will create a trace for the session with default values for the workflow
          # name, group id, and metadata.
          tracing: nil,
          # When the number of tokens in a conversation exceeds the model's input token
          # limit, the conversation be truncated, meaning messages (starting from the
          # oldest) will not be included in the model's context. A 32k context model with
          # 4,096 max output tokens can only include 28,224 tokens in the context before
          # truncation occurs. Clients can configure truncation behavior to truncate with a
          # lower max token limit, which is an effective way to control token usage and
          # cost. Truncation will reduce the number of cached tokens on the next turn
          # (busting the cache), since messages are dropped from the beginning of the
          # context. However, clients can also configure truncation to retain messages up to
          # a fraction of the maximum context size, which will reduce the need for future
          # truncations and thus improve the cache rate. Truncation can be disabled
          # entirely, which means the server will never truncate but would instead return an
          # error if the conversation exceeds the model's input token limit.
          truncation: nil,
          # The type of session to create. Always `realtime` for the Realtime API.
          type: :realtime,
          request_options: {}
        )
        end

        # End an active Realtime API call, whether it was initiated over SIP or WebRTC.
        sig do
          params(
            call_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).void
        end
        def hangup(
          # The identifier for the call. For SIP calls, use the value provided in the
          # [`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook-events/realtime/call/incoming)
          # webhook. For WebRTC sessions, reuse the call ID returned in the `Location`
          # header when creating the call with
          # [`POST /v1/realtime/calls`](https://platform.openai.com/docs/api-reference/realtime/create-call).
          call_id,
          request_options: {}
        )
        end

        # Transfer an active SIP call to a new destination using the SIP REFER verb.
        sig do
          params(
            call_id: String,
            target_uri: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).void
        end
        def refer(
          # The identifier for the call provided in the
          # [`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook-events/realtime/call/incoming)
          # webhook.
          call_id,
          # URI that should appear in the SIP Refer-To header. Supports values like
          # `tel:+14155550123` or `sip:agent@example.com`.
          target_uri:,
          request_options: {}
        )
        end

        # Decline an incoming SIP call by returning a SIP status code to the caller.
        sig do
          params(
            call_id: String,
            status_code: Integer,
            request_options: OpenAI::RequestOptions::OrHash
          ).void
        end
        def reject(
          # The identifier for the call provided in the
          # [`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook-events/realtime/call/incoming)
          # webhook.
          call_id,
          # SIP response code to send back to the caller. Defaults to `603` (Decline) when
          # omitted.
          status_code: nil,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
