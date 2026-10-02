# frozen_string_literal: true

require "async/websocket/client"
require "async/queue"

require_relative "../test_helper"

class OpenAI::Test::CanceledWriteTest < Minitest::Test
  extend Minitest::Serial

  # Only the underlying byte stream is controlled. The SDK socket, Async
  # connection and Protocol framer still encode, buffer and flush real frames.
  class BufferedStream
    attr_reader :wire, :buffered, :flush_started

    def initialize
      @reader, @writer = IO.pipe
      @wire = +"".b
      @buffered = +"".b
      @flush_started = Async::Queue.new
      @wait = Async::Queue.new
      @suspend_flush = true
    end

    def to_io = @writer

    def read(_size) = @wait.dequeue

    def write(bytes)
      @buffered << bytes
      bytes.bytesize
    end

    def flush
      return if @buffered.empty?

      if @suspend_flush
        @suspend_flush = false
        @flush_started.enqueue(true)
        @wait.dequeue
      end

      raise IOError, "closed underlying stream" if @writer.closed?

      @wire << @buffered
      @buffered.clear
    end

    def close
      flush
    ensure
      dispose
    end

    def dispose
      @writer.close unless @writer.closed?
      @reader.close unless @reader.closed?
    end
  end

  class Transport
    attr_reader :stream

    def initialize
      @stream = BufferedStream.new
    end

    def open(url:, **_)
      framer = Protocol::WebSocket::Framer.new(@stream)
      connection = Async::WebSocket::Connection.new(framer)
      factory = -> (**request) { OpenAI::Errors::WebSocketConnectionError.new(url: request.fetch(:url)) }
      socket = OpenAI::WebSocket::AsyncWebSocketTransport::Socket.new(connection, url: url, error_factory: factory)
      yield(socket)
    end
  end

  def test_responses_canceled_write
    assert_canceled_write(:responses, OpenAI::Errors::ResponsesConnectionError)
  end

  def test_managed_responses_canceled_write_retires_other_lanes
    assert_canceled_write(:managed, OpenAI::Errors::ResponsesConnectionError)
  end

  def test_live_primary_canceled_write
    assert_canceled_write(:primary, OpenAI::Errors::LiveConnectionError)
  end

  def test_live_sideband_canceled_write
    assert_canceled_write(:sideband, OpenAI::Errors::LiveConnectionError)
  end

  def test_live_fork_canceled_write
    assert_canceled_write(:fork, OpenAI::Errors::LiveConnectionError)
  end

  def test_translation_canceled_write_control
    assert_canceled_write(:translation, OpenAI::Errors::TranslationConnectionError)
  end

  private def assert_canceled_write(kind, error_class)
    # Cleanup on its own must be safe too, even if the application never tries
    # to send again. Use fresh connections for these two failure modes.
    [false, true].each do |try_again|
      Sync do |task|
        task.with_timeout(3) do
          transport = Transport.new
          api = OpenAI::Client.new(api_key: "test-key", base_url: "https://example.com/v1")
          block = proc do |value|
            first, other, event = case kind
            when :managed
              [value.lane("left"), value.lane("right"), {type: "response.create"}]
            when :responses
              [value, value, {type: "response.create"}]
            when :translation
              [value, value, {type: "session.input_audio_buffer.append", audio: "AA=="}]
            else
              [value, value, {type: "session.close"}]
            end

            receiver = task.async { assert_raises(error_class) { other.receive } } if kind == :managed
            sender = task.async { first.send_event(event) }
            transport.stream.flush_started.dequeue
            refute_empty(transport.stream.buffered, "the actual framer must have reached the stream")
            sender.stop
            sender.wait
            assert_raises(error_class) { other.send_event(event) } if try_again
            if receiver
              receiver.wait
              assert_raises(error_class) { value.default.receive }
            end
          end

          case kind
          when :responses
            api.responses.connect(transport: transport, &block)
          when :managed
            limits = OpenAI::Responses::SessionLimits.new(
              max_lanes: 4,
              max_events_per_lane: 8,
              max_events: 16,
              max_bytes_per_lane: 16_384,
              max_bytes: 32_768,
              max_response_bytes: 32_768
            )
            OpenAI::Responses::Session.open(client: api, limits: limits, transport: transport, &block)
          when :primary
            api.live.connect(transport: transport, &block)
          when :sideband
            api.live.sideband.connect("test-session", transport: transport, &block)
          when :fork
            api.live.forks.connect("test-session", transport: transport, &block)
          when :translation
            api.realtime.connect_translation(model: "gpt-realtime-translate", transport: transport, &block)
          end

          assert_empty(transport.stream.wire, "canceled bytes must never be flushed (#{kind}, try again: #{try_again})")
          assert_predicate(transport.stream.to_io, :closed?)
        ensure
          transport&.stream&.dispose
        end
      end
    end
  end
end
