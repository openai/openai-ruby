# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::StructuredOutputsResponsesFunctionCallingExampleTest < Minitest::Test
  extend Minitest::Serial

  EXAMPLE_PATH = File.expand_path(
    "../../examples/structured_outputs_responses_function_calling.rb",
    __dir__
  )

  def test_ignores_non_tool_outputs_and_prints_parsed_get_weather
    stdout, stderr, exit_error = run_example do |weather_model|
      [
        reasoning_item,
        output_message,
        function_tool_call(parsed: weather_model.new(location: "Paris, France"))
      ]
    end

    assert_nil(exit_error)
    assert_empty(stderr)
    assert_includes(stdout, "GetWeather")
    assert_includes(stdout, "Paris, France")
  end

  def test_fails_clearly_when_response_has_no_outputs
    stdout, stderr, exit_error = run_example { [] }

    assert_instance_of(SystemExit, exit_error)
    assert_equal(1, exit_error.status)
    assert_empty(stdout)
    assert_equal("The response did not contain a parsed GetWeather tool call\n", stderr)
  end

  def test_fails_clearly_when_tool_call_does_not_contain_parsed_get_weather
    stdout, stderr, exit_error = run_example do
      [function_tool_call(parsed: {location: "Paris, France"})]
    end

    assert_instance_of(SystemExit, exit_error)
    assert_equal(1, exit_error.status)
    assert_empty(stdout)
    assert_equal("The response did not contain a parsed GetWeather tool call\n", stderr)
  end

  private

  def run_example(&output_items)
    mocks = []
    constructor = lambda do
      response = Minitest::Mock.new

      responses = Minitest::Mock.new
      responses.expect(:create, response) do |**params|
        response.expect(:output, output_items.call(params.fetch(:tools).fetch(0)))
        true
      end

      client = Minitest::Mock.new
      client.expect(:responses, responses)
      mocks.push(response, responses, client)
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

  def reasoning_item
    OpenAI::Responses::ResponseReasoningItem.new(id: "reasoning_1", summary: [])
  end

  def output_message
    OpenAI::Responses::ResponseOutputMessage.new(id: "message_1", status: :completed, content: [])
  end

  def function_tool_call(parsed:)
    OpenAI::Responses::ResponseFunctionToolCall.new(
      arguments: JSON.generate(location: "Paris, France"),
      call_id: "call_1",
      name: "GetWeather",
      parsed: parsed
    )
  end
end
