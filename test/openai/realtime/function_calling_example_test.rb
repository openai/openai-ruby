# frozen_string_literal: true

require "json"
require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/realtime/function_calling"
require_relative "example_test_support"

class OpenAI::Test::RealtimeFunctionCallingExampleTest < Minitest::Test
  include OpenAI::Test::RealtimeExampleTestSupport

  def test_runs_forced_local_function_call_and_returns_completed_final_text
    prompt = "private weather question"
    client, connection, realtime = recording_client(
      [
        function_call(arguments: JSON.generate(city: "Paris")),
        response_done(id: "response_tool"),
        response_done(id: "response_final", text: "It is clear and 18 C.")
      ]
    )
    diagnostics = StringIO.new

    text = OpenAI::Examples::Realtime::FunctionCalling.run(
      client: client,
      model: "gpt-realtime-2.1",
      prompt: prompt,
      output: diagnostics
    )

    assert_equal("It is clear and 18 C.", text)
    assert_equal(["gpt-realtime-2.1"], realtime.models)
    session = connection.session.calls.fetch(0)
    assert_equal(false, session.fetch(:parallel_tool_calls))
    assert_equal(
      {type: :function, name: OpenAI::Examples::Realtime::FunctionCalling::TOOL_NAME},
      session.fetch(:tool_choice)
    )
    assert_equal(1, session.fetch(:tools).length)
    assert_equal(prompt, connection.conversation.items.calls.fetch(0).dig(:content, 0, :text))

    tool_output = connection.conversation.items.calls.fetch(1)
    assert_equal(:function_call_output, tool_output.fetch(:type))
    assert_equal("call_1", tool_output.fetch(:call_id))
    assert_equal(
      {"city" => "Paris", "temperature_c" => 18, "conditions" => "clear"},
      JSON.parse(tool_output.fetch(:output))
    )
    assert_equal([{}, {tool_choice: :none}], connection.response.calls)
    assert_includes(diagnostics.string, "response.done status=completed")
    refute_includes(diagnostics.string, prompt)
    refute_includes(diagnostics.string, "Paris")
    refute_includes(diagnostics.string, text)
  end

  def test_rejects_response_done_before_function_arguments_complete
    error = run_error([response_done(id: "response_tool")])

    assert_equal("Realtime response completed without the required function call.", error.message)
  end

  def test_rejects_function_call_for_a_different_response
    error = run_error(
      [function_call(arguments: JSON.generate(city: "Paris")), response_done(id: "other_response")]
    )

    assert_equal("Realtime function call did not match response.done.", error.message)
  end

  def test_rejects_wrong_function_name_and_malformed_or_wrong_arguments
    wrong_name = run_error(
      [
        function_call(name: "private_unexpected_name", arguments: JSON.generate(city: "Paris")),
        response_done(id: "response_tool")
      ]
    )
    assert_equal("Realtime returned an unexpected function name.", wrong_name.message)
    refute_includes(wrong_name.message, "private_unexpected_name")

    ["{private malformed", JSON.generate(location: "Paris"), JSON.generate(city: "")].each do |arguments|
      error = run_error(
        [function_call(arguments: arguments), response_done(id: "response_tool")]
      )

      assert_equal("Realtime returned invalid function arguments.", error.message)
      refute_includes(error.message, arguments)
      assert_nil(error.cause)
    end
  end

  def test_rejects_api_errors_without_exposing_service_details
    error = run_error([api_error("private function payload")])

    assert_equal("Realtime API error.", error.message)
    refute_includes(error.message, "private function payload")
  end

  def test_requires_completed_initial_and_final_responses
    initial = run_error(
      [function_call(arguments: JSON.generate(city: "Paris")), response_done(id: "response_tool", status: :failed)]
    )
    assert_equal("Realtime response did not complete.", initial.message)

    final = run_error(
      [
        function_call(arguments: JSON.generate(city: "Paris")),
        response_done(id: "response_tool"),
        response_done(id: "response_final", status: :incomplete, text: "partial")
      ]
    )
    assert_equal("Realtime response did not complete.", final.message)
  end

  def test_rejects_premature_eof_in_each_response_phase
    initial = run_error([])
    assert_equal("Realtime connection closed before the function response.done.", initial.message)

    final = run_error(
      [function_call(arguments: JSON.generate(city: "Paris")), response_done(id: "response_tool")]
    )
    assert_equal("Realtime connection closed before the final response.done.", final.message)
  end

  def test_rejects_empty_final_output
    error = run_error(
      [
        function_call(arguments: JSON.generate(city: "Paris")),
        response_done(id: "response_tool"),
        response_done(id: "response_final", text: "  ")
      ]
    )

    assert_equal("Realtime final response completed without text output.", error.message)
  end

  private def run_error(events)
    client, = recording_client(events)
    assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::FunctionCalling.run(
        client: client,
        model: "gpt-realtime-2.1",
        prompt: "private prompt",
        output: StringIO.new
      )
    end
  end

  private def function_call(
    name: OpenAI::Examples::Realtime::FunctionCalling::TOOL_NAME,
    arguments:
  )
    OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent.new(
      arguments: arguments,
      call_id: "call_1",
      event_id: "event_call",
      item_id: "item_call",
      name: name,
      output_index: 0,
      response_id: "response_tool"
    )
  end
end
