#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"
require "timeout"

module OpenAI
  module Examples
    module Realtime
      module MCPApproval
        module_function

        def configure(connection, server_url:)
          connection.session.update(
            type: :realtime,
            output_modalities: [:text],
            tools: [
              {
                type: :mcp,
                server_label: "remote",
                server_url: server_url,
                require_approval: :always
              }
            ],
            parallel_tool_calls: false
          )
        end

        def send_prompt(connection, prompt:, tool_choice:)
          connection.conversation.items.create(
            type: :message,
            role: :user,
            content: [{type: :input_text, text: prompt}]
          )
          connection.response.create(tool_choice: tool_choice)
        end

        def approve_request(connection, item)
          connection.conversation.items.respond_to_mcp_approval(
            approval_request_id: item.id,
            approve: true,
            reason: "Approved by the application policy"
          )
        end

        def run_session(connection, prompt:, output: $stdout, debug: false)
          completed = false
          state = {
            completed_item_ids: {},
            tool_lists: {},
            selected_tool: false,
            final_text_received: false,
            mcp_phase: :idle
          }

          connection.each do |event|
            output.puts("[mcp event] #{event.type}") if debug
            if handle_event(connection, event, output: output, state: state) == :done
              completed = true
              break
            end

            select_discovered_tool(
              connection,
              prompt: prompt,
              output: output,
              state: state
            )
          end
          return if completed

          raise "Realtime connection closed before the final response.done"
        end

        def handle_event(connection, event, output:, state:)
          case event
          when OpenAI::Realtime::McpListToolsCompleted
            state[:completed_item_ids][event.item_id] = true
          when OpenAI::Realtime::ConversationItemDone
            handle_conversation_item(connection, event.item, output: output, state: state)
          when OpenAI::Realtime::McpListToolsFailed
            raise "MCP tool discovery failed for #{event.item_id}"
          when OpenAI::Realtime::ResponseMcpCallArgumentsDone
            state[:mcp_phase] = :tool_pending
            output.puts("[mcp] tool call requested")
          when OpenAI::Realtime::ResponseMcpCallCompleted
            handle_tool_completed(connection, output: output, state: state)
          when OpenAI::Realtime::ResponseMcpCallFailed
            raise "MCP tool call failed for #{event.item_id}"
          when OpenAI::Realtime::RealtimeErrorEvent
            raise event.error.message
          when OpenAI::Realtime::ResponseTextDeltaEvent
            if state[:mcp_phase] == :final_response_pending && !event.delta.empty?
              state[:final_text_received] = true
            end
            output.print(event.delta)
            output.flush
          when OpenAI::Realtime::ResponseDoneEvent
            handle_response_done(connection, event, output: output, state: state)
          end
        end

        def handle_conversation_item(connection, item, output:, state:)
          if item.is_a?(OpenAI::Realtime::RealtimeMcpListTools)
            state[:tool_lists][item.id] = item
          elsif item.is_a?(OpenAI::Realtime::RealtimeMcpApprovalRequest)
            output.puts("[mcp] approving #{item.id}")
            approve_request(connection, item)
          end
        end

        def handle_tool_completed(connection, output:, state:)
          output.puts("[mcp] tool call completed")
          if state[:mcp_phase] == :response_done
            request_final_response(connection, state: state)
          else
            state[:mcp_phase] = :tool_completed
          end
        end

        def handle_response_done(connection, event, output:, state:)
          raise "Response ended with #{event.response.status}" unless event.response.status == :completed

          case state[:mcp_phase]
          when :tool_pending
            state[:mcp_phase] = :response_done
            output.puts("[mcp] waiting for approval and tool execution")
          when :tool_completed
            request_final_response(connection, state: state)
          when :final_response_pending
            raise "Final MCP response completed without text output" unless state[:final_text_received]

            output.puts("\n[mcp] response.done status=completed")
            :done
          when :idle
            raise "Response completed without an MCP tool call"
          end
        end

        def request_final_response(connection, state:)
          connection.response.create(tool_choice: :none)
          state[:mcp_phase] = :final_response_pending
        end

        def select_discovered_tool(connection, prompt:, output:, state:)
          return if state[:selected_tool]

          tool_list = state[:tool_lists].values.find { |item| state[:completed_item_ids][item.id] }
          return unless tool_list
          raise "The MCP server imported no tools" if tool_list.tools.empty?

          tool_names = tool_list.tools.map(&:name)
          output.puts("[mcp] tools discovered: #{tool_names.join(', ')}")
          send_prompt(
            connection,
            prompt: prompt,
            tool_choice: {
              type: :mcp,
              server_label: tool_list.server_label,
              name: tool_names.fetch(0)
            }
          )
          state[:selected_tool] = true
        end

        def run(client:, model:, server_url:, prompt:, output: $stdout, debug: false)
          client.realtime.connect(model: model) do |connection|
            configure(connection, server_url: server_url)
            run_session(connection, prompt: prompt, output: output, debug: debug)
          end
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  client = OpenAI::Client.new
  timeout = Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "60"))

  Timeout.timeout(timeout) do
    OpenAI::Examples::Realtime::MCPApproval.run(
      client: client,
      model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
      server_url: ENV.fetch("MCP_SERVER_URL"),
      prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "Use the configured MCP server."),
      debug: ENV["OPENAI_REALTIME_DEBUG"] == "1"
    )
  end
end
