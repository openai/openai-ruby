#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module MCPApproval
        SERVER_LABEL = "example_mcp"

        module_function

        def run(client:, model:, server_url:, prompt:, output: $stdout)
          client.realtime.connect(model: model) do |connection|
            configure(connection, server_url: server_url)
            state = initial_state

            connection.each do |event|
              handle_event(connection, event, prompt: prompt, state: state)
              break if state[:final_text]
            end

            unless state[:final_text]
              raise "Realtime connection closed before the MCP workflow completed."
            end

            output.puts("[realtime] MCP response.done status=completed")
            state.fetch(:final_text)
          end
        end

        def run_with_timeout(client:, model:, server_url:, prompt:, timeout_seconds:, output: $stdout)
          result = Timeout.timeout(timeout_seconds) do
            run(
              client: client,
              model: model,
              server_url: server_url,
              prompt: prompt,
              output: output
            )
          end

          output.puts("[realtime] MCP approval smoke test passed")
          result
        rescue OpenAI::Errors::RealtimeProtocolError
          raise RuntimeError, "Realtime protocol error.", cause: nil
        end

        def configure(connection, server_url:)
          connection.session.update(
            type: :realtime,
            output_modalities: [:text],
            parallel_tool_calls: false,
            tools: [
              {
                type: :mcp,
                server_label: SERVER_LABEL,
                server_url: server_url,
                require_approval: :always
              }
            ]
          )
        end

        def initial_state
          {
            discovery_events: {},
            discovery_items: {},
            selected_tool: nil,
            approval_request_id: nil,
            tool_call_item_id: nil,
            tool_call_response_id: nil,
            tool_call_item: nil,
            tool_completed: false,
            first_response_done: false,
            final_response_requested: false,
            final_text: nil
          }
        end

        def handle_event(connection, event, prompt:, state:)
          case event
          when OpenAI::Realtime::McpListToolsCompleted
            state[:discovery_events][event.item_id] = true
            select_tool(connection, prompt: prompt, state: state)
          when OpenAI::Realtime::ConversationItemDone
            handle_item(connection, event.item, prompt: prompt, state: state)
          when OpenAI::Realtime::McpListToolsFailed
            raise "Realtime MCP tool discovery failed."
          when OpenAI::Realtime::ResponseMcpCallArgumentsDone
            raise "Realtime returned more than one MCP tool call." if state[:tool_call_item_id]

            state[:tool_call_item_id] = event.item_id
            state[:tool_call_response_id] = event.response_id
            validate_tool_call(state)
          when OpenAI::Realtime::ResponseMcpCallCompleted
            unless event.item_id == state[:tool_call_item_id]
              raise "Realtime MCP completion did not match the requested tool call."
            end

            state[:tool_completed] = true
            request_final_response(connection, state: state)
          when OpenAI::Realtime::ResponseMcpCallFailed
            raise "Realtime MCP tool call failed."
          when OpenAI::Realtime::ResponseDoneEvent
            handle_response_done(connection, event, state: state)
          when OpenAI::Realtime::RealtimeErrorEvent
            raise "Realtime API error."
          end
        end

        def handle_item(connection, item, prompt:, state:)
          case item
          when OpenAI::Realtime::RealtimeMcpListTools
            state[:discovery_items][item.id] = item if item.id
            select_tool(connection, prompt: prompt, state: state)
          when OpenAI::Realtime::RealtimeMcpApprovalRequest
            selected_tool = state[:selected_tool]
            unless selected_tool && item.server_label == SERVER_LABEL && item.name == selected_tool.name
              raise "Realtime returned an unexpected MCP approval request."
            end

            if state[:approval_request_id]
              raise "Realtime returned more than one MCP approval request."
            end

            connection.conversation.items.create(
              type: :mcp_approval_response,
              id: "approval_response_1",
              approval_request_id: item.id,
              approve: true,
              reason: "Approved by the example application policy."
            )
            state[:approval_request_id] = item.id
            validate_tool_call(state)
            request_final_response(connection, state: state)
          when OpenAI::Realtime::RealtimeMcpToolCall
            raise "Realtime returned more than one finalized MCP tool call." if state[:tool_call_item]

            state[:tool_call_item] = item
            validate_tool_call(state)
            request_final_response(connection, state: state)
          end
        end

        def validate_tool_call(state)
          item = state[:tool_call_item]
          return unless item

          selected_tool = state[:selected_tool]
          unless selected_tool && item.server_label == SERVER_LABEL && item.name == selected_tool.name
            raise "Realtime returned an unexpected finalized MCP tool call."
          end

          item_id = state[:tool_call_item_id]
          if item_id && item.id != item_id
            raise "Realtime MCP tool call did not match the requested tool call."
          end

          approval_request_id = state[:approval_request_id]
          return unless approval_request_id
          return if item.approval_request_id == approval_request_id

          raise "Realtime MCP tool call did not match the approved request."
        end

        def select_tool(connection, prompt:, state:)
          return if state[:selected_tool]

          item_id = state[:discovery_events].keys.find { state[:discovery_items].key?(_1) }
          return unless item_id

          tool_list = state[:discovery_items].fetch(item_id)
          unless tool_list.server_label == SERVER_LABEL
            raise "Realtime returned tools for an unexpected MCP server."
          end

          raise "Realtime MCP server returned no tools." if tool_list.tools.empty?

          selected_tool = tool_list.tools.fetch(0)
          state[:selected_tool] = selected_tool
          connection.conversation.items.create(
            type: :message,
            role: :user,
            content: [{type: :input_text, text: prompt}]
          )
          connection.response.create(
            tool_choice: {type: :mcp, server_label: tool_list.server_label, name: selected_tool.name}
          )
        end

        def handle_response_done(connection, event, state:)
          raise "Realtime response did not complete." unless event.response.status == :completed

          if state[:final_response_requested]
            text = completed_text(event.response)
            raise "Realtime final MCP response completed without text output." if text.strip.empty?

            state[:final_text] = text
            return
          end

          unless state[:tool_call_item_id]
            raise "Realtime response completed before the MCP tool call."
          end

          unless event.response.id == state[:tool_call_response_id]
            raise "Realtime MCP tool call did not match response.done."
          end

          state[:first_response_done] = true
          request_final_response(connection, state: state)
        end

        def request_final_response(connection, state:)
          return if state[:final_response_requested]
          unless state[:first_response_done] &&
              state[:approval_request_id] &&
              state[:tool_call_item] &&
              state[:tool_completed]
            return
          end

          connection.response.create(tool_choice: :none)
          state[:final_response_requested] = true
        end

        def completed_text(response)
          Array(response.output)
            .filter_map do |item|
              next unless item.is_a?(OpenAI::Realtime::RealtimeConversationItemAssistantMessage)

              item.content.filter_map { |content| content.text if content.type == :output_text }.join
            end
            .join
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  OpenAI::Examples::Realtime::MCPApproval.run_with_timeout(
    client: OpenAI::Client.new,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
    server_url: ENV.fetch("MCP_SERVER_URL"),
    prompt: ENV.fetch("OPENAI_REALTIME_PROMPT", "Use the configured MCP server."),
    timeout_seconds: Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "60"))
  )
end
