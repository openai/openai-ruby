# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamInitialToolParsingTest < Minitest::Test
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

  def test_complete_initial_strict_arguments_match_role_prefixed_deltas
    [hash_tool, typed_tool].each do |tool|
      initial = stream_result([tool_choice(arguments: "{\"x\":1}"), finish_choice], tool)
      prefixed = stream_result([role_choice, tool_choice(arguments: "{\"x\":1}"), finish_choice], tool)

      assert_equal({x: 1}, initial.fetch(:delta).parsed)
      assert_equal(prefixed.fetch(:delta).parsed, initial.fetch(:delta).parsed)
      assert_equal({x: 1}, initial.fetch(:delta).parsed)

      if tool == typed_tool
        assert_instance_of(TypedArguments, initial.fetch(:done).parsed)
        assert_instance_of(TypedArguments, initial.fetch(:final).function.parsed)
      else
        assert_equal({x: 1}, initial.fetch(:done).parsed)
        assert_equal({x: 1}, initial.fetch(:final).function.parsed)
      end
    end
  end

  def test_initial_non_strict_and_incomplete_arguments_keep_existing_unparsed_deltas
    non_strict = stream_result([tool_choice(arguments: "{\"x\":1}"), finish_choice], non_strict_tool)
    incomplete = stream_result([tool_choice(arguments: "{\"x\":"), finish_choice], hash_tool)

    assert_nil(non_strict.fetch(:delta).parsed)
    assert_nil(non_strict.fetch(:done).parsed)
    assert_nil(incomplete.fetch(:delta).parsed)
    assert_nil(incomplete.fetch(:done).parsed)
  end

  private

  def stream_result(choices, tool)
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
      tools: [tool]
    )
    events = stream.to_a

    {
      delta: events.find { |event| event.type == :"tool_calls.function.arguments.delta" },
      done: events.find { |event| event.type == :"tool_calls.function.arguments.done" },
      final: stream.get_final_completion.choices.first.message.tool_calls.first
    }
  end

  def sse(choices)
    chunks = choices.map do |choice|
      payload = {
        id: "chatcmpl-initial-tool",
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

  def tool_choice(arguments:)
    choice(
      delta: {
        role: "assistant",
        tool_calls: [
          {
            index: 0,
            id: "call_0",
            type: "function",
            function: {name: "lookup", arguments: arguments}
          }
        ]
      }
    )
  end

  def finish_choice
    choice(delta: {}, finish_reason: "tool_calls")
  end

  def choice(delta:, finish_reason: nil)
    {index: 0, delta: delta, finish_reason: finish_reason}
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
      function: {name: "lookup", strict: strict, parameters: parameters}
    }
  end
end
