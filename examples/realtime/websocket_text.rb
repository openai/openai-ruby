#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require_relative "../../lib/openai"
require_relative "event_stream"

module OpenAI
  module Examples
    module Realtime
      module WebSocketText
        module_function

        def stream_response(connection, output: $stdout)
          started_response = false
          EventStream.each_until(connection, stop_after: "response.done") do |event|
            case event
            when OpenAI::Realtime::SessionCreatedEvent
              output.puts("[realtime] session.created")
            when OpenAI::Realtime::SessionUpdatedEvent
              output.puts("[realtime] session.updated")
            when OpenAI::Realtime::ResponseTextDeltaEvent
              output.print("[assistant] ") unless started_response
              started_response = true
              output.print(event.delta)
              output.flush
            when OpenAI::Realtime::ResponseDoneEvent
              output.puts if started_response
              status = event.response.status
              raise "Realtime response ended with status #{status.inspect}" unless status == :completed

              output.puts("[realtime] response.done status=completed")
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error: #{event.error.message}"
            end
          end
        end

        def run(client:, model:, prompt:, output: $stdout)
          session = {
            type: :realtime,
            output_modalities: [:text],
            instructions: "Be concise and friendly."
          }
          item = {
            type: :message,
            role: :user,
            content: [{type: :input_text, text: prompt}]
          }

          output.puts("[realtime] connecting with #{model}")
          client.realtime.connect(model: model) do |connection|
            output.puts("[realtime] connected; sending prompt: #{prompt.inspect}")
            connection.session.update(**session)
            connection.conversation.items.create(**item)
            connection.response.create
            stream_response(connection, output: output)
          end
          output.puts("[realtime] smoke test passed")
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Timeout.timeout(Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))) do
    OpenAI::Examples::Realtime::WebSocketText.run(
      client: OpenAI::Client.new,
      model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
      prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "Say hello from Ruby.")
    )
  end
end
