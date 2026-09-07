# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponseStreamIsolationTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def setup
    super
    @client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-key")
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_retained_wire_events_do_not_change_as_snapshots_accumulate
    stub_stream(stream_events)

    stream = @client.responses.stream(model: "test", input: "synthetic")
    events = stream.to_a

    created = events.fetch(0)
    added_message = events.fetch(1)
    added_part = events.fetch(2)
    text_delta = events.fetch(3)
    added_function = events.fetch(4)
    arguments_delta = events.fetch(5)

    assert_empty(created.response.output)
    assert_empty(added_message.item.content)
    assert_equal("", added_part.part.text)
    assert_equal("", added_function.item.arguments)

    assert_equal("Hello", text_delta.snapshot)
    assert_equal("{\"ok\":true}", arguments_delta.snapshot)
    assert_equal("Hello", stream.get_output_text)
    assert_equal(:completed, stream.get_final_response.status)
  ensure
    stream&.close
  end

  def test_accumulation_copy_preserves_nested_models_and_unknown_hashes
    created = coerce_event(
      type: "response.created",
      sequence_number: 0,
      response: response(output: [message_item(content: [part], extension: {nested: ["kept"]})])
    )
    state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil)

    state.handle_event(created)
    snapshot = state.instance_variable_get(:@current_snapshot)

    assert_instance_of(OpenAI::Models::Responses::ResponseOutputMessage, snapshot.output.fetch(0))
    assert_instance_of(OpenAI::Models::Responses::ResponseOutputText, snapshot.output.fetch(0).content.fetch(0))
    assert_equal({nested: ["kept"]}, snapshot.output.fetch(0)[:extension])
    refute_same(created.response.output, snapshot.output)
    refute_same(created.response.output.fetch(0).content, snapshot.output.fetch(0).content)
    refute_same(created.response.output.fetch(0)[:extension], snapshot.output.fetch(0)[:extension])
  end

  def test_unknown_union_fallbacks_remain_raw_and_isolated
    item = {type: "future_tool", id: "item_future", opaque: {items: [1]}}
    item_event = OpenAI::Models::Responses::ResponseOutputItemAddedEvent.new(
      item: item,
      output_index: 1,
      sequence_number: 1
    )
    state = state_after_created(response(output: [message_item]))

    state.handle_event(item_event)
    snapshot_item = current_snapshot(state).output.fetch(1)

    assert_equal(item, snapshot_item)
    assert_instance_of(Hash, snapshot_item)
    refute_same(item_event.item, snapshot_item)
    refute_same(item_event.item.fetch(:opaque), snapshot_item.fetch(:opaque))

    content = {type: "future_part", opaque: {items: [2]}}
    content_event = OpenAI::Models::Responses::ResponseContentPartAddedEvent.new(
      content_index: 0,
      item_id: "msg_synthetic",
      output_index: 0,
      part: content,
      sequence_number: 1
    )
    state = state_after_created(response(output: [message_item]))

    state.handle_event(content_event)
    snapshot_content = current_snapshot(state).output.fetch(0).content.fetch(0)

    assert_equal(content, snapshot_content)
    assert_instance_of(Hash, snapshot_content)
    refute_same(content_event.part, snapshot_content)
    refute_same(content_event.part.fetch(:opaque), snapshot_content.fetch(:opaque))
  end

  def test_incremental_events_targeting_unknown_slots_have_nil_snapshots
    state = state_after_created(
      response(
        output: [
          message_item(content: [{type: "future_content"}, part]),
          {type: "future_tool", id: "item_future"}
        ]
      )
    )

    unknown_text_delta = state
      .handle_event(
        coerce_event(
          type: "response.output_text.delta",
          sequence_number: 1,
          item_id: "msg_synthetic",
          output_index: 0,
          content_index: 0,
          delta: "future",
          logprobs: []
        )
      )
      .fetch(0)
    unknown_text_done = state
      .handle_event(
        coerce_event(
          type: "response.output_text.done",
          sequence_number: 2,
          item_id: "msg_synthetic",
          output_index: 0,
          content_index: 0,
          text: "future",
          logprobs: []
        )
      )
      .fetch(0)
    unknown_arguments_delta = state
      .handle_event(
        coerce_event(
          type: "response.function_call_arguments.delta",
          sequence_number: 3,
          item_id: "item_future",
          output_index: 1,
          delta: "future"
        )
      )
      .fetch(0)
    known_text_delta = state
      .handle_event(
        coerce_event(
          type: "response.output_text.delta",
          sequence_number: 4,
          item_id: "msg_synthetic",
          output_index: 0,
          content_index: 1,
          delta: "known",
          logprobs: []
        )
      )
      .fetch(0)

    assert_nil(unknown_text_delta.snapshot)
    assert_nil(unknown_text_done.parsed)
    assert_nil(unknown_arguments_delta.snapshot)
    assert_equal("known", known_text_delta.snapshot)

    structured_state = state_after_created(
      response(output: [message_item(content: [{type: "future_content"}])]),
      text_format: Hash
    )
    structured_done = structured_state
      .handle_event(
        coerce_event(
          type: "response.output_text.done",
          sequence_number: 5,
          item_id: "msg_synthetic",
          output_index: 0,
          content_index: 0,
          text: "not JSON",
          logprobs: []
        )
      )
      .fetch(0)

    assert_nil(structured_done.parsed)
  end

  def test_text_consumption_does_not_copy_each_accumulated_prefix
    events = repeated_delta_events
    stub_stream(events)
    stream = @client.responses.stream(model: "test", input: "synthetic")
    text = +""

    copied_bytes = copied_snapshot_bytes do
      stream.text.each { |delta| text << delta }
    end

    assert_equal("x" * 200_000, text)
    assert_equal(text, stream.get_output_text)
    assert_equal("y" * 200_000, stream.get_final_response.output.fetch(1).arguments)
    assert_operator(copied_bytes, :<, 2_000_000)
  ensure
    stream&.close
  end

  def test_until_done_does_not_copy_each_accumulated_prefix
    stub_stream(repeated_delta_events)
    stream = @client.responses.stream(model: "test", input: "synthetic")

    copied_bytes = copied_snapshot_bytes { assert_same(stream, stream.until_done) }

    assert_equal("x" * 200_000, stream.get_output_text)
    assert_equal("y" * 200_000, stream.get_final_response.output.fetch(1).arguments)
    assert_operator(copied_bytes, :<, 2_000_000)
  ensure
    stream&.close
  end

  def test_unconsumed_text_enumerator_preserves_event_snapshots
    stub_stream(repeated_delta_events(count: 3))
    stream = @client.responses.stream(model: "test", input: "synthetic")
    stream.text

    events = stream.to_a
    text_events = events.grep(OpenAI::Streaming::ResponseTextDeltaEvent)
    arguments_events = events.grep(OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent)

    assert_equal([100, 200, 300], text_events.map { |event| event.snapshot.length })
    assert_equal([100, 200, 300], arguments_events.map { |event| event.snapshot.length })
    assert_equal("x" * 300, stream.get_output_text)
  ensure
    stream&.close
  end

  def test_snapshots_stay_isolated_when_consumption_changes
    events = repeated_delta_events(count: 4).map { |event| coerce_event(event) }
    state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil)
    created = events.shift
    state.handle_event(created)

    first_text = state.handle_event(events.shift).fetch(0)
    first_arguments = state.handle_event(events.shift).fetch(0)
    4.times { state.handle_event(events.shift, text_only: true) }
    last_text = state.handle_event(events.shift).fetch(0)
    last_arguments = state.handle_event(events.shift).fetch(0)

    assert_equal("x" * 100, first_text.snapshot)
    assert_equal("y" * 100, first_arguments.snapshot)
    assert_equal("x" * 400, last_text.snapshot)
    assert_equal("y" * 400, last_arguments.snapshot)
    assert_equal("", created.response.output.fetch(0).content.fetch(0).text)
    assert_equal("", created.response.output.fetch(1).arguments)
  end

  private

  # Count materialized String results in the accumulator, not elapsed time or
  # process-wide allocations. The bound allows linear growth but catches full
  # prefix copies for these synthetic text and argument deltas.
  def copied_snapshot_bytes
    bytes = 0
    accumulator = File.expand_path("../../../lib/openai/helpers/streaming/response_stream.rb", __dir__)
    trace = TracePoint.new(:c_return) do |event|
      next unless event.defined_class == String
      next unless [:+, :dup, :clone].include?(event.method_id)
      next unless File.expand_path(event.path) == accumulator

      bytes += event.return_value.bytesize
    end

    trace.enable(target_thread: Thread.current) { yield }
    bytes
  ensure
    trace&.disable
  end

  def repeated_delta_events(count: 2000)
    events = [
      {
        type: "response.created",
        sequence_number: 0,
        response: response(output: [message_item(content: [part]), function_call])
      }
    ]
    count.times do |index|
      events <<
        {
          type: "response.output_text.delta",
          sequence_number: (index * 2) + 1,
          item_id: "msg_synthetic",
          output_index: 0,
          content_index: 0,
          delta: "x" * 100,
          logprobs: []
        }
      events <<
        {
          type: "response.function_call_arguments.delta",
          sequence_number: (index * 2) + 2,
          item_id: "fc_synthetic",
          output_index: 1,
          delta: "y" * 100
        }
    end

    events <<
      {
        type: "response.completed",
        sequence_number: (count * 2) + 1,
        response: response(
          status: "completed",
          output: [
            message_item(status: "completed", content: [part(text: "x" * count * 100)]),
            function_call(arguments: "y" * count * 100)
          ]
        )
      }
    events
  end

  def coerce_event(event)
    OpenAI::Internal::Type::Converter.coerce(OpenAI::Models::Responses::ResponseStreamEvent, event)
  end

  def state_after_created(response, text_format: nil)
    state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: text_format)
    state.handle_event(coerce_event(type: "response.created", sequence_number: 0, response: response))
    state
  end

  def current_snapshot(state)
    state.instance_variable_get(:@current_snapshot)
  end

  def stub_stream(events)
    body = events
      .map do |event|
        "event: #{event.fetch(:type)}\ndata: #{JSON.generate(event)}\n\n"
      end
      .join

    stub_request(:post, "http://localhost/responses").to_return(
      status: 200,
      headers: {"Content-Type" => "text/event-stream"},
      body: body
    )
  end

  def stream_events
    [
      {type: "response.created", sequence_number: 0, response: response},
      {type: "response.output_item.added", sequence_number: 1, output_index: 0, item: message_item},
      {
        type: "response.content_part.added",
        sequence_number: 2,
        item_id: "msg_synthetic",
        output_index: 0,
        content_index: 0,
        part: part
      },
      {
        type: "response.output_text.delta",
        sequence_number: 3,
        item_id: "msg_synthetic",
        output_index: 0,
        content_index: 0,
        delta: "Hello"
      },
      {type: "response.output_item.added", sequence_number: 4, output_index: 1, item: function_call},
      {
        type: "response.function_call_arguments.delta",
        sequence_number: 5,
        item_id: "fc_synthetic",
        output_index: 1,
        delta: "{\"ok\":true}"
      },
      {
        type: "response.completed",
        sequence_number: 6,
        response: response(
          status: "completed",
          output: [
            message_item(status: "completed", content: [part(text: "Hello")]),
            function_call(arguments: "{\"ok\":true}")
          ]
        )
      }
    ]
  end

  def response(status: "in_progress", output: [])
    {id: "resp_synthetic", object: "response", status: status, model: "test", output: output}
  end

  def message_item(status: "in_progress", content: [], extension: nil)
    value = {
      id: "msg_synthetic",
      type: "message",
      role: "assistant",
      status: status,
      content: content
    }
    value[:extension] = extension if extension
    value
  end

  def part(text: "")
    {type: "output_text", text: text, annotations: [], logprobs: []}
  end

  def function_call(arguments: "")
    {
      id: "fc_synthetic",
      type: "function_call",
      name: "synthetic",
      call_id: "call_synthetic",
      arguments: arguments
    }
  end
end
