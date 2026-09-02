# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::StructuredResponseExampleVariantsTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  STREAMING_EXAMPLE_PATH = File.expand_path(
    "../../examples/responses/streaming_structured_outputs.rb",
    __dir__
  )
  PREVIOUS_RESPONSE_EXAMPLE_PATH = File.expand_path(
    "../../examples/responses/streaming_previous_response.rb",
    __dir__
  )
  NONSTREAMING_EXAMPLE_PATH = File.expand_path(
    "../../examples/structured_outputs_responses.rb",
    __dir__
  )

  def setup
    super
    WebMock.enable!
    WebMock.disable_net_connect!
    @previous_api_key = ENV["OPENAI_API_KEY"]
    ENV["OPENAI_API_KEY"] = "synthetic-test-key"
    @sleeps = []
    Thread.current.thread_variable_set(:mock_sleep, @sleeps)
  end

  def teardown
    Thread.current.thread_variable_set(:mock_sleep, nil)
    @previous_api_key ? ENV["OPENAI_API_KEY"] = @previous_api_key : ENV.delete("OPENAI_API_KEY")
    WebMock.allow_net_connect!
    WebMock.disable!
    WebMock.reset!
    super
  end

  def test_streaming_example_prints_typed_output_after_reasoning_and_refusal
    stdout, stderr, error = run_streaming_example(
      [reasoning_item, message(refusal_content, math_content)]
    )

    assert_nil(error)
    assert_empty(stderr)
    assert_includes(stdout, "MathResponse")
    assert_includes(stdout, "-29/8")
  end

  def test_streaming_example_keeps_clear_failure_for_refusal_only_output
    _stdout, stderr, error = run_streaming_example([message(refusal_content)])

    assert_failure(error, stderr, "The final response did not contain a parsed MathResponse")
  end

  def test_streaming_example_keeps_clear_failure_for_unparsed_text
    _stdout, stderr, error = run_streaming_example([message(unparsed_content)])

    assert_failure(error, stderr, "The final response did not contain a parsed MathResponse")
  end

  def test_previous_response_example_prints_typed_output_after_reasoning_and_refusal
    stdout, stderr, error = run_previous_response_example(
      [reasoning_item, message(refusal_content, math_content)]
    )

    assert_nil(error)
    assert_empty(stderr)
    assert_equal([3, 3], @sleeps)
    assert_includes(stdout, "MathResponse")
    assert_includes(stdout, "-29/8")
  end

  def test_previous_response_example_keeps_clear_failure_for_refusal_only_output
    _stdout, stderr, error = run_previous_response_example([message(refusal_content)])

    assert_failure(error, stderr, "The resumed response did not contain a parsed MathResponse")
  end

  def test_previous_response_example_keeps_clear_failure_for_unparsed_text
    _stdout, stderr, error = run_previous_response_example([message(unparsed_content)])

    assert_failure(error, stderr, "The resumed response did not contain a parsed MathResponse")
  end

  def test_nonstreaming_example_prints_typed_output_after_reasoning_and_refusal
    stdout, stderr, error = run_nonstreaming_example(
      [reasoning_item, message(refusal_content, calendar_content)]
    )

    assert_nil(error)
    assert_empty(stderr)
    assert_includes(stdout, "CalendarEvent")
    assert_includes(stdout, "Science fair")
  end

  def test_nonstreaming_example_keeps_refusal_only_output_silent
    stdout, stderr, error = run_nonstreaming_example([message(refusal_content)])

    assert_nil(error)
    assert_empty(stdout)
    assert_empty(stderr)
  end

  def test_nonstreaming_example_keeps_unparsed_text_silent
    stdout, stderr, error = run_nonstreaming_example([message(unparsed_content)])

    assert_nil(error)
    assert_empty(stdout)
    assert_empty(stderr)
  end

  private

  def run_streaming_example(output)
    response = response(output)
    stub_request(:post, "https://api.openai.com/v1/responses")
      .to_return(sse_response(stream_events(response)))

    load_example(STREAMING_EXAMPLE_PATH)
  end

  def run_previous_response_example(output)
    plain_response = response([], id: "resp_plain")
    structured_response = response(output, id: "resp_structured")

    stub_request(:post, "https://api.openai.com/v1/responses")
      .to_return(
        sse_response([created_event(plain_response)]),
        sse_response([created_event(structured_response)])
      )
    stub_request(:get, "https://api.openai.com/v1/responses/resp_plain")
      .with(query: {"starting_after" => "0", "stream" => "true"})
      .to_return(sse_response([completed_event(plain_response)]))
    stub_request(:get, "https://api.openai.com/v1/responses/resp_structured")
      .with(query: {"starting_after" => "0", "stream" => "true"})
      .to_return(sse_response([completed_event(structured_response)]))

    load_example(PREVIOUS_RESPONSE_EXAMPLE_PATH)
  end

  def run_nonstreaming_example(output)
    stub_request(:post, "https://api.openai.com/v1/responses")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "application/json"},
        body: JSON.generate(response(output))
      )

    load_example(NONSTREAMING_EXAMPLE_PATH)
  end

  def load_example(path)
    error = nil
    stdout, stderr = capture_io do
      load(path, true)
    rescue SystemExit => exception
      error = exception
    end

    [stdout, stderr, error]
  end

  def response(output, id: "resp_synthetic")
    {id: id, object: "response", model: "test", status: "completed", output: output}
  end

  def stream_events(response)
    [created_event(response), completed_event(response)]
  end

  def created_event(response)
    {
      type: "response.created",
      sequence_number: 0,
      response: response.merge(status: "in_progress", output: [])
    }
  end

  def completed_event(response)
    {type: "response.completed", sequence_number: 1, response: response}
  end

  def sse_response(events)
    body = events.map { |event| "event: #{event.fetch(:type)}\ndata: #{JSON.generate(event)}\n\n" }.join
    {status: 200, headers: {"Content-Type" => "text/event-stream"}, body: body}
  end

  def reasoning_item
    {id: "reasoning_synthetic", type: "reasoning", summary: []}
  end

  def message(*content)
    {
      id: "msg_synthetic",
      type: "message",
      role: "assistant",
      status: "completed",
      content: content
    }
  end

  def refusal_content
    {type: "refusal", refusal: "Synthetic refusal"}
  end

  def math_content
    output_text(steps: [], final_answer: "-29/8")
  end

  def unparsed_content
    {type: "output_text", text: "null", annotations: [], logprobs: []}
  end

  def calendar_content
    output_text(
      name: "Science fair",
      date: "2026-09-04",
      participants: [],
      optional_participants: nil,
      is_virtual: false,
      location: "123 Main St."
    )
  end

  def output_text(value)
    {
      type: "output_text",
      text: JSON.generate(value),
      annotations: [],
      logprobs: []
    }
  end

  def assert_failure(error, stderr, message)
    assert_instance_of(SystemExit, error)
    assert_equal(1, error.status)
    assert_equal("#{message}\n", stderr)
  end
end
