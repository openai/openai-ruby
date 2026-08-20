# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatCompletionStreamTest < Minitest::Test
  def test_stream_indices_do_not_create_sparse_snapshots
    [127, 128, 1_000_000_000].each do |index|
      state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
      events = stream_tool_call(state, choice_index: index, tool_index: index)
      completion = state.get_final_completion

      assert_equal([index], completion.choices.map(&:index))

      tool_calls = completion.choices.first.message.tool_calls
      assert_equal([index], tool_calls.map { |tool_call| tool_call[:index] })
      assert_equal("{\"value\":true}", tool_calls.first.function.arguments)

      deltas = events.select { |event| event.type == :"tool_calls.function.arguments.delta" }
      assert_equal([index, index], deltas.map(&:index))

      done = events.find { |event| event.type == :"tool_calls.function.arguments.done" }
      assert_equal(index, done.index)
    end
  end

  def test_stream_rejects_negative_indices_before_accumulation
    invalid_chunks = [
      ["choice", build_chunk(choice_index: -1, delta: {role: :assistant})],
      [
        "tool call",
        build_chunk(
          choice_index: 0,
          delta: {
            role: :assistant,
            tool_calls: [tool_call_delta(index: -1, arguments: "")]
          }
        )
      ]
    ]

    invalid_chunks.each do |kind, chunk|
      state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
      error = assert_raises(OpenAI::Helpers::Streaming::StreamError) do
        state.handle_chunk(chunk)
      end

      assert_match("Invalid streamed #{kind} index -1", error.message)
      assert_nil(state.current_completion_snapshot)
    end
  end

  def test_interleaved_indices_remain_ordered_and_independent
    state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
    state.handle_chunk(build_chunk(choice_index: 1, delta: {role: :assistant, content: "one"}))
    stream_tool_call(state, choice_index: 0, tool_index: 1, finish: false)
    stream_tool_call(state, choice_index: 0, tool_index: 0, finish: false)

    completion = state.get_final_completion
    assert_equal([0, 1], completion.choices.map(&:index))

    tool_calls = completion.choices.first.message.tool_calls
    assert_equal([0, 1], tool_calls.map { |tool_call| tool_call[:index] })
    assert_equal(["{\"value\":true}", "{\"value\":true}"], tool_calls.map { |tool_call| tool_call.function.arguments })
  end

  private

  def stream_tool_call(state, choice_index:, tool_index:, finish: true)
    events = state.handle_chunk(
      build_chunk(
        choice_index: choice_index,
        delta: {
          role: :assistant,
          tool_calls: [tool_call_delta(index: tool_index, arguments: "")]
        }
      )
    )
    events.concat(
      state.handle_chunk(
        build_chunk(
          choice_index: choice_index,
          delta: {tool_calls: [{index: tool_index, function: {arguments: "{\"value\":true}"}}]}
        )
      )
    )
    if finish
      events.concat(
        state.handle_chunk(build_chunk(choice_index: choice_index, delta: {}, finish_reason: :tool_calls))
      )
    end

    events
  end

  def tool_call_delta(index:, arguments:)
    {
      index: index,
      id: "call_#{index}",
      type: :function,
      function: {name: "test", arguments: arguments}
    }
  end

  def build_chunk(choice_index:, delta:, finish_reason: nil)
    OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Chat::ChatCompletionChunk,
      {
        id: "chatcmpl-index-test",
        object: :"chat.completion.chunk",
        created: 1,
        model: "gpt-4o-mini",
        choices: [{index: choice_index, delta: delta, finish_reason: finish_reason}]
      }
    )
  end
end
