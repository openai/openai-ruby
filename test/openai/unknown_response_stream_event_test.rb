# frozen_string_literal: true

require_relative "test_helper"

# Unknown Responses events remain observable without being mistaken for known
# generated models or interfering with SDK-managed response accumulation.
class OpenAI::Test::UnknownResponseStreamEventTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  UNKNOWN_TYPE = "future.unmodeled.event"

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
    @client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-api-key")
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_stable_raw_stream_preserves_an_unknown_event
    stub_stream(:post, "/responses", events: [unknown_event])

    stream = @client.responses.stream_raw(input: "hello", model: "gpt-4o")
    event = stream.to_a.fetch(0)

    assert_unknown_event(event, union: OpenAI::Responses::ResponseStreamEvent)
  ensure
    stream&.close
  end

  def test_beta_raw_stream_preserves_an_unknown_event
    stub_stream(:post, "/responses", events: [unknown_event], query: {"beta" => "true"})

    stream = @client.beta.responses.stream_raw(input: "hello", model: "gpt-4o")
    event = stream.to_a.fetch(0)

    assert_unknown_event(event, union: OpenAI::Beta::BetaResponseStreamEvent)
  ensure
    stream&.close
  end

  def test_stable_retrieved_stream_preserves_an_unknown_event
    request = stub_stream(
      :get,
      "/responses/resp_unknown",
      events: [unknown_event],
      query: {"starting_after" => "7", "stream" => "true"}
    )

    stream = @client.responses.retrieve_streaming("resp_unknown", starting_after: 7)
    event = stream.to_a.fetch(0)

    assert_unknown_event(event, union: OpenAI::Responses::ResponseStreamEvent)
    assert_requested(request)
  ensure
    stream&.close
  end

  def test_beta_retrieved_stream_preserves_an_unknown_event
    request = stub_stream(
      :get,
      "/responses/resp_unknown",
      events: [unknown_event],
      query: {"beta" => "true", "stream" => "true"}
    )

    stream = @client.beta.responses.retrieve_streaming("resp_unknown")
    event = stream.to_a.fetch(0)

    assert_unknown_event(event, union: OpenAI::Beta::BetaResponseStreamEvent)
    assert_requested(request)
  ensure
    stream&.close
  end

  def test_helper_stream_passes_an_unknown_event_through_without_corrupting_completion
    stub_stream(
      :post,
      "/responses",
      events: [lifecycle_event("response.created", 1), unknown_event(sequence_number: 2), completed_event(3)]
    )

    stream = @client.responses.stream(input: "hello", model: "gpt-4o")
    events = stream.to_a

    assert_instance_of(OpenAI::Responses::ResponseCreatedEvent, events.fetch(0))
    assert_unknown_event(
      events.fetch(1),
      union: OpenAI::Responses::ResponseStreamEvent,
      sequence_number: 2
    )
    assert_instance_of(OpenAI::Streaming::ResponseCompletedEvent, events.fetch(2))
    assert_equal("resp_unknown", stream.get_final_response.id)
    assert_equal(:completed, stream.get_final_response.status)
  ensure
    stream&.close
  end

  def test_helper_stream_preserves_an_unknown_event_before_response_created
    stub_stream(
      :post,
      "/responses",
      events: [unknown_event(sequence_number: 0), lifecycle_event("response.created", 1), completed_event(2)]
    )

    stream = @client.responses.stream(input: "hello", model: "gpt-4o")
    events = stream.to_a

    assert_unknown_event(
      events.fetch(0),
      union: OpenAI::Responses::ResponseStreamEvent,
      sequence_number: 0
    )
    assert_instance_of(OpenAI::Responses::ResponseCreatedEvent, events.fetch(1))
    assert_instance_of(OpenAI::Streaming::ResponseCompletedEvent, events.fetch(2))
    assert_equal("resp_unknown", stream.get_final_response.id)
  ensure
    stream&.close
  end

  def test_helper_stream_passes_an_unknown_event_through_after_completion
    stub_stream(
      :post,
      "/responses",
      events: [lifecycle_event("response.created", 1), completed_event(2), unknown_event(sequence_number: 3)]
    )

    stream = @client.responses.stream(input: "hello", model: "gpt-4o")
    events = stream.to_a

    assert_instance_of(OpenAI::Streaming::ResponseCompletedEvent, events.fetch(1))
    assert_unknown_event(
      events.fetch(2),
      union: OpenAI::Responses::ResponseStreamEvent,
      sequence_number: 3
    )
    assert_equal("resp_unknown", stream.get_final_response.id)
  ensure
    stream&.close
  end

  def test_resumed_helper_filters_unknown_events_by_sequence_number
    stub_stream(
      :get,
      "/responses/resp_unknown",
      events: [
        unknown_event(sequence_number: 6),
        unknown_event(sequence_number: 8),
        completed_event(9)
      ],
      query: {"starting_after" => "7", "stream" => "true"}
    )

    stream = @client.responses.stream(response_id: "resp_unknown", starting_after: 7)
    events = stream.to_a

    assert_equal([8, 9], events.map(&:sequence_number))
    assert_unknown_event(
      events.fetch(0),
      union: OpenAI::Responses::ResponseStreamEvent,
      sequence_number: 8
    )
    assert_instance_of(OpenAI::Streaming::ResponseCompletedEvent, events.fetch(1))
  ensure
    stream&.close
  end

  def test_resumed_helper_preserves_an_unknown_event_without_a_sequence_number
    stub_stream(
      :get,
      "/responses/resp_unknown",
      events: [unknown_event(sequence_number: nil), completed_event(9)],
      query: {"starting_after" => "7", "stream" => "true"}
    )

    stream = @client.responses.stream(response_id: "resp_unknown", starting_after: 7)
    events = stream.to_a

    assert_unknown_event(
      events.fetch(0),
      union: OpenAI::Responses::ResponseStreamEvent,
      sequence_number: nil
    )
    assert_instance_of(OpenAI::Streaming::ResponseCompletedEvent, events.fetch(1))
  ensure
    stream&.close
  end

  def test_keepalive_is_filtered_while_other_unknown_events_are_preserved
    stub_stream(
      :post,
      "/responses",
      events: [{type: "keepalive", sequence_number: 8}, unknown_event]
    )

    stream = @client.responses.stream_raw(input: "hello", model: "gpt-4o")
    events = stream.to_a

    assert_equal(1, events.length)
    assert_unknown_event(events.fetch(0), union: OpenAI::Responses::ResponseStreamEvent)
  ensure
    stream&.close
  end

  def test_unknown_event_payload_is_deeply_immutable
    stub_stream(:post, "/responses", events: [unknown_event])

    stream = @client.responses.stream_raw(input: "hello", model: "gpt-4o")
    event = stream.to_a.fetch(0)

    assert_predicate(event, :frozen?)
    assert_predicate(event.data, :frozen?)
    assert_predicate(event.data.fetch(:details), :frozen?)
    assert_predicate(event.data.fetch(:details).fetch(:source), :frozen?)
  ensure
    stream&.close
  end

  def test_api_error_envelopes_are_not_treated_as_unknown_events
    event = {type: UNKNOWN_TYPE, error: {message: "synthetic streaming failure"}}
    stub_stream(:post, "/responses", events: [event])

    stream = @client.responses.stream_raw(input: "hello", model: "gpt-4o")
    error = assert_raises(OpenAI::Errors::APIStatusError) { stream.to_a }

    assert_equal("synthetic streaming failure", error.message)
  ensure
    stream&.close
  end

  def test_unknown_event_without_integer_sequence_preserves_original_payload
    event = unknown_event.merge(sequence_number: "future-sequence")
    stub_stream(:post, "/responses", events: [event])

    stream = @client.responses.stream_raw(input: "hello", model: "gpt-4o")
    decoded = stream.to_a.fetch(0)

    assert_instance_of(OpenAI::Streaming::UnknownStreamEvent, decoded)
    assert_nil(decoded.sequence_number)
    assert_equal(event, decoded.data)
  ensure
    stream&.close
  end

  private

  def assert_unknown_event(event, union:, sequence_number: 9)
    assert_instance_of(OpenAI::Streaming::UnknownStreamEvent, event)
    refute_includes(union.variants, event.class)
    assert_equal(UNKNOWN_TYPE.to_sym, event.type)
    if sequence_number.nil?
      assert_nil(event.sequence_number)
    else
      assert_equal(sequence_number, event.sequence_number)
    end

    assert_equal(unknown_event(sequence_number: sequence_number), event.data)
    assert_equal(event.data, event.to_h)
  end

  def unknown_event(sequence_number: 9)
    event = {type: UNKNOWN_TYPE, details: {source: "synthetic"}}
    event[:sequence_number] = sequence_number unless sequence_number.nil?
    event
  end

  def completed_event(sequence_number) = lifecycle_event("response.completed", sequence_number)

  def lifecycle_event(type, sequence_number)
    status = type == "response.created" ? "in_progress" : "completed"

    {
      type: type,
      sequence_number: sequence_number,
      response: {
        id: "resp_unknown",
        object: "response",
        status: status,
        status_details: nil,
        output: [],
        usage: nil,
        metadata: nil
      }
    }
  end

  def stub_stream(method, path, events:, query: nil)
    body = events
      .map do |event|
        "event: #{event.fetch(:type)}\ndata: #{JSON.generate(event)}\n\n"
      end
      .join

    request = stub_request(method, "http://localhost#{path}")
    request = request.with(query: query) if query
    request.to_return(status: 200, headers: {"Content-Type" => "text/event-stream"}, body: body)
  end
end
