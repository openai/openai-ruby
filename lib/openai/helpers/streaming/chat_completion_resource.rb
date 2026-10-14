# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      class Completions
        def stream(params)
          parsed, options = OpenAI::Chat::CompletionCreateParams.dump_request(params)

          parsed.store(:stream, true)

          response_format, tool_models = get_structured_output_models(parsed)

          input_tools = build_tools_with_models(parsed[:tools], tool_models)

          raw_stream = @client.request(
            method: :post,
            path: "chat/completions",
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Chat::ChatCompletionChunk,
            security: {bearer_auth: true},
            options: options
          )

          OpenAI::Helpers::Streaming::ChatCompletionStream.new(
            raw_stream: raw_stream,
            response_format: response_format,
            input_tools: input_tools
          )
        end
      end
    end
  end
end
