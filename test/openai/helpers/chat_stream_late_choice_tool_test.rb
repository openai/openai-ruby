# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamLateChoiceToolTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class TypedArguments < OpenAI::BaseModel
    required :x, Integer
  end

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

  def test_late_choice_strict_arguments_match_initial_choice_parsing
    [hash_tool, typed_tool].each do |tool|
      initial = stream_result(initial_choices, tool, choice_index: 0)
      late = stream_result(late_choices(arguments: "{\"x\":1}"), tool, choice_index: 1)

      assert_equal({x: 1}, late.fetch(:delta).parsed)
      assert_equal(initial.fetch(:delta).parsed, late.fetch(:delta).parsed)
      assert_instance_of(
        OpenAI::Chat::ChatCompletionMessageFunctionToolCall::Function,
        late.fetch(:final).function
      )

      if tool == typed_tool
        assert_instance_of(TypedArguments, late.fetch(:done).parsed)
        assert_instance_of(TypedArguments, late.fetch(:final).function.parsed)
      else
        assert_equal({x: 1}, late.fetch(:done).parsed)
        assert_equal({x: 1}, late.fetch(:final).function.parsed)
      end

      assert_equal("{\"x\":1}", late.fetch(:raw_function).arguments)
      refute_respond_to(late.fetch(:raw_function), :parsed)
    end
  end

  def test_late_choice_non_strict_and_incomplete_arguments_remain_unparsed
    non_strict = stream_result(late_choices(arguments: "{\"x\":1}"), non_strict_tool, choice_index: 1)
    incomplete = stream_result(late_choices(arguments: "{\"x\":"), hash_tool, choice_index: 1)

    assert_nil(non_strict.fetch(:delta).parsed)
    assert_nil(non_strict.fetch(:done).parsed)
    assert_nil(incomplete.fetch(:delta).parsed)
    assert_nil(incomplete.fetch(:done).parsed)
  end

  private

  def stream_result(choices, tool, choice_index:)
    WebMock.reset!
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: sse(choices)
      )

    stream = @client.chat.completions.stream(
      messages: [{content: "Synthetic", role: :user}],
      model: "gpt-4o-mini",
      n: choices.any? { |choice| choice[:index] == 1 } ? 2 : 1,
      tools: [tool]
    )
    events = stream.to_a
    chunks = events.filter_map { |event| event.chunk if event.type == :chunk }
    raw_choice = chunks.flat_map(&:choices).find { |choice| choice.index == choice_index && choice.delta.tool_calls }

    {
      delta: events.find { |event| event.type == :"tool_calls.function.arguments.delta" },
      done: events.find { |event| event.type == :"tool_calls.function.arguments.done" },
      final: stream
        .get_final_completion
        .choices
        .find { |choice| choice.index == choice_index }
        .message
        .tool_calls
        .first,
      raw_function: raw_choice.delta.tool_calls.first.function
    }
  end

  def sse(choices)
    chunks = choices.map do |choice|
      payload = {
        id: "chatcmpl-late-tool",
        object: "chat.completion.chunk",
        created: 1,
        model: "gpt-4o-mini",
        choices: [choice]
      }
      "data: #{JSON.generate(payload)}\n\n"
    end

    chunks.join + "data: [DONE]\n\n"
  end

  def initial_choices
    [tool_choice(index: 0, arguments: "{\"x\":1}"), finish_choice(index: 0)]
  end

  def late_choices(arguments:)
    [
      {index: 0, delta: {role: "assistant", content: "control"}, finish_reason: "stop"},
      tool_choice(index: 1, arguments:),
      finish_choice(index: 1)
    ]
  end

  def tool_choice(index:, arguments:)
    {
      index:,
      delta: {
        role: "assistant",
        tool_calls: [
          {
            index: 0,
            id: "call_0",
            type: "function",
            function: {name: "lookup", arguments:}
          }
        ]
      },
      finish_reason: nil
    }
  end

  def finish_choice(index:)
    {index:, delta: {}, finish_reason: "tool_calls"}
  end

  def hash_tool
    function_tool(parameters: {type: "object", properties: {x: {type: "integer"}}})
  end

  def typed_tool
    function_tool(parameters: TypedArguments)
  end

  def non_strict_tool
    function_tool(strict: false, parameters: {type: "object", properties: {x: {type: "integer"}}})
  end

  def function_tool(strict: true, parameters:)
    {
      type: :function,
      function: {name: "lookup", strict:, parameters:}
    }
  end
end
