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

      def session_limits
        # Application budgets for these short text examples, not service limits.
        OpenAI::Responses::SessionLimits.new(
          max_lanes: 8,
          max_events_per_lane: 128,
          max_events: 512,
          max_bytes_per_lane: 16 * 1024 * 1024,
          max_bytes: 32 * 1024 * 1024,
          max_response_bytes: 64 * 1024 * 1024
        )
      end

      def multiplex(client:, model:)
        OpenAI::Responses::Session.open(client: client, limits: session_limits) do |session|
          lanes = %w[planner critic].to_h { |name| [name, session.lane(name)] }
          lanes.each_value do |lane|
            lane.send_event(
              type: :"response.create",
              model: model,
              input: "Say hello as the #{lane.stream_id}.",
              store: false
            )
          end

          results = Thread::Queue.new
          readers = []
          begin
            readers <<
              Async::Task.current.async do
                loop do
                  event = session.default.receive
                  next unless event.type.to_s == "error"

                  results.push(OpenAI::Responses::RequestError.new(event))
                  break
                end

              rescue StandardError
                # Named readers report connection failure, or drain terminal
                # responses already queued before a normal connection close.
                nil
              end
            lanes.each do |name, lane|
              readers <<
                Async::Task.current.async do
                  response = lane.get_final_response
                  unless response.status.to_s == "completed"
                    raise("Responses WebSocket operation did not complete.")
                  end

                  results.push([name, response])
                rescue StandardError => error
                  results.push(error)
                end
            end

            lanes.length.times.to_h do
              result = results.pop
              raise result if result.is_a?(StandardError)

              result
            end

          ensure
            readers.each(&:stop)
            readers.each(&:wait)
          end
        end

      rescue OpenAI::Responses::RequestError
        raise "Responses WebSocket operation did not complete."
      rescue OpenAI::Responses::SessionError
        raise "Responses WebSocket closed with unfinished work."
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
