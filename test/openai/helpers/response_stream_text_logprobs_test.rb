# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponseStreamTextLogprobsTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

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

  def test_normal_stream_preserves_text_event_logprobs_from_raw_stream
    stream = nil
    [nested_logprobs, [], nil].each do |logprobs|
      stub_normal_stream(logprobs:)
      raw_events = text_events(@client.responses.stream_raw(model: "test", input: "synthetic").to_a)

      stub_normal_stream(logprobs:)
      stream = @client.responses.stream(model: "test", input: "synthetic")
      events = text_events(stream.to_a)

      assert_text_events_preserve_logprobs(events, raw_events, snapshots: ["ok", "ok"])
      stream.close
      stream = nil
    end

  ensure
    stream&.close
  end

  def test_resumed_stream_preserves_text_event_logprobs_without_snapshots
    stream = nil
    [nested_logprobs, [], nil].each do |logprobs|
      stub_resumed_stream(logprobs:)
      raw_events = text_events(@client.responses.retrieve_streaming("resp_synthetic", starting_after: 2).to_a)

      stub_resumed_stream(logprobs:)
      stream = @client.responses.stream(response_id: "resp_synthetic", starting_after: 2)
      events = text_events(stream.to_a)

      assert_text_events_preserve_logprobs(events, raw_events, snapshots: [nil, "ok"])
      stream.close
      stream = nil
    end

  ensure
    stream&.close
  end

  private

  def assert_text_events_preserve_logprobs(events, raw_events, snapshots:)
    assert_equal(
      [:"response.output_text.delta", :"response.output_text.done"],
      events.map(&:type)
    )
    raw_logprobs = raw_events.map { |event| event.to_h[:logprobs] }
    assert_equal(raw_logprobs, events.map { |event| event.to_h[:logprobs] })
    assert_equal(["msg_synthetic", "msg_synthetic"], events.map(&:item_id))
    assert_equal([0, 0], events.map(&:output_index))
    assert_equal([0, 0], events.map(&:content_index))
    assert_equal([3, 4], events.map(&:sequence_number))
    assert_equal(snapshots, [events.fetch(0).snapshot, events.fetch(1).text])
    if raw_logprobs.fetch(0).nil?
      assert_nil(events.fetch(0).to_h[:logprobs])
      assert_nil(events.fetch(1).to_h[:logprobs])
      return
    end

    return if events.fetch(0).logprobs.empty?

    logprob = events.fetch(0).logprobs.fetch(0)
    assert_equal("ok", logprob.token)
    assert_equal(-0.25, logprob.logprob)
    assert_equal("okay", logprob.top_logprobs.fetch(0).token)
    assert_equal(-1.0, logprob.top_logprobs.fetch(0).logprob)
  end

  def text_events(events)
    events.grep(OpenAI::Models::Responses::ResponseTextDeltaEvent) +
      events.grep(OpenAI::Models::Responses::ResponseTextDoneEvent)
  end

  def stub_normal_stream(logprobs:)
    stub_request(:post, "http://localhost/responses").to_return(
      status: 200,
      headers: {"Content-Type" => "text/event-stream"},
      body: sse(normal_events(logprobs:))
    )
  end

  def stub_resumed_stream(logprobs:)
    stub_request(:get, "http://localhost/responses/resp_synthetic?starting_after=2&stream=true").to_return(
      status: 200,
      headers: {"Content-Type" => "text/event-stream"},
      body: sse(text_events_payload(logprobs:))
    )
  end

  def sse(events)
    events.map { |event| "event: #{event.fetch(:type)}\ndata: #{JSON.generate(event)}\n\n" }.join
  end

  def normal_events(logprobs:)
    events = [
      {type: "response.created", sequence_number: 0, response: response},
      {type: "response.output_item.added", sequence_number: 1, output_index: 0, item: message_item},
      {
        type: "response.content_part.added",
        sequence_number: 2,
        item_id: "msg_synthetic",
        output_index: 0,
        content_index: 0,
        part: {type: "output_text", text: "", annotations: [], logprobs: []}
      },
      *text_events_payload(logprobs:)
    ]
    events.each { |event| event[:logprobs] = logprobs unless logprobs.nil? }
    events
  end

  def text_events_payload(logprobs:)
    [
      {
        type: "response.output_text.delta",
        sequence_number: 3,
        item_id: "msg_synthetic",
        output_index: 0,
        content_index: 0,
        delta: "ok",
        logprobs: logprobs
      },
      {
        type: "response.output_text.done",
        sequence_number: 4,
        item_id: "msg_synthetic",
        output_index: 0,
        content_index: 0,
        text: "ok",
        logprobs: logprobs
      }
    ]
  end

  def nested_logprobs
    [{token: "ok", logprob: -0.25, top_logprobs: [{token: "okay", logprob: -1.0}]}]
  end

  def response
    {id: "resp_synthetic", object: "response", status: "in_progress", model: "test", output: []}
  end

  def message_item
    {id: "msg_synthetic", type: "message", role: "assistant", status: "in_progress", content: []}
  end
end
