# frozen_string_literal: true

require_relative "../chat/tool_runner"

module OpenAI
  module Resources
    class Chat
      class Completions
        # Run function tools until the model returns a final, non-streaming completion.
        # Handlers receive a JSON object with string keys. String results are sent
        # verbatim; other results are JSON encoded. Callback errors propagate without
        # retrying callbacks or sending their exception text to the model.
        # max_rounds bounds API calls (including the final answer), defaulting to 10.
        # A forced tool choice applies only to the first round. Callbacks run serially.
        #
        # @param tool_handlers [Hash{String=>#call}]
        # @param max_rounds [Integer]
        # @param params [Hash] Other Chat Completions create parameters.
        # @return [OpenAI::Models::Chat::ChatCompletion]
        def run_tools(model:, messages:, tools:, tool_handlers:, max_rounds: 10, **params)
          OpenAI::Helpers::Chat::ToolRunner
            .new(
              completions: self,
              params: params.merge(model: model, messages: messages, tools: tools),
              tool_handlers: tool_handlers,
              max_rounds: max_rounds
            )
            .run
        end

        # @api private
        # Restrict malformed-response handling to parsing, preserving transport errors.
        def create_for_tool_runner(params)
          parsed, options = OpenAI::Chat::CompletionCreateParams.dump_request(params)
          model, tool_models = get_structured_output_models(parsed)
          parse = OpenAI::Helpers::StructuredOutput::ChatCompletionParser.build_unwrap(model, tool_models)
          unwrap = lambda do |raw|
            parse.call(raw)
          rescue KeyError, NoMethodError, TypeError, OpenAI::Errors::ConversionError
            raise OpenAI::Helpers::Chat::ToolRunner::Error, "Malformed Chat Completion response", cause: nil
          end

          @client.request(
            method: :post,
            path: "chat/completions",
            body: parsed,
            unwrap: unwrap,
            model: OpenAI::Chat::ChatCompletion,
            security: {bearer_auth: true},
            options: options
          )
        end

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
