#!/usr/bin/env ruby
# frozen_string_literal: true

require "async"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module ResponsesWebSocketWorkflows
      module_function

      # One reader drains all requested lanes. This example fails the entire
      # operation on an error; applications can instead isolate lane-scoped errors.
      def completed_responses(connection, lanes: [nil])
        pending = lanes.dup
        responses = {}
        connection.each do |event|
          case event.type.to_s
          when "response.completed"
            next unless pending.include?(event.stream_id)

            responses[event.stream_id] = event.response
            pending.delete(event.stream_id)
            break if pending.empty?
          when "response.failed", "response.incomplete", "error"
            raise "Responses WebSocket operation did not complete."
          end
        end

        raise "Responses WebSocket closed with unfinished work." unless pending.empty?

        responses
      end

      def tools(client:, model:)
        client.responses.connect do |connection|
          connection.response.create(
            model: model,
            input: "What day will my example delivery arrive?",
            tools: [
              {
                type: :function,
                name: "get_delivery_day",
                description: "Return the day of the example delivery.",
                parameters: {type: :object, properties: {}, required: [], additionalProperties: false},
                strict: true
              }
            ],
            tool_choice: {type: :function, name: "get_delivery_day"},
            parallel_tool_calls: false,
            store: false
          )
          first = completed_responses(connection).fetch(nil)
          calls = first.output.select { |item| item.type.to_s == "function_call" }
          unless calls.length == 1 && calls.first.name == "get_delivery_day"
            raise "Expected the example delivery tool call."
          end

          # Execute only this application's known tool. Never eval model output.
          connection.response.create(
            model: model,
            previous_response_id: first.id,
            input: [{type: :function_call_output, call_id: calls.first.call_id, output: "Tuesday"}],
            store: false
          )
          completed_responses(connection)
        end
      end

      def multiplex(client:, model:)
        client.responses.connect do |connection|
          %w[planner critic].each do |lane|
            connection.response.create(
              model: model,
              input: "Say hello as the #{lane}.",
              stream_id: lane,
              store: false
            )
          end

          completed_responses(connection, lanes: %w[planner critic])
        end
      end

      # Deliberately rotate a healthy connection after a completed turn. This does
      # not retry a failed write or assume an unfinished response was accepted.
      def reconnect(client:, model:, store:)
        input = [{role: :user, content: "Remember the example delivery day: Tuesday."}]
        first = client.responses.connect do |connection|
          connection.response.create(
            model: model,
            input: input,
            store: store,
            include: ["reasoning.encrypted_content"]
          )
          completed_responses(connection).fetch(nil)
        end

        follow_up = {role: :user, content: "What is the example delivery day?"}
        client.responses.connect do |connection|
          if store
            connection.response.create(
              model: model,
              input: [follow_up],
              previous_response_id: first.id,
              store: true
            )
          else
            # Preserve every output item, including encrypted reasoning. The new
            # connection cannot use the old connection's store=false cache.
            connection.response.create(
              model: model,
              input: input + first.output + [follow_up],
              store: false
            )
          end

          completed_responses(connection)
        end
      end

      def run(client:, model:, workflow:, timeout: 60, output: $stdout)
        Sync do |task|
          task.with_timeout(timeout) do
            case workflow
            when "tools"
              tools(client: client, model: model)
            when "multiplex"
              multiplex(client: client, model: model)
            when "stored"
              reconnect(client: client, model: model, store: true)
            when "stateless"
              reconnect(client: client, model: model, store: false)
            else
              raise ArgumentError, "Choose tools, multiplex, stored, or stateless."
            end
          end
        end

        output.puts("Responses WebSocket workflow completed.")
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  begin
    OpenAI::Examples::ResponsesWebSocketWorkflows.run(
      client: OpenAI::Client.new,
      model: ENV.fetch("OPENAI_RESPONSES_MODEL", "gpt-5.2"),
      workflow: ARGV.fetch(0, "multiplex"),
      timeout: Float(ENV.fetch("OPENAI_RESPONSES_TIMEOUT", "60"))
    )
  rescue StandardError
    warn("Responses WebSocket workflow failed; no request or response contents were logged.")
    exit(1)
  end
end
