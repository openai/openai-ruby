# frozen_string_literal: true

require_relative "examples_test_case"
require_relative "../../../examples/realtime/sip"
require_relative "../../../examples/realtime/webrtc_conversation"
require "socket"
require "timeout"
require "webrick"

class OpenAI::Test::RealtimeCallRecoveryExamplesTest < OpenAI::Test::RealtimeExamplesTestCase
  extend Minitest::Serial

  WEBRTC_HEADERS = {
    "host" => "127.0.0.1:4567",
    "origin" => "http://127.0.0.1:4567"
  }.freeze

  class BlockingClientSecrets
    Secret = Data.define(:value, :expires_at)

    attr_reader :creates

    def initialize
      @creates = []
      @started = Thread::Queue.new
      @release = Thread::Queue.new
    end

    def create(**params)
      @creates << params
      @started << true
      @release.pop
      Secret.new(value: "ek_test", expires_at: Time.now.to_i + 60)
    end

    def wait_until_started = @started.pop
    def release = @release << true
  end

  class UnexpectedCalls
    attr_reader :creates

    def initialize = @creates = []

    def create(**params)
      @creates << params
      raise "Ruby must not allocate the browser WebRTC call"
    end
  end

  def test_webrtc_conversation_does_not_allocate_a_call_when_the_browser_resets
    released = false
    client_secrets = BlockingClientSecrets.new
    calls = UnexpectedCalls.new
    realtime = Data.define(:client_secrets, :calls).new(client_secrets, calls)
    server = WEBrick::HTTPServer.new(
      BindAddress: "127.0.0.1",
      Port: 0,
      Logger: WEBrick::Log.new(File::NULL, WEBrick::BasicLog::FATAL),
      AccessLog: []
    )
    port = server.listeners.fetch(0).addr.fetch(1)
    origin = "http://127.0.0.1:#{port}"
    app = OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: RecordingClient.new(realtime: realtime),
      origin: origin,
      html: "test"
    )
    server.mount_proc("/") { |request, response| app.handle(request, response) }
    server_thread = Thread.new { server.start }
    socket = TCPSocket.new("127.0.0.1", port)
    socket.write(
      "POST /token HTTP/1.1\r\n" \
      "Host: 127.0.0.1:#{port}\r\n" \
      "Origin: #{origin}\r\n" \
      "Content-Length: 0\r\n" \
      "Connection: close\r\n\r\n"
    )

    Timeout.timeout(1) { client_secrets.wait_until_started }
    socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_LINGER, [1, 0].pack("ii"))
    socket.close
    client_secrets.release
    released = true

    assert_empty(calls.creates)
    assert_equal(1, client_secrets.creates.length)
  ensure
    client_secrets&.release unless released
    socket&.close unless socket&.closed?
    server&.shutdown
    server_thread&.join
  end

  def test_sip_example_hangs_up_after_an_ambiguous_accept_failure
    realtime = RecordingRealtime.new(RecordingConnection.new)
    realtime.calls.accept_error = IOError.new("accept response lost")
    realtime.calls.hangup_error = RuntimeError.new("hangup failed")

    error = assert_raises(IOError) do
      OpenAI::Examples::Realtime::SIP.run(
        client: RecordingClient.new(realtime: realtime),
        call_id: "rtc_123",
        model: "gpt-realtime-2.1",
        output: StringIO.new
      )
    end

    assert_equal("accept response lost", error.message)
    assert_equal(["rtc_123"], realtime.calls.hangups)
  end
end
