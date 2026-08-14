# frozen_string_literal: true

require "async/http/server"
require "async/queue"
require "async/websocket/adapters/http"
require "async/websocket/client"
require "async/websocket/server"
require "socket"

require_relative "../test_helper"

class OpenAI::Test::AsyncWebSocketTransportTest < Minitest::Test
  extend Minitest::Serial

  class SynchronousConnection
    attr_reader :scheduler

    def initialize
      @closed = false
      @scheduler = nil
    end

    def connect!
      @scheduler = Fiber.scheduler
      self
    end

    def read = "message"
    def write(_message) = nil
    def flush = nil
    def closed? = @closed
    def close(*) = (@closed = true)
  end

  class SynchronousClient
    attr_reader :closed

    def initialize(connection)
      @connection = connection
      @closed = false
    end

    def connect(*) = @connection.connect!
    def close = (@closed = true)
  end

  class FailingSynchronousClient < SynchronousClient
    def connect(*) = raise(IOError, "handshake failed")
  end

  class FailingCloseSynchronousConnection < SynchronousConnection
    attr_reader :close_count

    def initialize
      super
      @close_count = 0
    end

    def close(*)
      @close_count += 1
      super
      raise IOError, "connection close failed"
    end
  end

  class FailingCloseSynchronousClient < SynchronousClient
    attr_reader :close_count

    def initialize(connection)
      super
      @close_count = 0
    end

    def close
      @close_count += 1
      super
      raise IOError, "client close failed"
    end
  end

  def test_default_transport_enters_a_reactor_for_synchronous_callers
    assert_nil(Fiber.scheduler)
    connection = SynchronousConnection.new
    client = SynchronousClient.new(connection)
    transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
    url = URI("wss://example.com/v1/realtime?model=gpt-realtime-2.1")

    result = Async::WebSocket::Client.stub(:open, client) do
      transport.open(url: url, headers: {}, timeout: nil) do |socket|
        [socket.read, Fiber.scheduler]
      end
    end

    assert_equal("message", result.fetch(0))
    assert_same(connection.scheduler, result.fetch(1))
    refute_nil(connection.scheduler)
    assert_predicate(connection, :closed?)
    assert_predicate(client, :closed)
    assert_nil(Fiber.scheduler)
  end

  def test_default_transport_closes_the_client_after_a_handshake_failure
    connection = SynchronousConnection.new
    client = FailingSynchronousClient.new(connection)
    transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
    url = URI("wss://example.com/v1/realtime?model=gpt-realtime-2.1")

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      Async::WebSocket::Client.stub(:open, client) do
        transport.open(url: url, headers: {}, timeout: nil) { |_socket| nil }
      end
    end

    assert_instance_of(IOError, error.cause)
    assert_predicate(client, :closed)
  end

  def test_default_transport_preserves_block_errors_when_all_cleanup_fails
    connection = FailingCloseSynchronousConnection.new
    transport_client = FailingCloseSynchronousClient.new(connection)
    sdk_client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1"
    )

    error = assert_raises(RuntimeError) do
      Async::WebSocket::Client.stub(:open, transport_client) do
        sdk_client.realtime.connect(model: "gpt-realtime-2.1") do |_realtime|
          raise "application failed"
        end
      end
    end

    assert_equal("application failed", error.message)
    assert_equal(2, connection.close_count)
    assert_equal(1, transport_client.close_count)
    assert_predicate(connection, :closed?)
    assert_predicate(transport_client, :closed)
  end

  def test_default_transport_surfaces_the_first_cleanup_error_after_success
    connection = FailingCloseSynchronousConnection.new
    client = FailingCloseSynchronousClient.new(connection)
    transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
    url = URI("wss://example.com/v1/realtime?model=gpt-realtime-2.1")

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      Async::WebSocket::Client.stub(:open, client) do
        transport.open(url: url, headers: {}, timeout: nil) { |_socket| :done }
      end
    end

    assert_equal("connection close failed", error.cause.message)
    assert_equal(1, connection.close_count)
    assert_equal(1, client.close_count)
    assert_predicate(connection, :closed?)
    assert_predicate(client, :closed)
  end

  def test_default_transport_exchanges_events_with_a_local_websocket_server
    port = available_port
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = ->(_request) { Protocol::HTTP::Response[404, {}, []] }
    websocket = Async::WebSocket::Server.new(fallback) do |connection|
      message = connection.read
      next if message.nil?

      event = JSON.parse(message.to_str)
      raise "unexpected client event" unless event.fetch("type") == "session.update"

      connection.write(
        Protocol::WebSocket::TextMessage.generate(
          type: "response.output_text.delta",
          event_id: "event_1",
          response_id: "response_1",
          item_id: "item_1",
          output_index: 0,
          content_index: 0,
          delta: "hello over websocket"
        )
      )
      connection.flush
    end
    server = Async::HTTP::Server.new(websocket, endpoint)

    Sync do |task|
      server_task = task.async { server.run.wait }
      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "http://127.0.0.1:#{port}/v1",
        timeout: 5
      )

      event = client.realtime.connect(model: "gpt-realtime") do |connection|
        connection.session.update(type: :realtime)
        connection.receive
      end

      assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, event)
      assert_equal("hello over websocket", event.delta)
      assert_application_errors_propagate(client)
    ensure
      server_task&.stop
    end
  end

  def test_documented_text_lifecycle_over_a_local_websocket
    with_websocket_server(method(:serve_text_lifecycle)) do |_task, client|
      client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
        assert_instance_of(OpenAI::Realtime::SessionCreatedEvent, connection.receive)
        connection.session.update(type: :realtime, output_modalities: [:text])
        assert_instance_of(OpenAI::Realtime::SessionUpdatedEvent, connection.receive)

        connection.conversation.items.create(
          type: :message,
          role: :user,
          content: [{type: :input_text, text: "Say hello."}]
        )
        connection.response.create

        delta = connection.receive
        done = connection.receive
        assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, delta)
        assert_equal("hello from the local service", delta.delta)
        assert_instance_of(OpenAI::Realtime::ResponseDoneEvent, done)
        assert_equal(:completed, done.response.status)
        assert_nil(connection.receive)
      end
    end
  end

  def test_function_call_round_trip_over_a_local_websocket
    handler = lambda do |connection|
      unless read_event(connection).fetch("type") == "conversation.item.create"
        raise "expected conversation item"
      end
      raise "expected response.create" unless read_event(connection).fetch("type") == "response.create"

      write_event(
        connection,
        type: "response.function_call_arguments.done",
        event_id: "event_call",
        response_id: "response_1",
        item_id: "item_call",
        output_index: 0,
        call_id: "call_1",
        name: "get_weather",
        arguments: JSON.generate(location: "Paris")
      )

      output = read_event(connection)
      raise "expected function output" unless output.dig("item", "type") == "function_call_output"
      raise "unexpected call id" unless output.dig("item", "call_id") == "call_1"
      raise "expected follow-up response" unless read_event(connection).fetch("type") == "response.create"

      write_event(
        connection,
        type: "response.done",
        event_id: "event_done",
        response: {id: "response_2", status: "completed", output: []}
      )
    end

    with_websocket_server(handler) do |_task, client|
      client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
        connection.conversation.items.create(
          type: :message,
          role: :user,
          content: [{type: :input_text, text: "What is the weather?"}]
        )
        connection.response.create

        call = connection.receive
        assert_instance_of(OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent, call)
        connection.conversation.items.create_function_call_output(
          call_id: call.call_id,
          output: JSON.generate(temperature_c: 18)
        )
        connection.response.create

        done = connection.receive
        assert_instance_of(OpenAI::Realtime::ResponseDoneEvent, done)
        assert_equal(:completed, done.response.status)
      end
    end
  end

  def test_mcp_approval_lifecycle_over_a_local_websocket
    with_websocket_server(method(:serve_mcp_approval)) do |_task, client|
      client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
        exercise_mcp_approval(connection)
      end
    end
  end

  def test_translation_reads_output_while_input_is_still_streaming
    first_audio = "\x00\x01".b * 4_800
    second_audio = "\x02\x03".b * 4_800
    translated_audio = "\x04\x05".b * 4_800
    handler = lambda do |connection|
      serve_translation(connection, first_audio:, second_audio:, translated_audio:)
    end

    with_websocket_server(handler) do |task, client|
      client.realtime.translations.connect(model: "gpt-realtime-translate") do |connection|
        connection.session.update(audio: {output: {language: "es"}})
        events = Async::Queue.new
        reader = task.async do
          connection.each do |event|
            events.enqueue(event)
            break if event.is_a?(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent)
          end
        end

        connection.input_audio_buffer.append_bytes(first_audio)
        transcript = events.dequeue
        audio = events.dequeue
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent, transcript)
        assert_equal("hola", transcript.delta)
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent, audio)
        assert_equal(translated_audio, Base64.strict_decode64(audio.delta))

        connection.input_audio_buffer.append_bytes(second_audio)
        connection.session.close
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent, events.dequeue)
        reader.wait
      end
    end
  end

  def test_documented_transcription_lifecycle_over_a_local_websocket
    audio = "\x00\x01".b * 2_400
    handler = ->(connection) { serve_transcription(connection, audio: audio) }

    with_websocket_server(handler) do |_task, client|
      exercise_transcription(client, audio: audio)
    end
  end

  def test_default_transport_reassembles_fragmented_text_messages
    handler = lambda do |connection|
      payload = JSON.generate(
        type: "response.output_text.delta",
        event_id: "event_fragmented",
        response_id: "response_1",
        item_id: "item_1",
        output_index: 0,
        content_index: 0,
        delta: "fragmented"
      )
      midpoint = payload.bytesize / 2
      first = Protocol::WebSocket::TextFrame.new(false).pack(payload.byteslice(0, midpoint))
      second = Protocol::WebSocket::ContinuationFrame.new(true).pack(payload.byteslice(midpoint..))
      connection.write_frame(first)
      connection.write_frame(second)
      connection.flush
    end

    with_websocket_server(handler) do |_task, client|
      event = client.realtime.connect(model: "gpt-realtime-2.1", &:receive)

      assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, event)
      assert_equal("fragmented", event.delta)
    end
  end

  def test_request_timeout_does_not_expire_an_established_websocket
    handler = lambda do |connection|
      sleep(0.5)
      write_event(
        connection,
        type: "response.output_text.delta",
        event_id: "event_after_idle",
        response_id: "response_1",
        item_id: "item_1",
        output_index: 0,
        content_index: 0,
        delta: "still connected"
      )
    end

    with_websocket_server(handler, timeout: 0.25) do |_task, client|
      event = client.realtime.connect(model: "gpt-realtime-2.1", &:receive)

      assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, event)
      assert_equal("still connected", event.delta)
    end
  end

  def test_request_timeout_still_bounds_websocket_negotiation
    server = TCPServer.new("127.0.0.1", 0)
    release_server = Queue.new
    server_thread = Thread.new do
      socket = server.accept
      socket.readpartial(4_096)
      release_server.pop
    rescue IOError, SystemCallError
      nil
    ensure
      socket&.close
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://127.0.0.1:#{server.local_address.ip_port}/v1",
      timeout: 0.1
    )

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      client.realtime.connect(model: "gpt-realtime-2.1") { |_connection| nil }
    end

    assert_instance_of(Async::TimeoutError, error.cause)
  ensure
    release_server&.push(true)
    server&.close
    server_thread&.join
  end

  def test_default_transport_wraps_an_abnormal_remote_close
    handler = ->(connection) { connection.close(1011, "service failed") }

    with_websocket_server(handler) do |_task, client|
      error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
        client.realtime.connect(model: "gpt-realtime-2.1", &:receive)
      end

      assert_instance_of(Protocol::WebSocket::ClosedError, error.cause)
      assert_includes(error.message, "service failed")
    end
  end

  def test_default_transport_wraps_handshake_failures
    port = available_port
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://127.0.0.1:#{port}/v1",
      timeout: 0.5
    )

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      client.realtime.connect(model: "gpt-realtime") { |_connection| nil }
    end

    assert_equal("ws://127.0.0.1:#{port}/v1/realtime?model=gpt-realtime", error.url.to_s)
    refute_nil(error.cause)
    assert_includes(error.message, error.cause.message)
  end

  def test_missing_optional_dependency_preserves_load_error_as_the_cause
    transport_class = Class.new(OpenAI::Realtime::Transports::AsyncWebSocket) do
      private def require(path)
        raise LoadError, "cannot load #{path}" if path == "async/websocket/client"

        super
      end
    end
    url = URI("wss://example.com/v1/realtime?model=gpt-realtime-2.1")

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      transport_class.new.open(url:, headers: {}, timeout: 1) { |_socket| nil }
    end

    assert_instance_of(LoadError, error.cause)
    assert_includes(error.message, "Add `gem \"async-websocket\"` to your Gemfile")
  end

  private def assert_application_errors_propagate(client)
    error = assert_raises(RuntimeError) do
      client.realtime.connect(model: "gpt-realtime") do |_connection|
        raise "application failed"
      end
    end
    assert_equal("application failed", error.message)

    load_error = assert_raises(LoadError) do
      client.realtime.connect(model: "gpt-realtime") do |_connection|
        raise LoadError, "application dependency failed"
      end
    end
    assert_equal("application dependency failed", load_error.message)
  end

  private def serve_text_lifecycle(connection)
    write_event(
      connection,
      type: "session.created",
      event_id: "event_created",
      session: {type: "realtime"}
    )

    update = read_event(connection)
    raise "expected session.update" unless update.fetch("type") == "session.update"
    write_event(
      connection,
      type: "session.updated",
      event_id: "event_updated",
      session: update.fetch("session")
    )

    unless read_event(connection).fetch("type") == "conversation.item.create"
      raise "expected conversation item"
    end
    raise "expected response.create" unless read_event(connection).fetch("type") == "response.create"
    write_event(
      connection,
      type: "response.output_text.delta",
      event_id: "event_delta",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0,
      delta: "hello from the local service"
    )
    write_event(
      connection,
      type: "response.done",
      event_id: "event_done",
      response: {id: "response_1", status: "completed", output: []}
    )
  end

  private def serve_mcp_approval(connection)
    update = read_event(connection)
    raise "expected MCP session update" unless update.dig("session", "tools", 0, "type") == "mcp"
    write_event(
      connection,
      type: "mcp_list_tools.completed",
      event_id: "event_tools",
      item_id: "item_tools"
    )

    raise "expected prompt item" unless read_event(connection).fetch("type") == "conversation.item.create"
    raise "expected response.create" unless read_event(connection).fetch("type") == "response.create"
    write_event(
      connection,
      type: "conversation.item.done",
      event_id: "event_approval",
      previous_item_id: nil,
      item: {
        type: "mcp_approval_request",
        id: "approval_1",
        arguments: JSON.generate(date: "tomorrow"),
        name: "check_calendar",
        server_label: "calendar"
      }
    )

    approval = read_event(connection)
    raise "expected approval response" unless approval.dig("item", "type") == "mcp_approval_response"
    raise "unexpected approval id" unless approval.dig("item", "approval_request_id") == "approval_1"
    raise "expected approval" unless approval.dig("item", "approve")
    write_event(
      connection,
      type: "response.done",
      event_id: "event_done",
      response: {id: "response_1", status: "completed", output: []}
    )
  end

  private def exercise_mcp_approval(connection)
    connection.session.update(
      type: :realtime,
      tools: [
        {
          type: :mcp,
          server_label: "calendar",
          server_url: "https://example.com/mcp",
          require_approval: :always
        }
      ]
    )

    assert_instance_of(OpenAI::Realtime::McpListToolsCompleted, connection.receive)
    connection.conversation.items.create(
      type: :message,
      role: :user,
      content: [{type: :input_text, text: "Check tomorrow's calendar."}]
    )
    connection.response.create

    approval = connection.receive
    assert_instance_of(OpenAI::Realtime::ConversationItemDone, approval)
    assert_instance_of(OpenAI::Realtime::RealtimeMcpApprovalRequest, approval.item)
    connection.conversation.items.respond_to_mcp_approval(
      approval_request_id: approval.item.id,
      approve: true,
      reason: "Allowed by test policy"
    )

    done = connection.receive
    assert_instance_of(OpenAI::Realtime::ResponseDoneEvent, done)
    assert_equal(:completed, done.response.status)
  end

  private def serve_translation(connection, first_audio:, second_audio:, translated_audio:)
    raise "expected translation update" unless read_event(connection).fetch("type") == "session.update"
    first_append = read_event(connection)
    unless first_append.fetch("type") == "session.input_audio_buffer.append"
      raise "expected first audio frame"
    end
    raise "unexpected first audio" unless Base64.strict_decode64(first_append.fetch("audio")) == first_audio

    write_event(
      connection,
      type: "session.output_transcript.delta",
      event_id: "event_transcript",
      delta: "hola",
      elapsed_ms: 200
    )
    write_event(
      connection,
      type: "session.output_audio.delta",
      event_id: "event_audio",
      delta: Base64.strict_encode64(translated_audio),
      elapsed_ms: 200,
      format: "pcm16",
      sample_rate: 24_000,
      channels: 1
    )

    second_append = read_event(connection)
    unless second_append.fetch("type") == "session.input_audio_buffer.append"
      raise "expected second audio frame"
    end
    unless Base64.strict_decode64(second_append.fetch("audio")) == second_audio
      raise "unexpected second audio"
    end
    raise "expected session.close" unless read_event(connection).fetch("type") == "session.close"

    write_event(connection, type: "session.closed", event_id: "event_closed")
  end

  private def serve_transcription(connection, audio:)
    write_event(
      connection,
      type: "session.created",
      event_id: "event_created",
      session: {type: "transcription"}
    )

    update = read_event(connection)
    raise "expected transcription session update" unless update.fetch("type") == "session.update"

    write_event(
      connection,
      type: "session.updated",
      event_id: "event_updated",
      session: update.fetch("session")
    )

    append = read_event(connection)
    raise "expected audio append" unless append.fetch("type") == "input_audio_buffer.append"
    unless Base64.strict_decode64(append.fetch("audio")) == audio
      raise "unexpected transcription audio"
    end
    raise "expected audio commit" unless read_event(connection).fetch("type") == "input_audio_buffer.commit"

    write_event(
      connection,
      type: "conversation.item.input_audio_transcription.delta",
      event_id: "event_delta",
      item_id: "item_1",
      content_index: 0,
      delta: "hello"
    )
    write_event(
      connection,
      type: "conversation.item.input_audio_transcription.completed",
      event_id: "event_completed",
      item_id: "item_1",
      content_index: 0,
      transcript: "hello from ruby",
      usage: {type: "duration", seconds: 0.1}
    )
  end

  private def exercise_transcription(client, audio:)
    client.realtime.connect_transcription do |connection|
      assert_instance_of(OpenAI::Realtime::SessionCreatedEvent, connection.receive)
      configure_transcription(connection)
      assert_instance_of(OpenAI::Realtime::SessionUpdatedEvent, connection.receive)

      connection.input_audio_buffer.append_bytes(audio)
      connection.input_audio_buffer.commit
      assert_transcription_events(connection)
    end
  end

  private def configure_transcription(connection)
    connection.session.update(
      audio: {
        input: {
          format: {type: :"audio/pcm", rate: 24_000},
          transcription: {model: "gpt-live-transcribe"},
          turn_detection: nil
        }
      }
    )
  end

  private def assert_transcription_events(connection)
    delta = connection.receive
    completed = connection.receive
    assert_instance_of(OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent, delta)
    assert_equal("hello", delta.delta)
    assert_instance_of(
      OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent,
      completed
    )
    assert_equal(delta.item_id, completed.item_id)
    assert_equal("hello from ruby", completed.transcript)
  end

  private def with_websocket_server(handler, timeout: 5)
    port = available_port
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = ->(_request) { Protocol::HTTP::Response[404, {}, []] }
    websocket = Async::WebSocket::Server.new(fallback, &handler)
    server = Async::HTTP::Server.new(websocket, endpoint)

    Sync do |task|
      server_task = task.async { server.run.wait }
      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "http://127.0.0.1:#{port}/v1",
        timeout: timeout
      )
      yield(task, client)
    ensure
      server_task&.stop
    end
  end

  private def read_event(connection)
    message = connection.read
    raise "client closed before sending the expected event" if message.nil?

    JSON.parse(message.to_str)
  end

  private def write_event(connection, **event)
    connection.write(Protocol::WebSocket::TextMessage.generate(event))
    connection.flush
  end

  private def available_port
    server = TCPServer.new("127.0.0.1", 0)
    server.local_address.ip_port
  ensure
    server&.close
  end
end
