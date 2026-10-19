# frozen_string_literal: true

require "async/websocket/client"
require "async/queue"

require_relative "../test_helper"

class OpenAI::Test::CanceledWriteTest < Minitest::Test
  extend Minitest::Serial

  # Only the underlying byte stream is controlled. The SDK socket, Async
  # connection and Protocol framer still encode, buffer and flush real frames.
  class BufferedStream
    attr_reader :wire, :buffered, :flush_started, :read_started

    def initialize(gate_every_flush: false)
      @reader, @writer = IO.pipe
      @wire = +"".b
      @buffered = +"".b
      @flush_started = Async::Queue.new
      @read_started = Async::Queue.new
      @wait = Async::Queue.new
      @flush_wait = Async::Queue.new
      @gate_every_flush = gate_every_flush
      @suspend_flush = true
    end

    def to_io = @writer

    def read(size)
      return "".b if size.zero?

      @read_started.enqueue(true)
      @wait.dequeue
    end

    def peer_close = @wait.enqueue("\x88\x00".b)

    def release_flush = @flush_wait.enqueue(true)

    def write(bytes)
      @buffered << bytes
      bytes.bytesize
    end

    def flush
      return if @buffered.empty?

      if @suspend_flush || @gate_every_flush
        @suspend_flush = false
        @flush_started.enqueue(true)
        @flush_wait.dequeue
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

    def initialize(gate_every_flush: false)
      @stream = BufferedStream.new(gate_every_flush: gate_every_flush)
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

  def test_realtime_canceled_write
    assert_canceled_write(:realtime, OpenAI::Errors::RealtimeConnectionError)
  end

  def test_realtime_transcription_canceled_write
    assert_canceled_write(:realtime_transcription, OpenAI::Errors::RealtimeConnectionError)
  end

  def test_realtime_sideband_canceled_write
    assert_canceled_write(:realtime_sideband, OpenAI::Errors::RealtimeConnectionError)
  end

  def test_realtime_canceled_writes_cannot_flush_from_an_active_reader
    [:realtime, :realtime_transcription, :realtime_sideband].each do |kind|
      assert_canceled_write(kind, OpenAI::Errors::RealtimeConnectionError, active_reader: true)
    end
  end

  def test_realtime_canceled_writes_abort_during_a_peer_close_reply
    [:realtime, :realtime_transcription, :realtime_sideband].each do |kind|
      assert_canceled_write(kind, OpenAI::Errors::RealtimeConnectionError, active_reader: true, closing_reader: true)
    end
  end

  private def assert_canceled_write(kind, error_class, active_reader: false, closing_reader: false)
    # Cleanup on its own must be safe too, even if the application never tries
    # to send again. Use fresh connections for these two failure modes.
    [false, true].each do |try_again|
      Sync do |task|
        task.with_timeout(3) do
          transport = Transport.new(gate_every_flush: closing_reader)
          api = OpenAI::Client.new(api_key: "test-key", base_url: "https://example.com/v1")
          block = proc do |value|
            first, other, event = case kind
            when :managed
              [value.lane("left"), value.lane("right"), {type: "response.create"}]
            when :responses
              [value, value, {type: "response.create"}]
            when :translation
              [value, value, {type: "session.input_audio_buffer.append", audio: "AA=="}]
            when :realtime, :realtime_transcription, :realtime_sideband
              [value, value, {type: "response.cancel"}]
            else
              [value, value, {type: "session.close"}]
            end

            receiver = task.async { assert_raises(error_class) { other.receive } } if kind == :managed
            if active_reader
              peer_reader = task.async do
                other.receive
              rescue OpenAI::Errors::WebSocketConnectionError
                nil
              end

              transport.stream.read_started.dequeue
            end

            sender = task.async { first.send_event(event) }
            transport.stream.flush_started.dequeue
            refute_empty(transport.stream.buffered, "the actual framer must have reached the stream")
            if closing_reader
              transport.stream.peer_close
              transport.stream.flush_started.dequeue
            end

            sender.stop
            sender.wait
            if active_reader
              if closing_reader
                assert_predicate(transport.stream.to_io, :closed?)
                transport.stream.release_flush
              else
                transport.stream.peer_close
              end

              peer_reader.wait
            end

            if [:realtime, :realtime_transcription, :realtime_sideband].include?(kind)
              assert_predicate(other, :closed?)
              assert_raises(error_class) { other.receive }
            end

            assert_raises(error_class) { other.send_event(event) } if try_again
            if receiver
              receiver.wait
              assert_raises(error_class) { value.default.receive }
            end

          ensure
            peer_reader&.stop
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
          when :realtime
            api.realtime.connect(model: "gpt-realtime-2.1", transport: transport, &block)
          when :realtime_transcription
            api.realtime.connect_transcription(transport: transport, &block)
          when :realtime_sideband
            api.realtime.connect_to_call(call_id: "rtc_synthetic", transport: transport, &block)
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
