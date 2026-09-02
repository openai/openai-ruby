# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::StreamingPreviousResponseExampleTest < Minitest::Test
  extend Minitest::Serial

  EXAMPLE_PATH = File.expand_path("../../examples/responses/streaming_previous_response.rb", __dir__)

  def setup
    super
    @mocks = []
    @sleeps = []
    Thread.current.thread_variable_set(:mock_sleep, @sleeps)
  end

  def teardown
    Thread.current.thread_variable_set(:mock_sleep, nil)
    super
  end

  def test_plain_stream_fails_before_waiting_when_initial_stream_is_empty
    _stdout, stderr, error, requests = run_example([{stream: []}])

    assert_failure(error, stderr, "The initial stream completed without events")
    assert_equal(1, requests.length)
    assert_empty(@sleeps)
  end

  def test_plain_stream_fails_before_waiting_when_created_event_is_missing
    _stdout, stderr, error, requests = run_example([{stream: [in_progress_event(sequence_number: 1)]}])

    assert_failure(error, stderr, "The initial stream did not include a response ID")
    assert_equal(1, requests.length)
    assert_empty(@sleeps)
  end

  def test_plain_stream_fails_before_waiting_when_response_id_is_empty
    _stdout, stderr, error, requests = run_example([{stream: [created_event(id: "", sequence_number: 1)]}])

    assert_failure(error, stderr, "The initial stream did not include a response ID")
    assert_equal(1, requests.length)
    assert_empty(@sleeps)
  end

  def test_structured_stream_fails_before_waiting_when_initial_stream_is_empty
    streams = plain_successful_streams + [{stream: []}]
    _stdout, stderr, error, requests = run_example(streams)

    assert_failure(error, stderr, "The structured initial stream completed without events")
    assert_equal(3, requests.length)
    assert_equal([3], @sleeps)
  end

  def test_structured_stream_fails_before_waiting_when_created_event_is_missing
    streams = plain_successful_streams + [{stream: [in_progress_event(sequence_number: 7)]}]
    _stdout, stderr, error, requests = run_example(streams)

    assert_failure(error, stderr, "The structured initial stream did not include a response ID")
    assert_equal(3, requests.length)
    assert_equal([3], @sleeps)
  end

  def test_structured_stream_fails_before_waiting_when_response_id_is_empty
    streams = plain_successful_streams + [{stream: [created_event(id: "", sequence_number: 7)]}]
    _stdout, stderr, error, requests = run_example(streams)

    assert_failure(error, stderr, "The structured initial stream did not include a response ID")
    assert_equal(3, requests.length)
    assert_equal([3], @sleeps)
  end

  def test_both_streams_resume_with_captured_ids_and_preserve_structured_output
    structured_stream = Minitest::Mock.new
    final_response = Minitest::Mock.new
    output_message = Minitest::Mock.new
    output_content = Minitest::Mock.new
    @mocks.push(structured_stream, final_response, output_message, output_content)

    structured_stream.expect(:each, nil) do |&callback|
      callback.call(in_progress_event(sequence_number: 8))
      true
    end

    structured_stream.expect(:get_final_response, final_response)
    final_response.expect(:output, [output_message])
    output_message.expect(:content, [output_content])

    streams = plain_successful_streams +
      [
        {stream: [created_event(id: "resp_structured", sequence_number: 7)]},
        {
          stream: structured_stream,
          check: lambda do |params|
            assert_equal("resp_structured", params.fetch(:response_id))
            assert_equal(7, params.fetch(:starting_after))

            math_response = params.fetch(:text).new(steps: [], final_answer: "-29/8")
            output_content.expect(:parsed, math_response)
          end
        }
      ]

    stdout, stderr, error, requests = run_example(streams)

    assert_nil(error)
    assert_empty(stderr)
    assert_equal(4, requests.length)
    assert_equal([3, 3], @sleeps)
    assert_includes(stdout, "Verified it is greater than the last usable initial sequence: 1")
    assert_includes(stdout, "-29/8")
  end

  def test_both_streams_resume_after_last_usable_sequence_with_unknown_events
    structured_stream = Minitest::Mock.new
    final_response = Minitest::Mock.new
    output_message = Minitest::Mock.new
    output_content = Minitest::Mock.new
    @mocks.push(structured_stream, final_response, output_message, output_content)

    structured_stream.expect(:each, nil) do |&callback|
      callback.call(unknown_event)
      callback.call(in_progress_event(sequence_number: 10))
      true
    end

    structured_stream.expect(:get_final_response, final_response)
    final_response.expect(:output, [output_message])
    output_message.expect(:content, [output_content])

    streams = [
      {
        stream: [
          created_event(id: "resp_plain", sequence_number: 1),
          unknown_event(sequence_number: 4),
          unknown_event
        ]
      },
      {
        stream: [unknown_event, in_progress_event(sequence_number: 5)],
        check: lambda do |params|
          assert_equal("resp_plain", params.fetch(:response_id))
          assert_equal(4, params.fetch(:starting_after))
        end
      },
      {
        stream: [
          created_event(id: "resp_structured", sequence_number: 7),
          unknown_event(sequence_number: 9),
          unknown_event
        ]
      },
      {
        stream: structured_stream,
        check: lambda do |params|
          assert_equal("resp_structured", params.fetch(:response_id))
          assert_equal(9, params.fetch(:starting_after))

          math_response = params.fetch(:text).new(steps: [], final_answer: "-29/8")
          output_content.expect(:parsed, math_response)
        end
      }
    ]

    stdout, stderr, error, requests = run_example(streams)

    assert_nil(error)
    assert_empty(stderr)
    assert_equal(4, requests.length)
    assert_equal([3, 3], @sleeps)
    assert_includes(stdout, "Event from resumed stream: future.unmodeled.event (seq: )")
    assert_includes(stdout, "First resumed event sequence: 5")
    assert_includes(stdout, "Verified it is greater than the last usable initial sequence: 4")
    assert_includes(stdout, "-29/8")
  end

  def test_plain_stream_fails_clearly_when_resumed_events_have_no_sequence
    streams = [
      {stream: [created_event(id: "resp_plain", sequence_number: 1)]},
      {stream: [unknown_event]}
    ]

    _stdout, stderr, error, requests = run_example(streams)

    assert_failure(error, stderr, "The resumed stream did not include an event with a sequence number")
    assert_equal(2, requests.length)
    assert_equal([3], @sleeps)
  end

  private

  def run_example(streams)
    responses = Minitest::Mock.new
    client = Minitest::Mock.new
    @mocks.push(responses, client)
    requests = []

    streams.each do |entry|
      client.expect(:responses, responses)
      responses.expect(:stream, entry.fetch(:stream)) do |**params|
        requests << params
        entry[:check]&.call(params)
        true
      end
    end

    exit_error = nil
    stdout, stderr = capture_io do
      OpenAI::Client.stub(:new, client) do
        load(EXAMPLE_PATH, true)
      rescue SystemExit => error
        exit_error = error
      end
    end

    @mocks.each(&:verify)

    [stdout, stderr, exit_error, requests]
  end

  def plain_successful_streams
    [
      {stream: [created_event(id: "resp_plain", sequence_number: 1)]},
      {
        stream: [in_progress_event(sequence_number: 2)],
        check: lambda do |params|
          assert_equal("resp_plain", params.fetch(:response_id))
          assert_equal(1, params.fetch(:starting_after))
        end
      }
    ]
  end

  def created_event(id:, sequence_number:)
    response = OpenAI::Models::Responses::Response.new(id: id)
    OpenAI::Models::Responses::ResponseCreatedEvent.new(response: response, sequence_number: sequence_number)
  end

  def in_progress_event(sequence_number:)
    OpenAI::Models::Responses::ResponseInProgressEvent.new(response: {}, sequence_number: sequence_number)
  end

  def unknown_event(sequence_number: nil)
    data = {type: "future.unmodeled.event"}
    data[:sequence_number] = sequence_number unless sequence_number.nil?
    OpenAI::Streaming::UnknownStreamEvent.new(data: data)
  end

  def assert_failure(error, stderr, message)
    assert_instance_of(SystemExit, error)
    assert_equal(1, error.status)
    assert_equal("#{message}\n", stderr)
  end
end
