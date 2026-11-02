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

  def test_mcp_argument_delta_and_done_preserve_detached_provisional_output
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(ws(type: "response.created", response: mcp_response))
    added = ws(
      type: "response.output_item.added",
      output_index: 0,
      item: {
        type: "mcp_call",
        id: "mcp_test",
        name: "never_run",
        server_label: "synthetic",
        arguments: +"{\"seed\":",
        status: "in_progress"
      }
    )
    preview.add(added)
    before = preview.output
    update = ws(type: "response.mcp_call_arguments.delta", output_index: 0, item_id: "mcp_test", delta: +"true}")
    assert_kind_of(OpenAI::Responses::ResponseMcpCallArgumentsDeltaEvent, update)
    preview.add(update)
    assert_equal(:provisional, preview.phase)
    assert_equal("{\"seed\":true}", preview.output.first.arguments)
    assert_equal("{\"seed\":", before.first.arguments)
    assert_equal("{\"seed\":", added.item.arguments)
    assert_equal("true}", update.delta)

    before_done = preview.output
    done = ws(
      type: "response.mcp_call_arguments.done",
      output_index: 0,
      item_id: "mcp_test",
      arguments: +"{\"corrected\":true}"
    )
    assert_kind_of(OpenAI::Responses::ResponseMcpCallArgumentsDoneEvent, done)
    preview.add(done)
    assert_equal(:provisional, preview.phase)
    assert_equal("{\"corrected\":true}", preview.output.first.arguments)
    assert_equal(added.item.to_h.merge(arguments: "{\"corrected\":true}"), preview.output.first.to_h)
    assert_equal("{\"seed\":true}", before_done.first.arguments)
    done.arguments.replace("changed event")
    detached = preview.output
    detached.first.arguments.replace("changed snapshot")
    assert_equal("{\"corrected\":true}", preview.output.first.arguments)
    assert_nil(preview.terminal_event)
  end

  def test_mcp_argument_done_replaces_seed_without_a_delta
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(
      ws(
        type: "response.created",
        response: mcp_response(output: [mcp_item(arguments: "{\"seed\":true}")])
      )
    )
    preview.add(ws(type: "response.mcp_call_arguments.done", output_index: 0, item_id: "mcp_test", arguments: ""))
    assert_equal(:provisional, preview.phase)
    assert_equal("", preview.output.first.arguments)
  end

  def test_mcp_full_item_and_terminal_replace_provisional_arguments
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(ws(type: "response.created", response: mcp_response(output: [mcp_item(arguments: "{\"seed\":")])))
    preview.add(ws(type: "response.mcp_call_arguments.delta", output_index: 0, item_id: "mcp_test", delta: "true}"))
    preview.add(
      ws(type: "response.mcp_call_arguments.done", output_index: 0, item_id: "mcp_test", arguments: "{\"done\":true}")
    )
    preview.add(
      ws(
        type: "response.output_item.done",
        output_index: 0,
        item: mcp_item(arguments: "{\"item\":true}", status: "completed")
      )
    )
    assert_equal(:provisional, preview.phase)
    assert_equal("{\"item\":true}", preview.output.first.arguments)
    terminal = ws(
      type: "response.completed",
      response: mcp_response(
        output: [mcp_item(arguments: "{\"terminal\":true}", status: "completed")],
        status: "completed"
      )
    )
    preview.add(terminal)
    assert_equal(:terminal, preview.phase)
    assert_nil(preview.output)
    assert_equal(terminal.to_h, preview.terminal_event.to_h)
    preview.add(ws(type: "response.mcp_call_arguments.delta", output_index: 0, item_id: "mcp_test", delta: "late"))
    preview.add(ws(type: "response.mcp_call_arguments.done", output_index: 0, item_id: "mcp_test", arguments: "late"))
    assert_equal(:terminal, preview.phase)
    assert_nil(preview.output)
    assert_equal(terminal.to_h, preview.terminal_event.to_h)
  end

  def test_mcp_arguments_require_current_matching_item_scaffolding
    %w[delta done].each do |suffix|
      [
        [[message_item], 0, "msg_test"],
        [[mcp_item], 0, "stale_id"],
        [[mcp_item], 1, "mcp_test"],
        [[mcp_item], -1, "mcp_test"]
      ].each do |output, index, item_id|
        preview = OpenAI::Responses::IncrementalResponse.new
        preview.add(ws(type: "response.created", response: mcp_response(output: output))) unless output.nil?
        payload = suffix == "delta" ? {delta: "true}"} : {arguments: "{\"done\":true}"}
        preview.add(ws(type: "response.mcp_call_arguments.#{suffix}", output_index: index, item_id: item_id, **payload))
        assert_equal(:unavailable, preview.phase)
        assert_nil(preview.output)
      end
    end
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
      {type: "response.custom_tool_call_input.done", output_index: "bad", item_id: "ct_missing", input: "invalid"},
      {type: "response.refusal.delta", output_index: 0, content_index: 0, item_id: "msg_test", delta: "wrong part"},
      {type: "response.refusal.done", output_index: 0, content_index: "bad", item_id: "msg_test", refusal: "invalid"},
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

  def test_sparse_observations_reset_at_the_next_created_event
    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(delta)
    assert_equal(:provisional, preview.phase)
    assert_empty(preview.output)
    assert_equal("Hi", preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:part).fetch(:text))

    preview.add(ws(type: "response.created", response: {id: "resp_next", output: [message_item(content: [text_part])]}))
    assert_equal(:provisional, preview.phase)
    assert_empty(preview.output.first.content.first.text)
    preview.add(delta)
    assert_equal("Hi", preview.output.first.content.first.text)
    preview.reset
    assert_nil(preview.phase)
    assert_nil(preview.output)
    assert_nil(preview.detailed_snapshot)
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

  {
    "code_interpreter_call" => %w[in_progress interpreting completed],
    "file_search_call" => %w[in_progress searching completed],
    "web_search_call" => %w[in_progress searching completed],
    "image_generation_call" => %w[in_progress generating completed],
    "mcp_call" => %w[in_progress completed failed]
  }.each do |kind, statuses|
    statuses.each do |status|
      define_method("test_rich_#{kind}_#{status}") do
        preview = OpenAI::Responses::IncrementalResponse.new
        item = rich_item(kind)
        preview.add(ws(type: "response.created", response: rich_response(output: [item])))
        before = preview.output
        event = ws(type: "response.#{kind}.#{status}", output_index: 0, item_id: "item")
        original = event.to_h
        preview.add(event)
        assert_equal(:provisional, preview.phase)
        assert_equal(status.to_sym, preview.output.first.status)
        if item.key?(:status)
          assert_equal(item[:status].to_sym, before.first.status)
        else
          assert_nil(before.first.status)
        end

        assert_equal(original, event.to_h)
      end
    end
  end

  [
    ["code_interpreter_call_code.delta", "code_interpreter_call", {delta: " suffix"}, [:code], "seed suffix"],
    ["code_interpreter_call_code.done", "code_interpreter_call", {code: "corrected"}, [:code], "corrected"],
    [
      "reasoning_summary_part.added",
      "reasoning",
      {summary_index: 1, part: {type: "summary_text", text: "new"}},
      [:summary, 1, :text],
      "new"
    ],
    [
      "reasoning_summary_part.done",
      "reasoning",
      {summary_index: 0, part: {type: "summary_text", text: "corrected"}},
      [:summary, 0, :text],
      "corrected"
    ],
    [
      "reasoning_summary_text.delta",
      "reasoning",
      {summary_index: 0, delta: " suffix"},
      [:summary, 0, :text],
      "seed suffix"
    ],
    [
      "reasoning_summary_text.done",
      "reasoning",
      {summary_index: 0, text: "corrected"},
      [:summary, 0, :text],
      "corrected"
    ],
    ["reasoning_text.delta", "reasoning", {content_index: 0, delta: " suffix"}, [:content, 0, :text], "seed suffix"],
    ["reasoning_text.done", "reasoning", {content_index: 0, text: "corrected"}, [:content, 0, :text], "corrected"],
    ["shell_call_command.added", "shell_call", {command_index: 1, command: "new"}, [:action, :commands, 1], "new"],
    [
      "shell_call_command.delta",
      "shell_call",
      {command_index: 0, delta: " suffix"},
      [:action, :commands, 0],
      "seed suffix"
    ],
    [
      "shell_call_command.done",
      "shell_call",
      {command_index: 0, command: "corrected"},
      [:action, :commands, 0],
      "corrected"
    ]
  ].each do |type, kind, payload, path, expected|
    define_method("test_rich_#{type.tr(".", "_")}") do
      preview = OpenAI::Responses::IncrementalResponse.new
      preview.add(ws(type: "response.created", response: rich_response(output: [rich_item(kind)])))
      before = preview.output
      identity = type.start_with?("shell_call_command") ? {} : {item_id: "item"}
      event = ws(type: "response.#{type}", output_index: 0, **identity, **payload)
      original = event.to_h
      preview.add(event)
      assert_equal(:provisional, preview.phase)
      value = path.reduce(preview.output.first) { |part, key| part[key] }
      assert_equal(expected, value)
      refute_equal(expected, path.reduce(before.first) { |part, key| part&.[](key) })
      assert_equal(original, event.to_h)
    end
  end

  %w[delta done].each do |suffix|
    define_method("test_rich_shell_output_#{suffix}_preserves_command_facts") do
      preview = OpenAI::Responses::IncrementalResponse.new
      preview.add(ws(type: "response.created", response: rich_response(output: [rich_item("shell_call_output")])))
      chunks = [
        {
          stdout: "first",
          stderr: "",
          outcome: {type: "exit", exit_code: 7},
          created_by: "actor-a",
          opaque: {value: "a"}
        },
        {stdout: "second", stderr: "warn", outcome: {type: "timeout"}, created_by: "actor-b"}
      ]
      payload = suffix == "delta" ? {delta: {stdout: "partial", stderr: "warning"}} : {output: chunks}
      event = ws(
        type: "response.shell_call_output_content.#{suffix}",
        output_index: 0,
        item_id: "item",
        command_index: 9,
        **payload
      )
      original = event.to_h
      preview.add(event)
      assert_equal(:provisional, preview.phase)
      part = preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:part)
      assert_equal(suffix == "delta" ? payload.fetch(:delta) : {output: chunks}, part)
      assert_empty(preview.output.first.output)
      assert_equal(original, event.to_h)
    end
  end

  def test_sparse_facts_keep_real_indices_without_inventing_typed_items
    preview = OpenAI::Responses::IncrementalResponse.new
    event = ws(
      type: "response.output_text.delta",
      output_index: 1_000_000_000_000,
      content_index: 7,
      item_id: "sparse",
      delta: +"first",
      logprobs: []
    )
    preview.add(event)
    saved = preview.detailed_snapshot
    assert_equal("first", saved.fetch(:output_text))
    event.delta.replace("raw changed")
    preview.add(
      ws(
        type: "response.output_text.done",
        output_index: 1_000_000_000_000,
        content_index: 7,
        item_id: "sparse",
        text: "corrected",
        logprobs: []
      )
    )
    assert_equal(:provisional, preview.phase)
    assert_empty(preview.output)
    row = preview.detailed_snapshot.fetch(:output).first
    assert_equal(1_000_000_000_000, row.fetch(:output_index))
    refute(row.fetch(:item).key?(:type))
    assert_equal(7, row.fetch(:content).first.fetch(:content_index))
    assert_equal("corrected", row.fetch(:content).first.fetch(:part).fetch(:text))
    assert_equal("corrected", preview.detailed_snapshot.fetch(:output_text))
    assert_equal("first", saved.fetch(:output).first.fetch(:content).first.fetch(:part).fetch(:text))
    preview.add(ws(type: "response.created", response: rich_response(output: [])))
    assert_empty(preview.detailed_snapshot.fetch(:output))
  end

  def test_optional_tool_ids_bind_privately_through_field_done_and_reject_conflicts
    {
      "function_call" => ["function_call_arguments", :arguments],
      "custom_tool_call" => ["custom_tool_call_input", :input]
    }.each do |kind, (family, field)|
      preview = OpenAI::Responses::IncrementalResponse.new
      item = rich_item(kind)
      item.delete(:id)
      preview.add(ws(type: "response.created", response: rich_response(output: [item])))
      fragment = kind == "function_call" ? "true}" : " suffix"
      expected = kind == "function_call" ? "{\"seed\":true}" : "seed suffix"
      done = kind == "function_call" ? "{\"done\":true}" : "done"
      preview.add(ws(type: "response.#{family}.delta", output_index: 0, item_id: "bound", delta: fragment))
      assert_equal(expected, preview.output.first[field])
      refute(preview.output.first.to_h.key?(:id))
      preview.add(ws(type: "response.#{family}.done", output_index: 0, item_id: "bound", **{field => done}))
      assert_equal(done, preview.output.first[field])
      refute(preview.output.first.to_h.key?(:id))
      preview.add(ws(type: "response.#{family}.delta", output_index: 0, item_id: "conflict", delta: "bad"))
      assert_equal(:unavailable, preview.phase)
    end
  end

  def test_queued_in_progress_metadata_and_exact_terminal_have_independent_copies
    preview = OpenAI::Responses::IncrementalResponse.new
    queued = ws(type: "response.queued", sequence_number: 0, response: rich_response(output: [], status: "queued"))
    preview.add(queued)
    saved = preview.detailed_snapshot
    assert_equal("queued", saved.fetch(:response).fetch(:status))
    assert_equal(queued.response.id, saved.fetch(:response_id))
    assert_equal("test", saved.fetch(:stream_id))
    progressing = ws(
      type: "response.in_progress",
      sequence_number: 1,
      response: rich_response(output: [rich_item("reasoning")])
    )
    preview.add(progressing)
    assert_equal("in_progress", preview.detailed_snapshot.fetch(:response).fetch(:status))
    assert_empty(saved.fetch(:output))
    response = rich_response(output: [], status: "completed").merge(opaque: {text: +"terminal"})
    final = ws(type: "response.completed", sequence_number: 2, response: response)
    preview.add(final)
    snapshot = preview.detailed_snapshot
    assert_equal(:terminal, preview.phase)
    assert_nil(preview.output)
    assert_equal("response.completed", snapshot.fetch(:terminal_type))
    assert_empty(snapshot.fetch(:output))
    snapshot.fetch(:response).fetch(:opaque).fetch(:text).replace("changed")
    assert_equal(final.to_h, preview.terminal_event.to_h)
    assert_equal("terminal", preview.detailed_snapshot.fetch(:response).fetch(:opaque).fetch(:text))
  end

  def test_sparse_tool_refusal_and_annotation_facts_do_not_fabricate_scaffolds
    [
      ["function_call_arguments", :arguments],
      ["custom_tool_call_input", :input],
      ["mcp_call_arguments", :arguments]
    ].each do |family, field|
      preview = OpenAI::Responses::IncrementalResponse.new
      fragment = family == "function_call_arguments" ? "{\"seed\":true}" : "suffix"
      done = family == "custom_tool_call_input" ? "done" : "{\"done\":true}"
      preview.add(ws(type: "response.#{family}.delta", output_index: 9, item_id: "observed", delta: fragment))
      assert_empty(preview.output)
      item = preview.detailed_snapshot.fetch(:output).first.fetch(:item)
      assert_equal(fragment, item.fetch(field))
      refute(item.key?(:type))
      refute(item.key?(:name))
      refute(item.key?(:call_id))
      preview.add(ws(type: "response.#{family}.done", output_index: 9, item_id: "observed", **{field => done}))
      assert_equal(done, preview.detailed_snapshot.fetch(:output).first.fetch(:item).fetch(field))
    end

    preview = OpenAI::Responses::IncrementalResponse.new
    preview.add(
      ws(type: "response.refusal.done", output_index: 5, item_id: "observed", content_index: 7, refusal: "data only")
    )
    part = preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:part)
    assert_equal({refusal: "data only"}, part)
    preview.add(
      ws(
        type: "response.output_item.done",
        output_index: 5,
        item: message_item(id: "observed", content: [text_part(text: "full")])
      )
    )
    assert_equal("full", preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:part).fetch(:text))
    assert_empty(preview.output)

    preview.reset
    preview.add(ws(type: "response.created", response: rich_response(output: [message_item(content: [text_part])])))
    annotation = {type: "file_path", index: 0, file_id: "file_observed", opaque: {text: +"metadata"}}
    event = ws(
      type: "response.output_text.annotation.added",
      output_index: 0,
      item_id: "msg_test",
      content_index: 0,
      annotation_index: 9,
      annotation: annotation
    )
    preview.add(event)
    row = preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:part).fetch(:annotations).first
    assert_equal(9, row.fetch(:annotation_index))
    assert_equal("metadata", row.fetch(:annotation).fetch(:opaque).fetch(:text))
    assert_empty(preview.output.first.content.first.annotations)
  end

  def test_whole_shell_arrays_replace_one_command_without_changing_flat_item_output
    preview = OpenAI::Responses::IncrementalResponse.new
    call = rich_item("shell_call").merge(id: "call_item", action: {commands: ["one", "two"]})
    item = rich_item("shell_call_output")
    preview.add(ws(type: "response.created", response: rich_response(output: [call, item])))
    frame = {output_index: 1, item_id: "item", command_index: 1}
    preview.add(ws(type: "response.shell_call_output_content.delta", **frame, delta: {stdout: "first", stderr: "warn"}))
    saved = preview.detailed_snapshot
    preview.add(
      ws(type: "response.shell_call_output_content.delta", **frame.merge(command_index: 0), delta: {stdout: "neighbor"})
    )
    chunks = [
      {
        stdout: "corrected-a",
        stderr: "",
        outcome: {type: "exit", exit_code: 7},
        created_by: "actor-a",
        opaque: {text: +"metadata"}
      },
      {stdout: "corrected-b", stderr: "warning", outcome: {type: "timeout"}, created_by: "actor-b"}
    ]
    done = ws(type: "response.shell_call_output_content.done", **frame, output: chunks)
    original = done.to_h
    preview.add(done)
    facts = preview.detailed_snapshot.fetch(:output).last.fetch(:content)
    assert_equal([0, 1], facts.map { |row| row.fetch(:command_index) })
    assert_equal({stdout: "neighbor"}, facts.first.fetch(:part))
    assert_equal({output: chunks}, facts.last.fetch(:part))
    assert_equal({stdout: "first", stderr: "warn"}, saved.fetch(:output).last.fetch(:content).first.fetch(:part))
    assert_empty(preview.output.last.output)
    assert_equal(original, done.to_h)
    facts.last.fetch(:part).fetch(:output).first.fetch(:opaque).fetch(:text).replace("changed copy")
    assert_equal(
      "metadata",
      preview
        .detailed_snapshot
        .fetch(:output)
        .last
        .fetch(:content)
        .last
        .fetch(:part)
        .fetch(:output)
        .first
        .fetch(:opaque)
        .fetch(:text)
    )
    preview.add(ws(type: "response.shell_call_output_content.done", **frame, output: []))
    assert_equal({output: []}, preview.detailed_snapshot.fetch(:output).last.fetch(:content).last.fetch(:part))
    full = item.merge(output: [chunks.first], status: "completed")
    preview.add(ws(type: "response.output_item.done", output_index: 1, item: full))
    assert_equal(1, preview.output.last.output.length)
    refute(preview.detailed_snapshot.fetch(:output).last.key?(:content))
    preview.add(
      ws(
        type: "response.output_item.done",
        output_index: 0,
        item: call.merge(action: {commands: ["one"]}, status: "completed")
      )
    )
    preview.add(ws(type: "response.shell_call_output_content.delta", **frame, delta: {stdout: "outside reduced bound"}))
    assert_equal(:unavailable, preview.phase)

    preview.reset
    preview.add(ws(type: "response.created", response: rich_response(output: [item])))
    preview.add(
      ws(
        type: "response.shell_call_output_content.delta",
        output_index: 0,
        item_id: "item",
        command_index: 1_000_000_000_000,
        delta: {stderr: "observed"}
      )
    )
    assert_equal(
      1_000_000_000_000,
      preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:command_index)
    )
    assert_empty(preview.output.first.output)
    preview.reset
    preview.add(
      ws(
        type: "response.shell_call_output_content.delta",
        output_index: 99,
        item_id: "unscaffolded",
        command_index: 1_000_000_000_000,
        delta: {stderr: "observed"}
      )
    )
    assert_equal(
      1_000_000_000_000,
      preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:command_index)
    )
    assert_empty(preview.output)
  end

  def test_reasoning_parts_metadata_and_identity_indexes_follow_full_replacement
    preview = OpenAI::Responses::IncrementalResponse.new
    item = rich_item("reasoning").merge(action: "opaque action", opaque: {nullable: nil, empty: [], text: +"owned"})
    preview.add(ws(type: "response.created", response: rich_response(output: [item])))
    preview.add(
      ws(
        type: "response.content_part.done",
        output_index: 0,
        item_id: "item",
        content_index: 0,
        part: {type: "reasoning_text", text: "corrected", opaque: {text: +"part"}}
      )
    )
    saved = preview.detailed_snapshot
    assert_equal("corrected", preview.output.first.content.first.text)
    assert_empty(saved.fetch(:output_text))
    assert_equal("opaque action", saved.fetch(:output).first.fetch(:item).fetch(:action))
    assert_nil(saved.fetch(:output).first.fetch(:item).fetch(:opaque).fetch(:nullable))
    assert_empty(saved.fetch(:output).first.fetch(:item).fetch(:opaque).fetch(:empty))
    refute(saved.fetch(:output).first.fetch(:item).fetch(:opaque).key?(:absent))
    preview.add(
      ws(
        type: "response.content_part.done",
        output_index: 0,
        item_id: "item",
        content_index: 0,
        part: {type: "reasoning_text", text: "full"}
      )
    )
    refute(preview.detailed_snapshot.fetch(:output).first.fetch(:content).first.fetch(:part).key?(:opaque))
    assert_equal("part", saved.fetch(:output).first.fetch(:content).first.fetch(:part).fetch(:opaque).fetch(:text))
    outputs = Array.new(64) { |index| rich_item("mcp_call").merge(id: "mcp_#{index}") }
    preview.add(ws(type: "response.created", response: rich_response(output: outputs)))
    preview.add(
      ws(type: "response.output_item.done", output_index: 63, item: rich_item("mcp_call").merge(id: "replacement"))
    )
    preview.add(ws(type: "response.mcp_call_arguments.delta", output_index: 64, item_id: "mcp_63", delta: "suffix"))
    assert_equal(:provisional, preview.phase)
    assert_equal(64, preview.detailed_snapshot.fetch(:output).last.fetch(:output_index))
    preview.add(
      ws(
        type: "response.mcp_call_arguments.delta",
        output_index: 65,
        item_id: "replacement",
        delta: "wrong duplicate index"
      )
    )
    assert_equal(:unavailable, preview.phase)
  end

  def test_optional_id_exception_does_not_admit_missing_required_ids_or_invalid_values
    preview = OpenAI::Responses::IncrementalResponse.new
    item = rich_item("mcp_call")
    item.delete(:id)
    preview.add(ws(type: "response.created", response: rich_response(output: [item])))
    preview.add(ws(type: "response.mcp_call_arguments.delta", output_index: 0, item_id: "required", delta: "bad"))
    assert_equal(:unavailable, preview.phase)
    assert_nil(preview.output)
    assert_nil(preview.detailed_snapshot)

    part = text_part
    part.delete(:text)
    preview.add(ws(type: "response.created", response: rich_response(output: [message_item(content: [part])])))
    preview.add(delta)
    assert_equal(:unavailable, preview.phase)

    call = rich_item("shell_call").merge(action: {commands: [nil]})
    preview.add(ws(type: "response.created", response: rich_response(output: [call])))
    preview.add(ws(type: "response.shell_call_command.delta", output_index: 0, command_index: 0, delta: "bad"))
    assert_equal(:unavailable, preview.phase)
  end

  def test_unknown_fields_do_not_become_unrelated_item_collections
    preview = OpenAI::Responses::IncrementalResponse.new
    item = rich_item("mcp_call").merge(
      content: ["opaque content"],
      summary: ["opaque summary"],
      action: {commands: ["opaque command"]}
    )
    preview.add(ws(type: "response.created", response: rich_response(output: [item])))
    preview.add(ws(type: "response.mcp_call_arguments.delta", output_index: 0, item_id: "item", delta: " suffix"))
    row = preview.detailed_snapshot.fetch(:output).first
    refute(row.key?(:content))
    refute(row.key?(:summary))
    refute(row.key?(:commands))
    assert_equal(["opaque content"], row.fetch(:item).fetch(:content))
    assert_equal(["opaque summary"], row.fetch(:item).fetch(:summary))
    assert_equal({commands: ["opaque command"]}, row.fetch(:item).fetch(:action))
    assert_equal(["opaque content"], preview.output.first.to_h.fetch(:content))
    assert_equal("seed suffix", preview.output.first.arguments)
  end

  private def rich_item(kind)
    {type: kind, id: "item"}.merge(
      case kind
      when "reasoning"
        {summary: [{type: "summary_text", text: "seed"}], content: [{type: "reasoning_text", text: "seed"}]}
      when "code_interpreter_call"
        {code: "seed", container_id: "cntr_fixture", outputs: [], status: "in_progress"}
      when "file_search_call"
        {queries: ["synthetic"], status: "in_progress"}
      when "web_search_call"
        {action: {type: "search", queries: ["synthetic"], sources: []}, status: "in_progress"}
      when "image_generation_call"
        {result: nil, status: "in_progress"}
      when "mcp_call"
        {arguments: "seed", name: "never_run", server_label: "synthetic"}
      when "shell_call"
        {call_id: "call_shell", environment: {type: "local"}, action: {commands: ["seed"]}, status: "in_progress"}
      when "shell_call_output"
        {call_id: "call_shell", output: [], max_output_length: nil, status: "in_progress"}
      when "function_call"
        {call_id: "call_function", name: "never_run", arguments: "{\"seed\":"}
      when "custom_tool_call"
        {call_id: "call_custom", name: "never_run", input: "seed"}
      end
    )
  end

  private def rich_response(output:, status: "in_progress")
    tools = output.filter_map do |item|
      case item[:type]
      when "code_interpreter_call"
        {type: "code_interpreter", container: {type: "auto"}}
      when "file_search_call"
        {type: "file_search", vector_store_ids: ["vs_fixture"]}
      when "web_search_call"
        {type: "web_search"}
      when "image_generation_call"
        {type: "image_generation"}
      when "mcp_call"
        {type: "mcp", server_label: "synthetic", server_url: "https://example.invalid/mcp", require_approval: "never"}
      when "shell_call", "shell_call_output"
        {type: "shell", environment: {type: "local"}}
      when "function_call"
        {type: "function", name: "never_run", parameters: {type: "object", properties: {}}, strict: false}
      when "custom_tool_call"
        {type: "custom", name: "never_run", format: {type: "text"}}
      end
    end

    mcp_response(output: output, status: status).merge(tools: tools.uniq)
  end

  private def mcp_response(output: [], status: "in_progress")
    fixture = JSON.parse(File.read(File.join(__dir__, "fixtures/websocket_scenarios.json")), symbolize_names: true)
    fixture.fetch(:scenarios).first.fetch(:turns).first.fetch(:frames).first.fetch(:response).merge(
      access_programs: nil,
      error: nil,
      incomplete_details: nil,
      instructions: nil,
      metadata: {"synthetic" => "metadata"},
      temperature: nil,
      top_p: nil,
      model: "synthetic-fixture-model",
      output: output,
      status: status
    )
  end

  private def mcp_item(arguments: "", status: "in_progress")
    {
      type: "mcp_call",
      id: "mcp_test",
      name: "never_run",
      server_label: "synthetic",
      arguments: arguments,
      status: status
    }
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
