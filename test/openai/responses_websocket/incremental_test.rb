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

  def test_text_logprobs_follow_deltas_and_done_without_mutating_raw_or_prior_snapshots
    preview = OpenAI::Responses::IncrementalResponse.new
    created = ws(
      type: "response.created",
      response: {id: "resp_test", output: [message_item(content: [text_part])]}
    )
    preview.add(created)
    left = ws(
      type: "response.output_text.delta",
      output_index: 0,
      content_index: 0,
      item_id: "msg_test",
      delta: "one ",
      logprobs: [{token: +"one", logprob: -0.1, top_logprobs: []}]
    )
    preview.add(left)
    before = preview.output
    assert_equal(["one"], before.first.content.first.logprobs.map(&:token))
    left.logprobs.first.token.replace("raw change")
    preview.add(
      ws(
        type: "response.output_text.delta",
        output_index: 0,
        content_index: 0,
        item_id: "msg_test",
        delta: "two",
        logprobs: [{token: "two", logprob: -0.2, top_logprobs: []}]
      )
    )
    assert_equal(%w[one two], preview.output.first.content.first.logprobs.map(&:token))
    assert_equal(["one"], before.first.content.first.logprobs.map(&:token))
    done = ws(
      type: "response.output_text.done",
      output_index: 0,
      content_index: 0,
      item_id: "msg_test",
      text: "fixed",
      logprobs: [{token: +"fixed", logprob: -0.3, top_logprobs: []}]
    )
    preview.add(done)
    done.logprobs.first.token.replace("raw done change")
    after = preview.output
    assert_equal("fixed", after.first.content.first.text)
    assert_equal(["fixed"], after.first.content.first.logprobs.map(&:token))
    assert_empty(created.response.output.first.content.first.logprobs)
    preview.add(
      ws(
        type: "response.output_text.done",
        output_index: 0,
        content_index: 0,
        item_id: "msg_test",
        text: "no logprobs",
        logprobs: []
      )
    )
    assert_empty(preview.output.first.content.first.logprobs)
    assert_equal(["fixed"], after.first.content.first.logprobs.map(&:token))
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

  def test_custom_tool_input_is_visible_before_item_done_and_remains_data
    preview = OpenAI::Responses::IncrementalResponse.new
    created = ws(
      type: "response.created",
      response: {
        id: "resp_test",
        output: [
          {
            type: "custom_tool_call",
            id: "ct_test",
            status: "in_progress",
            call_id: "call_test",
            name: "never_run",
            input: ""
          }
        ]
      }
    )
    preview.add(created)
    input = ws(type: "response.custom_tool_call_input.delta", output_index: 0, item_id: "ct_test", delta: +"code")
    preview.add(input)
    before = preview.output
    assert_equal("code", before.first.input)
    input.delta.replace("raw change")
    preview.add(ws(type: "response.custom_tool_call_input.delta", output_index: 0, item_id: "ct_test", delta: " more"))
    assert_equal("code more", preview.output.first.input)
    done = ws(type: "response.custom_tool_call_input.done", output_index: 0, item_id: "ct_test", input: "")
    preview.add(done)
    assert_equal("", preview.output.first.input)
    assert_equal("code", before.first.input)
    assert_equal("", created.response.output.first.input)
    assert_equal(:provisional, preview.phase)
    assert_nil(preview.terminal_event)
  end

  def test_refusal_deltas_and_done_correct_a_preview_before_part_done
    preview = OpenAI::Responses::IncrementalResponse.new
    created = ws(
      type: "response.created",
      response: {id: "resp_test", output: [message_item(content: [{type: "refusal", refusal: ""}])]}
    )
    preview.add(created)
    received = ws(type: "response.refusal.delta", output_index: 0, content_index: 0, item_id: "msg_test", delta: +"No")
    preview.add(received)
    before = preview.output
    assert_equal("No", before.first.content.first.refusal)
    received.delta.replace("raw change")
    preview.add(
      ws(type: "response.refusal.delta", output_index: 0, content_index: 0, item_id: "msg_test", delta: " longer")
    )
    assert_equal("No longer", preview.output.first.content.first.refusal)
    done = ws(
      type: "response.refusal.done",
      output_index: 0,
      content_index: 0,
      item_id: "msg_test",
      refusal: +"Declined"
    )
    preview.add(done)
    done.refusal.replace("raw done change")
    assert_equal("Declined", preview.output.first.content.first.refusal)
    assert_equal("No", before.first.content.first.refusal)
    assert_equal("", created.response.output.first.content.first.refusal)
    assert_nil(preview.terminal_event)
  end

  def test_text_annotations_are_typed_visible_and_isolated_when_they_arrive
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(
      ws(
        type: "response.created",
        response: {id: "resp_test", output: [message_item(content: [text_part(text: "Source")])]}
      )
    )
    preview.add(
      ws(
        type: "response.output_text.annotation.added",
        output_index: 0,
        content_index: 0,
        item_id: "msg_test",
        annotation_index: 0,
        annotation: {type: "url_citation", start_index: 0, end_index: 6, title: +"Source", url: "https://example.test"}
      )
    )
    before = preview.output
    annotation = before.first.content.first.annotations.fetch(0)
    assert_kind_of(OpenAI::Responses::ResponseOutputText::Annotation::URLCitation, annotation)
    assert_equal("Source", annotation.title)
    annotation.title.replace("snapshot change")
    received = ws(
      type: "response.output_text.annotation.added",
      output_index: 0,
      content_index: 0,
      item_id: "msg_test",
      annotation_index: 1,
      annotation: {type: "file_citation", index: 1, filename: +"source.txt", file_id: "file_synthetic"}
    )
    preview.add(received)
    received.annotation.filename.replace("raw change")
    snapshot = preview.output
    assert_equal(
      %w[Source source.txt],
      [
        snapshot.first.content.first.annotations.fetch(0).title,
        snapshot.first.content.first.annotations.fetch(1).filename
      ]
    )
    assert_equal("Source", snapshot.first.content.first.text)
    assert_equal(:provisional, preview.phase)
    assert_nil(preview.terminal_event)
  end

  def test_missing_and_invalid_scaffolds_cannot_produce_custom_refusal_or_annotation_output
    cases = [
      {type: "response.custom_tool_call_input.delta", output_index: 0, item_id: "msg_test", delta: "wrong kind"},
      {type: "response.custom_tool_call_input.done", output_index: 1, item_id: "ct_missing", input: "missing"},
      {type: "response.custom_tool_call_input.done", output_index: "bad", item_id: "ct_missing", input: "invalid"},
      {type: "response.refusal.delta", output_index: 0, content_index: 0, item_id: "msg_test", delta: "wrong part"},
      {type: "response.refusal.done", output_index: 0, content_index: 1, item_id: "msg_test", refusal: "missing"},
      {type: "response.refusal.done", output_index: 0, content_index: "bad", item_id: "msg_test", refusal: "invalid"},
      {
        type: "response.output_text.annotation.added",
        output_index: 0,
        content_index: 0,
        item_id: "msg_test",
        annotation_index: 2,
        annotation: {type: "file_path", index: 0, file_id: "file_missing"}
      },
      {
        type: "response.output_text.annotation.added",
        output_index: 0,
        content_index: 0,
        item_id: "msg_test",
        annotation_index: 0,
        annotation: nil
      }
    ]
    cases.each do |data|
      preview = OpenAI::Responses::IncrementalResponse.new
      preview.add(
        ws(type: "response.created", response: {id: "resp_test", output: [message_item(content: [text_part])]})
      )
      received = ws(**data)
      original = received.to_h
      preview.add(received)
      assert_equal(:unavailable, preview.phase, data[:type])
      assert_nil(preview.output)
      assert_equal(original, received.to_h)
      terminal = ws(type: "response.incomplete", response: {id: "resp_test"})
      preview.add(terminal)
      assert_equal(terminal.to_h, preview.terminal_event.to_h)
    end
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
