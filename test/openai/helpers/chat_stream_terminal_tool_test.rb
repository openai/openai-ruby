# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamTerminalToolTest < Minitest::Test
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

  def test_terminal_tool_call_emits_done_without_a_tool_header
    [[], [role_choice]].each do |prefix|
      stream, events = stream_events(prefix + [terminal_choice(tool_call(0, "strict_tool", "{\"value\":1}"))])

      assert_equal([0], done_events(events).map(&:index))
      assert_equal(["{\"value\":1}"], argument_deltas(events).map(&:arguments_delta))
      assert_equal(
        "{\"value\":1}",
        stream.get_final_completion.choices.first.message.tool_calls.first.function.arguments
      )
      assert_equal({value: 1}, done_events(events).first.parsed)
    end
  end

  def test_terminal_chunk_emits_each_completed_function_tool_once
    calls = [
      tool_call(0, "strict_tool", "{\"value\":1}"),
      tool_call(1, "non_strict_tool", "{\"value\":2}"),
      tool_call(2, "unknown_tool", "{\"value\":3}")
    ]
    stream, events = stream_events([terminal_choice(*calls)])
    dones = done_events(events)

    assert_equal([0, 1, 2], dones.map(&:index))
    assert_equal(["strict_tool", "non_strict_tool", "unknown_tool"], dones.map(&:name))
    assert_equal(["{\"value\":1}", "{\"value\":2}", "{\"value\":3}"], dones.map(&:arguments))
    assert_equal([{value: 1}, nil, nil], dones.map(&:parsed))
    assert_equal(
      ["{\"value\":1}", "{\"value\":2}", "{\"value\":3}"],
      stream.get_final_completion.choices.first.message.tool_calls.map { |call| call.function.arguments }
    )
  end

  def test_split_tool_header_and_delta_still_emit_one_done_event
    chunks = [
      choice(delta: {role: "assistant", tool_calls: [tool_call(0, "strict_tool", "")]}),
      choice(delta: {tool_calls: [{index: 0, function: {arguments: "{\"value\":1}"}}]}),
      terminal_choice
    ]
    stream, events = stream_events(chunks)

    assert_equal([0], done_events(events).map(&:index))
    assert_equal(["", "{\"value\":1}"], argument_deltas(events).map(&:arguments_delta))
    assert_equal("{\"value\":1}", stream.get_final_completion.choices.first.message.tool_calls.first.function.arguments)
  end

  private

  def stream_events(choices)
    WebMock.reset!
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: sse(choices)
      )

    stream = @client.chat.completions.stream(
      messages: [{content: "Hello", role: :user}],
      model: "gpt-4o-mini",
      tools: input_tools
    )
    [stream, stream.to_a]
  end

  def sse(choices)
    chunks = choices.map do |choice|
      payload = {
        id: "chatcmpl-terminal-tool",
        object: "chat.completion.chunk",
        created: 1,
        model: "gpt-4o-mini",
        choices: [choice]
      }
      "data: #{JSON.generate(payload)}\n\n"
    end

    chunks.join + "data: [DONE]\n\n"
  end

  def role_choice
    choice(delta: {role: "assistant"})
  end

  def terminal_choice(*tool_calls)
    delta = tool_calls.empty? ? {} : {tool_calls: tool_calls}
    choice(delta: delta, finish_reason: "tool_calls")
  end

  def choice(delta:, finish_reason: nil)
    {index: 0, delta: delta, finish_reason: finish_reason}
  end

  def tool_call(index, name, arguments)
    {
      index: index,
      id: "call_#{index}",
      type: "function",
      function: {name: name, arguments: arguments}
    }
  end

  def input_tools
    [
      function_tool("strict_tool", strict: true),
      function_tool("non_strict_tool", strict: false)
    ]
  end

  def function_tool(name, strict:)
    {
      type: :function,
      function: {
        name: name,
        strict: strict,
        parameters: {
          type: "object",
          properties: {value: {type: "integer"}},
          required: ["value"],
          additionalProperties: false
        }
      }
    }
  end

  def done_events(events)
    events.select { |event| event.type == :"tool_calls.function.arguments.done" }
  end

  def argument_deltas(events)
    events.select { |event| event.type == :"tool_calls.function.arguments.delta" }
  end
end
