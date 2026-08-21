#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "timeout"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module FunctionCalling
        TOOL_NAME = "lookup_weather"

        module_function

        def run(client:, model:, prompt:, output: $stdout)
          client.realtime.connect(model: model) do |connection|
            configure(connection)
            connection.conversation.items.create(
              type: :message,
              role: :user,
              content: [{type: :input_text, text: prompt}]
            )
            connection.response.create

            tool_call = wait_for_tool_call(connection)
            connection.conversation.items.create(
              type: :function_call_output,
              call_id: tool_call.call_id,
              output: execute_tool(tool_call)
            )
            connection.response.create(tool_choice: :none)

            text = wait_for_final_text(connection)
            output.puts("[realtime] function calling response.done status=completed")
            text
          end
        end

        def run_with_timeout(client:, model:, prompt:, timeout_seconds:, output: $stdout)
          result = Timeout.timeout(timeout_seconds) do
            run(client: client, model: model, prompt: prompt, output: output)
          end

          output.puts("[realtime] function calling smoke test passed")
          result
        rescue OpenAI::Errors::RealtimeProtocolError
          raise RuntimeError, "Realtime protocol error.", cause: nil
        end

        def configure(connection)
          connection.session.update(
            type: :realtime,
            output_modalities: [:text],
            parallel_tool_calls: false,
            tools: [
              {
                type: :function,
                name: TOOL_NAME,
                description: "Look up deterministic example weather for one city.",
                parameters: {
                  type: :object,
                  properties: {city: {type: :string}},
                  required: [:city],
                  additionalProperties: false
                }
              }
            ],
            tool_choice: {type: :function, name: TOOL_NAME}
          )
        end

        def wait_for_tool_call(connection)
          tool_call = nil

          connection.each do |event|
            case event
            when OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent
              raise "Realtime returned more than one function call." if tool_call

              tool_call = event
            when OpenAI::Realtime::ResponseDoneEvent
              require_completed_response(event)
              raise "Realtime response completed without the required function call." unless tool_call
              unless event.response.id == tool_call.response_id
                raise "Realtime function call did not match response.done."
              end

              return tool_call
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error."
            end
          end

          raise "Realtime connection closed before the function response.done."
        end

        def execute_tool(tool_call)
          raise "Realtime returned an unexpected function name." unless tool_call.name == TOOL_NAME

          arguments = JSON.parse(tool_call.arguments)
          city = nil
          city = arguments["city"] if arguments.is_a?(Hash) && arguments.keys == ["city"]
          unless city.is_a?(String) && !city.empty?
            raise "Realtime returned invalid function arguments."
          end

          JSON.generate(city: city, temperature_c: 18, conditions: "clear")
        rescue JSON::ParserError
          raise RuntimeError, "Realtime returned invalid function arguments.", cause: nil
        end

        def wait_for_final_text(connection)
          connection.each do |event|
            case event
            when OpenAI::Realtime::ResponseDoneEvent
              require_completed_response(event)
              text = completed_text(event.response)
              raise "Realtime final response completed without text output." if text.strip.empty?

              return text
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error."
            end
          end

          raise "Realtime connection closed before the final response.done."
        end

        def completed_text(response)
          Array(response.output)
            .filter_map do |item|
              next unless item.is_a?(OpenAI::Realtime::RealtimeConversationItemAssistantMessage)

              item.content.filter_map { |content| content.text if content.type == :output_text }.join
            end
            .join
        end

        def require_completed_response(event)
          return if event.response.status == :completed

          raise "Realtime response did not complete."
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  OpenAI::Examples::Realtime::FunctionCalling.run_with_timeout(
    client: OpenAI::Client.new,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
    prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "What is the weather in Paris?"),
    timeout_seconds: Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))
  )
end
