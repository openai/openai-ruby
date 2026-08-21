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

  def test_tool_call_snapshot_lookups_are_linear
    tool_call_count = 128
    tool_calls = Array.new(tool_call_count) do |index|
      tool_call_delta(index: index, arguments: "")
    end

    state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
    state.handle_chunk(
      build_chunk(choice_index: 0, delta: {role: :assistant, tool_calls: tool_calls})
    )

    updates = Array.new(tool_call_count) do |index|
      {index: index, function: {arguments: "{}"}}
    end

    comparisons = count_integer_equality_calls do
      state.handle_chunk(
        build_chunk(
          choice_index: 0,
          delta: {tool_calls: updates},
          finish_reason: :tool_calls
        )
      )
    end

    final_tool_calls = state.get_final_completion.choices.first.message.tool_calls
    assert_equal(tool_call_count, final_tool_calls.length)
    assert_equal(["{}"] * tool_call_count, final_tool_calls.map { |tool_call| tool_call.function.arguments })
    assert_operator(comparisons, :<=, tool_call_count * 32)
  end

  def test_in_order_tool_call_appends_do_not_resort_existing_snapshots
    tool_call_count = 128
    state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
    state.handle_chunk(
      build_chunk(
        choice_index: 0,
        delta: {role: :assistant, tool_calls: [tool_call_delta(index: 0, arguments: "")]}
      )
    )

    sorts = count_array_sort_by_calls do
      1.upto(tool_call_count - 1) do |index|
        state.handle_chunk(
          build_chunk(
            choice_index: 0,
            delta: {tool_calls: [tool_call_delta(index: index, arguments: "")]}
          )
        )
      end
    end

    final_tool_calls = state.get_final_completion.choices.first.message.tool_calls
    assert_equal((0...tool_call_count).to_a, final_tool_calls.map { |tool_call| tool_call[:index] })
    assert_equal(0, sorts)
  end

  def test_choice_snapshot_lookups_are_linear
    choice_count = 128
    choices = Array.new(choice_count) do |index|
      {index: index, delta: {role: :assistant, content: "choice #{index}"}, finish_reason: nil}
    end

    state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
    state.handle_chunk(build_chunk_with_choices([]))

    comparisons = count_integer_equality_calls do
      state.handle_chunk(build_chunk_with_choices(choices))
    end

    assert_equal((0...choice_count).to_a, state.get_final_completion.choices.map(&:index))
    assert_operator(comparisons, :<=, choice_count * 32)
  end

  def test_in_order_choice_appends_do_not_resort_existing_snapshots
    choice_count = 128
    state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
    state.handle_chunk(build_chunk(choice_index: 0, delta: {role: :assistant}))

    index_reads = count_choice_snapshot_index_reads do
      1.upto(choice_count - 1) do |index|
        state.handle_chunk(build_chunk(choice_index: index, delta: {role: :assistant}))
      end
    end

    assert_equal((0...choice_count).to_a, state.get_final_completion.choices.map(&:index))
    assert_operator(index_reads, :<=, choice_count * 16)
  end

  def test_initial_choice_order_is_preserved_until_a_choice_is_appended
    state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
    state.handle_chunk(
      build_chunk_with_choices(
        [
          {index: 2, delta: {role: :assistant}, finish_reason: nil},
          {index: 0, delta: {role: :assistant}, finish_reason: nil}
        ]
      )
    )

    assert_equal([2, 0], state.current_completion_snapshot.choices.map(&:index))

    state.handle_chunk(build_chunk(choice_index: 1, delta: {role: :assistant}))
    assert_equal([0, 1, 2], state.current_completion_snapshot.choices.map(&:index))
  end

  private

  def count_choice_snapshot_index_reads
    reads = 0
    trace = TracePoint.new(:call) do |event|
      if event.method_id == :index && event.self.is_a?(OpenAI::Models::Chat::ParsedChoice)
        reads += 1
      end
    end

    trace.enable { yield }
    reads
  ensure
    trace&.disable
  end

  def count_integer_equality_calls
    comparisons = 0
    trace = TracePoint.new(:c_call) do |event|
      if event.defined_class == Integer && event.method_id == :==
        comparisons += 1
      end
    end

    trace.enable { yield }
    comparisons
  ensure
    trace&.disable
  end

  def count_array_sort_by_calls
    sorts = 0
    trace = TracePoint.new(:c_call) do |event|
      if event.defined_class == Array && event.method_id == :sort_by!
        sorts += 1
      end
    end

    trace.enable { yield }
    sorts
  ensure
    trace&.disable
  end

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
    build_chunk_with_choices(
      [{index: choice_index, delta: delta, finish_reason: finish_reason}]
    )
  end

  def build_chunk_with_choices(choices)
    OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Chat::ChatCompletionChunk,
      {
        id: "chatcmpl-index-test",
        object: :"chat.completion.chunk",
        created: 1,
        model: "gpt-4o-mini",
        choices: choices
      }
    )
  end
end
