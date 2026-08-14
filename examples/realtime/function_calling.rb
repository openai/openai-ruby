#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require_relative "../../lib/openai"
require_relative "websocket_text"

module OpenAI
  module Examples
    module Realtime
      module FunctionCalling
        TOOL_NAME = "lookup_weather"

        module_function

        def configure(connection)
          connection.session.update(
            type: :realtime,
            output_modalities: [:text],
            tools: [
              {
                type: :function,
                name: TOOL_NAME,
                description: "Look up the current weather for a city.",
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

        def send_prompt(connection, prompt)
          connection.conversation.items.create(
            type: :message,
            role: :user,
            content: [{type: :input_text, text: prompt}]
          )
          connection.response.create
        end

        def execute_tool(event)
          raise "Unexpected function #{event.name.inspect}" unless event.name == TOOL_NAME

          arguments = JSON.parse(event.arguments, symbolize_names: true)
          city = arguments.fetch(:city)
          raise "The city argument must be a non-empty string" unless city.is_a?(String) && !city.empty?

          JSON.generate(city: city, temperature_c: 18, conditions: "clear")
        rescue JSON::ParserError, KeyError => e
          raise "Invalid arguments for #{TOOL_NAME}: #{e.message}", cause: e
        end

        def run_session(connection, output: $stdout)
          tool_call = wait_for_tool_call(connection, output: output)
          result = execute_tool(tool_call)
          connection.conversation.items.create_function_call_output(
            call_id: tool_call.call_id,
            output: result
          )
          output.puts("[tool] result=#{result}")
          connection.response.create(tool_choice: :none)
          WebSocketText.stream_response(connection, output: output)
        end

        def wait_for_tool_call(connection, output: $stdout)
          tool_call = nil
          connection.each do |event|
            case event
            when OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent
              tool_call = event
              output.puts("[tool] #{event.name}(#{event.arguments})")
            when OpenAI::Realtime::ResponseDoneEvent
              unless event.response.status == :completed
                raise "Response ended with #{event.response.status}"
              end
              return tool_call if tool_call

              raise "Response completed without calling #{TOOL_NAME}"
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error: #{event.error.message}"
            end
          end

          raise "Realtime connection closed before the function response.done"
        end

        def run(client:, model:, prompt:, output: $stdout)
          client.realtime.connect(model: model) do |connection|
            configure(connection)
            send_prompt(connection, prompt)
            run_session(connection, output: output)
          end
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Timeout.timeout(Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))) do
    OpenAI::Examples::Realtime::FunctionCalling.run(
      client: OpenAI::Client.new,
      model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
      prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "What is the weather in Paris?")
    )
  end
end
