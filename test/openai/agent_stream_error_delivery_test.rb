# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::AgentStreamErrorDeliveryTest < Minitest::Test
  class Body
    attr_reader :closed, :reads

    def initialize(events, named: false)
      @chunks = events.map do |event|
        event.is_a?(String) ? event : "#{named ? "event: #{event.fetch(:type)}\n" : ""}data: #{JSON.generate(event)}\n\n"
      end

      @reads = 0
    end

    def each
      @chunks.each do |chunk|
        @reads += 1
        yield chunk
      end
    end

    def close = @closed = true
  end

  class Server < OpenAI::HTTPClient
    attr_reader :body
    attr_accessor :error

    def initialize(events, named: false)
      super()
      @body = Body.new(events, named: named)
    end

    def execute(_request)
      raise @error if @error

      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "text/event-stream"},
        body: @body
      )
    end
  end

  # Customer subclasses may implement exactly the established six keywords.
  class CustomStream < OpenAI::Internal::Stream
    attr_reader :initialized

    def initialize(model:, url:, response_metadata:, response:, unwrap:, stream:)
      @initialized = true
      super
    end
  end

  def configure(events, named: false)
    @server = Server.new(events, named: named)
    @client = OpenAI::Client.new(api_key: "fake-key", http_client: @server, max_retries: 0)
  end

  def domain_error
    {
      type: "error",
      event_id: "event_error",
      session_id: "session_test",
      error: {code: "fixture_error", message: "Session reported an error."}
    }
  end

  def lifecycle
    {
      type: "agent.session.idle",
      event_id: "event_idle",
      session: {id: "session_test", status: "idle"}
    }
  end

  def open_stream(creation)
    sessions = @client.beta.agents.sessions
    if creation
      sessions.create_streaming(environment: {type: :none}, agent: {model: "test-model"}, input: "Hello")
    else
      sessions.events.stream_streaming("session_test")
    end
  end

  def test_agents_deliver_domain_errors_and_the_following_lifecycle_event
    [false, true].product([false, true]).each do |creation, named|
      configure([domain_error, lifecycle], named: named)
      stream = open_stream(creation)
      events = stream.to_a

      assert_equal([:error, :"agent.session.idle"], events.map(&:type))
      assert_instance_of(OpenAI::Models::Beta::AgentSessionErrorEvent, events.first)
      assert_instance_of(OpenAI::Models::Beta::AgentSessionIdleEvent, events.last)
      assert_equal("Session reported an error.", events.first.error.message)
      stream.close
      assert(@server.body.closed)
    end
  end

  def test_legacy_streams_still_raise_without_delivering_the_following_event
    [nil, :legacy].each do |mode|
      configure([domain_error, lifecycle])
      request = {method: :get, path: "legacy", stream: CustomStream}
      request[:stream_mode] = mode if mode
      stream = @client.request(request)
      assert_instance_of(CustomStream, stream)
      assert(stream.initialized)
      error = assert_raises(OpenAI::Errors::APIStatusError) { stream.to_a }
      assert_equal("Session reported an error.", error.message)
      assert_equal(1, @server.body.reads)
      stream.close
    end
  end

  def test_events_mode_preserves_the_custom_stream_class_and_strict_initializer
    configure([domain_error, lifecycle])
    stream = @client.request(
      method: :get,
      path: "events",
      stream: CustomStream,
      stream_mode: :events,
      model: OpenAI::Beta::AgentSessionEvent
    )

    assert_instance_of(CustomStream, stream)
    assert(stream.initialized)
    assert_same(stream, stream.set_stream_mode(:events))
    assert_equal([:error, :"agent.session.idle"], stream.to_a.map(&:type))
  ensure
    stream&.close
  end

  def test_events_mode_cancellation_does_not_read_later_events
    configure([domain_error, lifecycle])
    stream = open_stream(false)
    assert_equal(:error, stream.to_enum.next.type)
    stream.close

    assert_equal(1, @server.body.reads)
    assert(@server.body.closed)
  end

  def test_non_agents_streams_keep_legacy_error_behavior
    configure([domain_error, lifecycle])
    stream = @client.responses.stream_raw(model: "test-model", input: "Hello")

    assert_raises(OpenAI::Errors::APIStatusError) { stream.to_a }
    assert_equal(1, @server.body.reads)
  ensure
    stream&.close
  end

  def test_events_mode_keeps_json_and_transport_failures
    configure(["data: {invalid\n\n"])
    stream = open_stream(false)
    assert_raises(JSON::ParserError) { stream.to_a }
    stream.close

    configure([domain_error, lifecycle])
    @server.error = OpenAI::Errors::APIConnectionError.new(url: URI("https://sdk-test.example"))
    assert_raises(OpenAI::Errors::APIConnectionError) { open_stream(false).to_a }
  ensure
    stream&.close
  end

  def test_raw_http_response_keeps_the_original_sse_bytes
    wire = "event: error\ndata: #{JSON.generate(domain_error)}\n\n"
    configure([wire])
    response = @client.request(
      method: :get,
      path: "events",
      stream: CustomStream,
      stream_mode: :events,
      model: OpenAI::HTTPClient::Response
    )

    assert_instance_of(OpenAI::HTTPClient::Response, response)
    assert_equal(wire, response.body.to_a.join)
  end
end
