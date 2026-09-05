# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamInterleavedToolDoneTest < Minitest::Test
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

  def test_interleaved_strict_tool_calls_wait_for_complete_arguments
    sequential = stream_result(
      [
        [header(0)],
        [arguments(0, "{\"x\":1}")],
        [header(1)],
        [arguments(1, "{\"x\":2}")]
      ]
    )
    interleaved = stream_result(
      [
        [header(0), header(1)],
        [arguments(0, "{\"x\":")],
        [arguments(1, "{\"x\":")],
        [arguments(0, "1}")],
        [arguments(1, "2}")]
      ]
    )

    assert_equal([[0, "{\"x\":1}", {x: 1}], [1, "{\"x\":2}", {x: 2}]], sequential.fetch(:done))
    assert_equal(sequential.fetch(:done), interleaved.fetch(:done))
    assert_equal(["", "", "{\"x\":", "{\"x\":", "{\"x\":1}", "{\"x\":2}"], interleaved.fetch(:deltas))
    assert_equal([[0, "{\"x\":1}", {x: 1}], [1, "{\"x\":2}", {x: 2}]], interleaved.fetch(:final))
  end

  def test_terminal_chunk_flushes_a_deferred_incomplete_call
    result = stream_result(
      [
        [header(0), header(1)],
        [arguments(0, "{\"x\":")],
        [arguments(1, "{\"x\":2}")]
      ]
    )

    assert_equal([[0, "{\"x\":", nil], [1, "{\"x\":2}", {x: 2}]], result.fetch(:done))
  end

  def test_syntactically_complete_null_arguments_still_finish_early
    result = stream_result(
      [
        [header(0)],
        [arguments(0, "null")],
        [header(1)],
        [arguments(1, "{\"x\":2}")]
      ]
    )

    assert_includes(result.fetch(:done_before_terminal), 0)
    assert_equal([0, "null", nil], result.fetch(:done).first)
  end

  private

  def stream_result(tool_chunks)
    WebMock.reset!
    choices = tool_chunks.map.with_index do |tool_calls, index|
      delta = {tool_calls: tool_calls}
      delta[:role] = "assistant" if index.zero?
      choice(delta: delta)
    end

    choices << choice(delta: {}, finish_reason: "tool_calls")
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(status: 200, headers: {"Content-Type" => "text/event-stream"}, body: sse(choices))

    stream = @client.chat.completions.stream(
      messages: [{content: "Synthetic", role: :user}],
      model: "gpt-4o-mini",
      tools: [strict_tool],
      parallel_tool_calls: true
    )
    events = stream.to_a
    done = events.select { |event| event.type == :"tool_calls.function.arguments.done" }
    deltas = events.select { |event| event.type == :"tool_calls.function.arguments.delta" }
    final = stream.get_final_completion.choices.first.message.tool_calls
    terminal = events.index do |event|
      event.type == :chunk && event.chunk.choices.any?(&:finish_reason)
    end

    {
      done: done.map { |event| [event.index, event.arguments, event.parsed] },
      done_before_terminal: done.filter_map { |event| event.index if events.index(event) < terminal },
      deltas: deltas.map(&:arguments),
      final: final.map { |call| [call[:index], call.function.arguments, call.function.parsed] }
    }
  ensure
    stream&.close
  end

  def sse(choices)
    chunks = choices.map do |choice|
      payload = {
        id: "chatcmpl-interleaved-tool",
        object: "chat.completion.chunk",
        created: 1,
        model: "gpt-4o-mini",
        choices: [choice]
      }
      "data: #{JSON.generate(payload)}\n\n"
    end

    chunks.join + "data: [DONE]\n\n"
  end

  def choice(delta:, finish_reason: nil)
    {index: 0, delta: delta, finish_reason: finish_reason}
  end

  def header(index)
    {
      index: index,
      id: "call_#{index}",
      type: "function",
      function: {name: "lookup", arguments: ""}
    }
  end

  def arguments(index, value)
    {index: index, function: {arguments: value}}
  end

  def strict_tool
    {
      type: :function,
      function: {
        name: "lookup",
        strict: true,
        parameters: {
          type: "object",
          properties: {x: {type: "integer"}},
          required: ["x"],
          additionalProperties: false
        }
      }
    }
  end
end
