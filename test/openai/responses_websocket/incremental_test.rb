# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponsesWebSocketIncrementalTest < Minitest::Test
  def test_websocket_subclasses_share_sse_deltas_but_omitted_output_requires_normalization
    state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil)
    created = ws(type: "response.created", response: {id: "resp_test"})
    item = ws(type: "response.output_item.added", output_index: 0, item: message_item)

    assert_kind_of(OpenAI::Responses::ResponseCreatedEvent, created)
    assert_kind_of(OpenAI::Responses::ResponseOutputItemAddedEvent, item)
    state.handle_event(created)
    assert_raises(NoMethodError) { state.handle_event(item) }

    state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil)
    assert_raises(RuntimeError) { state.handle_event(delta) }
  end

  def test_provisional_text_and_tool_arguments_match_sse_without_owning_a_response
    preview = OpenAI::Responses::IncrementalResponse.new
    sse = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil)
    events = [
      ws(type: "response.created", response: {id: "resp_test", output: []}),
      ws(type: "response.output_item.added", output_index: 0, item: message_item),
      ws(
        type: "response.content_part.added",
        output_index: 0,
        content_index: 0,
        item_id: "msg_test",
        part: text_part
      ),
      delta(text: "Hel"),
      delta(text: "lo 🌍"),
      ws(
        type: "response.output_item.added",
        output_index: 1,
        item: {type: "function_call", id: "fc_test", call_id: "call_test", name: "tool", arguments: ""}
      ),
      ws(
        type: "response.function_call_arguments.delta",
        output_index: 1,
        item_id: "fc_test",
        delta: "{\"ok\":"
      ),
      ws(type: "response.function_call_arguments.delta", output_index: 1, item_id: "fc_test", delta: "true}")
    ]
    snapshots = events.map do |event|
      preview.add(event)
      sse.handle_event(event).first
    end

    assert_equal(:provisional, preview.phase)
    assert_equal(snapshots.fetch(4).snapshot, preview.output.fetch(0).content.fetch(0).text)
    assert_equal(snapshots.fetch(7).snapshot, preview.output.fetch(1).arguments)
    assert_equal("Hello 🌍", preview.output.fetch(0).content.fetch(0).text)
    assert_equal("{\"ok\":true}", preview.output.fetch(1).arguments)
    assert_empty(events.fetch(0).response.output)
    assert_empty(events.fetch(1).item.content)
    assert_nil(preview.terminal_event)
  end

  def test_preview_copies_input_and_snapshot_strings_and_replaces_corrected_items
    preview = OpenAI::Responses::IncrementalResponse.new
    created = ws(
      type: "response.created",
      response: {id: "resp_test", output: [message_item(content: [text_part(text: +"a"), text_part(text: "stale")])]}
    )
    preview.add(created)
    first = preview.output
    created.response.output.first.content.first.text.replace("incoming changed")
    first.first.content.first.text.replace("snapshot changed")
    preview.add(delta(text: "b"))
    assert_equal("ab", preview.output.first.content.first.text)

    preview.add(
      ws(
        type: "response.output_item.done",
        output_index: 0,
        item: message_item(id: "msg_corrected", content: [text_part(text: "c")])
      )
    )
    assert_equal(["c"], preview.output.first.content.map(&:text))
    preview.add(delta(item_id: "msg_corrected", text: "d"))
    assert_equal("cd", preview.output.first.content.first.text)
    preview.add(delta(item_id: "msg_test", text: "wrong old ID"))
    assert_equal(:unavailable, preview.phase)
    assert_nil(preview.output)
  end

  def test_text_done_replaces_partial_text_without_waiting_for_content_part_done
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(
      ws(
        type: "response.created",
        response: {id: "resp_test", output: [message_item(content: [text_part])]}
      )
    )
    preview.add(delta(text: "incorrect prefix"))
    before = preview.output
    done = ws(
      type: "response.output_text.done",
      item_id: "msg_test",
      output_index: 0,
      content_index: 0,
      text: +"corrected",
      logprobs: []
    )
    preview.add(done)
    assert_equal("corrected", preview.output.first.content.first.text)
    assert_equal("incorrect prefix", before.first.content.first.text)
    done.text.replace("changed raw value")
    assert_equal("corrected", preview.output.first.content.first.text)
    assert_equal(:provisional, preview.phase)
    assert_nil(preview.terminal_event)
  end

  def test_arguments_done_retains_empty_authoritative_arguments_before_item_done
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(ws(type: "response.created", response: {id: "resp_test", output: []}))
    preview.add(
      ws(
        type: "response.output_item.added",
        output_index: 0,
        item: {type: "function_call", id: "fc_test", call_id: "call_test", name: "never_run", arguments: ""}
      )
    )
    preview.add(
      ws(
        type: "response.function_call_arguments.delta",
        output_index: 0,
        item_id: "fc_test",
        delta: "{\"stale\":true}"
      )
    )
    before = preview.output
    preview.add(
      ws(
        type: "response.function_call_arguments.done",
        output_index: 0,
        item_id: "fc_test",
        arguments: ""
      )
    )
    assert_equal("", preview.output.first.arguments)
    assert_equal("{\"stale\":true}", before.first.arguments)
    assert_equal(:provisional, preview.phase)
    assert_nil(preview.terminal_event)
  end

  def test_missing_scaffolding_is_explicit_and_resets_at_the_next_created_event
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(delta)
    assert_equal(:unavailable, preview.phase)
    assert_nil(preview.output)

    preview.add(ws(type: "response.created", response: {id: "resp_next"}))
    assert_equal(:provisional, preview.phase)
    assert_empty(preview.output)
    preview.add(ws(type: "response.output_item.added", output_index: 0, item: message_item))
    preview.add(delta)
    assert_equal(:unavailable, preview.phase)
    preview.add(
      ws(
        type: "response.content_part.added",
        output_index: 0,
        content_index: 0,
        item_id: "msg_test",
        part: text_part
      )
    )
    assert_nil(preview.output)
    preview.reset
    assert_nil(preview.phase)
    assert_nil(preview.output)
  end

  def test_terminals_keep_exact_output_presence_and_never_promote_unfinished_deltas
    %w[completed failed incomplete].each do |status|
      [{}, {output: nil}, {output: []}].each do |output_field|
        preview = OpenAI::Responses::IncrementalResponse.new
        preview.add(
          ws(
            type: "response.created",
            response: {id: "resp_test", output: [message_item(content: [text_part])]}
          )
        )
        preview.add(delta(text: "unfinished"))
        event = ws(type: "response.#{status}", response: {id: "resp_test", status: status}.merge(output_field))
        wire = event.to_h
        preview.add(event)
        assert_equal(:terminal, preview.phase)
        assert_nil(preview.output)
        assert_equal(wire, preview.terminal_event.to_h)
        preview.add(delta(text: "late"))
        assert_equal(wire, preview.terminal_event.to_h)
        preview.reset
        assert_nil(preview.terminal_event)
      end
    end
  end

  def test_error_unknown_and_other_instances_cannot_overwrite_terminal_or_preview
    left = OpenAI::Responses::IncrementalResponse.new
    right = OpenAI::Responses::IncrementalResponse.new
    right.add(ws(type: "response.created", response: {id: "resp_right", output: []}))
    error = ws(type: "error", error: {type: "server_error", message: +"synthetic"})
    left.add(error)
    unknown = OpenAI::Responses::UnknownServerEvent.new(data: {type: "response.future", nested: {text: "opaque"}})
    left.add(unknown)
    right.add(unknown)
    assert_equal({text: "opaque"}, unknown.to_h[:nested])
    assert_equal(:terminal, left.phase)
    assert_equal(:provisional, right.phase)
    terminal = left.terminal_event
    error.error.message.replace("changed input")
    terminal.error.message.replace("changed output")
    assert_equal("synthetic", left.terminal_event.error.message)
  end

  private def ws(**data)
    OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Responses::ResponsesServerEvent,
      {sequence_number: 0, stream_id: "test"}.merge(data)
    )
  end

  private def message_item(id: "msg_test", content: [])
    {type: "message", id: id, role: "assistant", status: "in_progress", content: content}
  end

  private def text_part(text: "")
    {type: "output_text", text: text, annotations: [], logprobs: []}
  end

  private def delta(item_id: "msg_test", content_index: 0, text: "Hi")
    ws(
      type: "response.output_text.delta",
      item_id: item_id,
      output_index: 0,
      content_index: content_index,
      delta: text,
      logprobs: []
    )
  end
end
