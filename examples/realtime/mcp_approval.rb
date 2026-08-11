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
            ]
          )
        end

        def select_tool(connection, server_label:, tool_name:)
          connection.session.update(
            type: :realtime,
            tools: [{type: :mcp, server_label: server_label}],
            tool_choice: {type: :mcp, server_label: server_label, name: tool_name}
          )
        end

        def send_prompt(connection, prompt:)
          connection.conversation.items.create(
            type: :message,
            role: :user,
            content: [{type: :input_text, text: prompt}]
          )
          connection.response.create
        end

        def approve_request(connection, item)
          connection.conversation.items.respond_to_mcp_approval(
            approval_request_id: item.id,
            approve: true,
            reason: "Approved by the application policy"
          )
        end

        def run_session(connection, prompt:, output: $stdout, debug: false)
          state = {
            completed_item_ids: {},
            tool_lists: {},
            waiting_for_tool_update: false,
            selected_tool: false,
            mcp_call_pending: false
          }

          connection.each do |event|
            output.puts("[mcp event] #{event.type}") if debug
            break if handle_event(connection, event, prompt: prompt, output: output, state: state) == :done

            select_discovered_tool(connection, output: output, state: state)
          end
        end

        def handle_event(connection, event, prompt:, output:, state:)
          case event
          when OpenAI::Realtime::McpListToolsCompleted
            state[:completed_item_ids][event.item_id] = true
          when OpenAI::Realtime::SessionUpdatedEvent
            handle_session_updated(connection, prompt: prompt, state: state)
          when OpenAI::Realtime::ConversationItemDone
            handle_conversation_item(connection, event.item, output: output, state: state)
          when OpenAI::Realtime::McpListToolsFailed
            raise "MCP tool discovery failed for #{event.item_id}"
          when OpenAI::Realtime::ResponseMcpCallArgumentsDone
            state[:mcp_call_pending] = true
            output.puts("[mcp] tool call requested")
          when OpenAI::Realtime::ResponseMcpCallCompleted
            handle_tool_completed(connection, output: output, state: state)
          when OpenAI::Realtime::ResponseMcpCallFailed
            raise "MCP tool call failed for #{event.item_id}"
          when OpenAI::Realtime::RealtimeErrorEvent
            raise event.error.message
          when OpenAI::Realtime::ResponseTextDeltaEvent
            output.print(event.delta)
            output.flush
          when OpenAI::Realtime::ResponseDoneEvent
            handle_response_done(event, output: output, state: state)
          end
        end

        def handle_session_updated(connection, prompt:, state:)
          return unless state[:waiting_for_tool_update]

          send_prompt(connection, prompt: prompt)
          state[:waiting_for_tool_update] = false
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
          state[:mcp_call_pending] = false
          output.puts("[mcp] tool call completed")
          connection.response.create(tool_choice: :none)
        end

        def handle_response_done(event, output:, state:)
          raise "Response ended with #{event.response.status}" unless event.response.status == :completed

          if state[:mcp_call_pending]
            output.puts("[mcp] waiting for approval and tool execution")
          else
            output.puts("\n[mcp] response.done status=completed")
            :done
          end
        end

        def select_discovered_tool(connection, output:, state:)
          return if state[:selected_tool]

          tool_list = state[:tool_lists].values.find { |item| state[:completed_item_ids][item.id] }
          return unless tool_list
          raise "The MCP server imported no tools" if tool_list.tools.empty?

          tool_names = tool_list.tools.map(&:name)
          output.puts("[mcp] tools discovered: #{tool_names.join(', ')}")
          select_tool(connection, server_label: tool_list.server_label, tool_name: tool_names.fetch(0))
          state[:selected_tool] = true
          state[:waiting_for_tool_update] = true
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
