# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::StructuredOutputsChatCompletionsFunctionCallingExampleTest < Minitest::Test
  extend Minitest::Serial

  EXAMPLE_PATH = File.expand_path(
    "../../examples/structured_outputs_chat_completions_function_calling.rb",
    __dir__
  )
  FAILURE_MESSAGE = "The chat completion did not contain a parsed GetWeather tool call\n"

  def test_prints_parsed_get_weather_function_tool_calls
    stdout, stderr, exit_error = run_example do |weather_model|
      [choice(tool_calls: [function_tool_call(parsed: weather_model.new(location: "Paris, France"))])]
    end

    assert_nil(exit_error)
    assert_empty(stderr)
    assert_includes(stdout, "GetWeather")
    assert_includes(stdout, "Paris, France")
  end

  def test_fails_clearly_when_chat_completion_has_no_choices
    assert_missing_parsed_tool_call { [] }
  end

  def test_fails_clearly_when_every_choice_is_refused
    assert_missing_parsed_tool_call do |weather_model|
      [
        choice(
          refusal: "I cannot provide a weather forecast.",
          tool_calls: [function_tool_call(parsed: weather_model.new(location: "Paris, France"))]
        )
      ]
    end
  end

  def test_fails_clearly_when_choices_have_no_tool_calls
    assert_missing_parsed_tool_call { [choice] }
  end

  def test_fails_clearly_when_function_tool_call_has_the_wrong_parsed_type
    assert_missing_parsed_tool_call do
      [choice(tool_calls: [function_tool_call(parsed: {location: "Paris, France"})])]
    end
  end

  def test_fails_clearly_when_tool_calls_do_not_include_a_function
    assert_missing_parsed_tool_call do
      [choice(tool_calls: [custom_tool_call])]
    end
  end

  def test_ignores_refusals_nonmatching_calls_and_wrong_parsed_values
    stdout, stderr, exit_error = run_example do |weather_model|
      [
        choice(
          refusal: "I cannot provide a weather forecast.",
          tool_calls: [function_tool_call(parsed: weather_model.new(location: "Refused City"))]
        ),
        choice(
          tool_calls: [
            custom_tool_call,
            function_tool_call(parsed: {location: "Wrong City"}),
            function_tool_call(parsed: weather_model.new(location: "Paris, France"))
          ]
        )
      ]
    end

    assert_nil(exit_error)
    assert_empty(stderr)
    assert_includes(stdout, "GetWeather")
    assert_includes(stdout, "Paris, France")
    refute_includes(stdout, "Refused City")
    refute_includes(stdout, "Wrong City")
    refute_includes(stdout, "Unexpected tool call type")
  end

  private

  def assert_missing_parsed_tool_call(&choices)
    stdout, stderr, exit_error = run_example(&choices)

    assert_instance_of(SystemExit, exit_error)
    assert_equal(1, exit_error.status)
    assert_empty(stdout)
    assert_equal(FAILURE_MESSAGE, stderr)
  end

  def run_example(&choices)
    mocks = []
    constructor = lambda do
      chat_completion = Minitest::Mock.new

      completions = Minitest::Mock.new
      completions.expect(:create, chat_completion) do |**params|
        chat_completion.expect(:choices, choices.call(params.fetch(:tools).fetch(0)))
        true
      end

      chat = Minitest::Mock.new
      chat.expect(:completions, completions)

      client = Minitest::Mock.new
      client.expect(:chat, chat)

      mocks.push(chat_completion, completions, chat, client)
      client
    end

    exit_error = nil
    stdout, stderr = capture_io do
      OpenAI::Client.stub(:new, constructor) do
        load(EXAMPLE_PATH, true)
      rescue SystemExit => error
        exit_error = error
      end
    end

    mocks.each(&:verify)

    [stdout, stderr, exit_error]
  end

  def choice(tool_calls: [], refusal: nil)
    message = OpenAI::Chat::ChatCompletionMessage.new(
      content: nil,
      refusal: refusal,
      tool_calls: tool_calls
    )

    OpenAI::Chat::ChatCompletion::Choice.new(
      finish_reason: :tool_calls,
      index: 0,
      logprobs: nil,
      message: message
    )
  end

  def function_tool_call(parsed:)
    OpenAI::Chat::ChatCompletionMessageFunctionToolCall.new(
      id: "function_1",
      function: OpenAI::Chat::ChatCompletionMessageFunctionToolCall::Function.new(
        arguments: JSON.generate(location: "Paris, France"),
        name: "GetWeather",
        parsed: parsed
      )
    )
  end

  def custom_tool_call
    OpenAI::Chat::ChatCompletionMessageCustomToolCall.new(
      id: "custom_1",
      custom: {input: "ignored", name: "OtherTool"}
    )
  end
end
