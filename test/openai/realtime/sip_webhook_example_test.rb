# frozen_string_literal: true

require "stringio"

require_relative "connection_test_support"
require_relative "../../../examples/realtime/sip_webhook"

class OpenAI::Test::SIPWebhookExampleTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  # Give the SDK a concrete execute protocol even when zero calls are expected.
  # Any unmocked execution fails locally, never reaching a network adapter.
  class NoHTTP
    def execute(_request) = raise "Unexpected HTTP request"
  end

  Worker = OpenAI::Examples::Realtime::SIPWebhook
  SECRET = "fake-webhook-secret"
  TOKEN = "fake-application-token"
  CALL_ID = "rtc_fake_call"

  def test_signed_call_accepts_with_server_policy_connects_and_hangs_up
    http = http_mock(:accept, :hangup)
    socket = FakeSocket.new(JSON.generate(type: "session.created", event_id: "fake", session: {type: "realtime"}))
    transport = FakeTransport.new(socket)
    worker = worker(http: http, transport: transport)
    request = envelope
    request["call_id"] = "rtc_attacker_selected"

    assert_equal(:sideband_closed, worker.handle(request))
    assert_equal(:hangup_confirmed, worker.state(CALL_ID))
    assert_equal([["call_id", CALL_ID]], URI.decode_www_form(transport.open_args.fetch(:url).query))
    assert_predicate(socket, :closed?)
    assert_mock(http)
  end

  def test_application_and_tenant_authorization_precedes_webhook_and_network_access
    http = http_mock
    worker = worker(http: http)
    [{"application_token" => "wrong"}, {"tenant" => "another-tenant"}, {"application_token" => nil}].each do |overrides|
      assert_raises(Worker::Unauthorized) { worker.handle(envelope.merge(overrides).merge("headers" => {})) }
    end

    assert_nil(worker.state(CALL_ID))
    assert_mock(http)
  end

  def test_signature_failures_and_expired_deliveries_have_no_effects
    http = http_mock
    worker = worker(http: http)
    tampered = envelope
    tampered["body"] = tampered.fetch("body").sub(CALL_ID, "rtc_forged")
    [tampered, envelope(secret: "wrong-secret"), envelope(timestamp: Time.now.to_i - 600)].each do |request|
      assert_raises(OpenAI::Errors::InvalidWebhookSignatureError) { worker.handle(request) }
    end

    assert_nil(worker.state(CALL_ID))
    assert_mock(http)
  end

  def test_invalid_call_ids_never_reach_controls
    http = http_mock
    worker = worker(http: http)
    ["", "live_fake", "rtc_a/../other", "rtc_a%2fb", nil].each do |id|
      assert_raises(ArgumentError, OpenAI::Errors::ConversionError) { worker.handle(envelope(call_id: id)) }
    end

    assert_mock(http)
  end

  def test_signed_live_and_unknown_terminal_events_are_ignored
    http = http_mock
    worker = worker(http: http)
    ["live.transport.incoming", "live.call.incoming", "realtime.call.ended"].each do |type|
      assert_equal(:ignored, worker.handle(envelope(type: type)))
    end

    assert_nil(worker.state(CALL_ID))
    assert_mock(http)
  end

  def test_admission_policy_rejects_verified_call_without_accept_or_hangup
    http = http_mock(:reject)
    worker = worker(http: http, accepting: false)
    assert_equal(:rejected, worker.handle(envelope))
    assert_equal(:duplicate, worker.handle(envelope))
    assert_equal(:rejected, worker.state(CALL_ID))
    assert_mock(http)
  end

  def test_event_and_call_deduplication_survive_completion_and_new_delivery_ids
    http = http_mock(:accept, :hangup)
    worker = worker(http: http)
    worker.handle(envelope)
    assert_equal(:duplicate, worker.handle(envelope(delivery_id: "wh_redelivery")))
    assert_equal(:duplicate, worker.handle(envelope(event_id: "evt_new")))
    assert_equal(:duplicate, worker.handle(envelope(call_id: "rtc_other")))
    assert_nil(worker.state("rtc_other"))
    assert_mock(http)
  end

  def test_duplicate_during_accept_cannot_start_another_lifecycle
    entered = Queue.new
    release = Queue.new
    http = http_mock
    expect_http(http, :accept) do |_request|
      entered << true
      release.pop
    end

    expect_http(http, :hangup)
    worker = worker(http: http)
    thread = Thread.new { worker.handle(envelope) }
    begin
      Timeout.timeout(5) { entered.pop }
      assert_equal(:duplicate, worker.handle(envelope(event_id: "evt_concurrent")))
    ensure
      release << true
      thread.join(5)
    end

    assert_equal(:sideband_closed, thread.value)
    assert_mock(http)
  end

  def test_definitive_409_does_not_retry_connect_or_hang_up_another_owner
    http = http_mock
    expect_http(http, :accept, status: 409)
    worker = worker(http: http)
    assert_equal(:other_owner, worker.handle(envelope))
    assert_equal(:other_owner, worker.state(CALL_ID))
    assert_equal(:duplicate, worker.handle(envelope(event_id: "evt_again")))
    assert_mock(http)
  end

  def test_uncertain_server_accept_failure_is_quarantined_without_hangup_or_replay
    http = http_mock
    expect_http(http, :accept, status: 500)
    worker = worker(http: http)
    assert_raises(OpenAI::Errors::InternalServerError) { worker.handle(envelope) }
    assert_equal(:accept_unknown, worker.state(CALL_ID))
    assert_equal(:duplicate, worker.handle(envelope))
    assert_mock(http)
  end

  def test_lost_accept_response_never_grants_ownership
    http = http_mock
    expect_http(http, :accept) { |_request| raise Timeout::Error, "fake network timeout" }
    worker = worker(http: http)
    assert_raises(Timeout::Error) { worker.handle(envelope) }
    assert_equal(:accept_unknown, worker.state(CALL_ID))
    assert_mock(http)
  end

  def test_failed_rejection_is_not_replayed_and_does_not_hang_up
    http = http_mock
    expect_http(http, :reject, status: 500)
    worker = worker(http: http, accepting: false)
    assert_raises(OpenAI::Errors::InternalServerError) { worker.handle(envelope) }
    assert_equal(:reject_unknown, worker.state(CALL_ID))
    assert_equal(:duplicate, worker.handle(envelope))
    assert_mock(http)
  end

  def test_sideband_open_failure_preserves_primary_error_when_hangup_fails
    http = http_mock
    expect_http(http, :accept)
    expect_http(http, :hangup, status: 500)
    primary = RuntimeError.new("fake private handshake details")
    transport = Minitest::Mock.new
    transport.expect(:open, nil) { |**_options, &_block| raise primary }
    worker = worker(http: http, transport: transport)
    assert_same(primary, assert_raises(RuntimeError) { worker.handle(envelope) })
    assert_equal(:cleanup_unconfirmed, worker.state(CALL_ID))
    assert_mock(http)
    assert_mock(transport)
  end

  def test_sideband_api_error_and_socket_cleanup_failures_preserve_primary_error
    http = http_mock
    expect_http(http, :accept)
    expect_http(http, :hangup, status: 409)
    socket = Minitest::Mock.new
    socket.expect(
      :read,
      JSON.generate(type: "error", event_id: "fake", error: {type: "server_error", message: "private"})
    )
    socket.expect(:closed?, false)
    socket.expect(:abort, nil) { raise "fake socket cleanup failure" }
    worker = worker(http: http, transport: FakeTransport.new(socket))
    error = assert_raises(RuntimeError) { worker.handle(envelope) }
    assert_equal("Realtime sideband reported an error", error.message)
    assert_equal(:cleanup_unconfirmed, worker.state(CALL_ID))
    assert_mock(http)
    assert_mock(socket)
  end

  def test_response_terminal_events_do_not_end_call_or_hide_later_error
    events = [
      {type: "response.done", event_id: "fake1", response: {id: "resp_fake", status: "completed"}},
      {type: "output_audio_buffer.stopped", event_id: "fake2", response_id: "resp_fake"},
      {type: "error", event_id: "fake3", error: {type: "server_error", message: "fake private details"}}
    ]
    http = http_mock(:accept, :hangup)
    socket = FakeSocket.new(*events.map { JSON.generate(_1) })
    worker = worker(http: http, transport: FakeTransport.new(socket))
    assert_raises(RuntimeError) { worker.handle(envelope) }
    assert_predicate(socket, :aborted?)
    assert_equal(:hangup_confirmed, worker.state(CALL_ID))
    assert_mock(http)
  end

  def test_peer_end_racing_with_hangup_is_unconfirmed_and_never_reaccepts
    http = http_mock
    expect_http(http, :accept)
    expect_http(http, :hangup, status: 404)
    worker = worker(http: http)
    assert_raises(OpenAI::Errors::NotFoundError) { worker.handle(envelope) }
    assert_equal(:cleanup_unconfirmed, worker.state(CALL_ID))
    assert_equal(:duplicate, worker.handle(envelope))
    assert_mock(http)
  end

  def test_enclosing_rescue_does_not_hide_hangup_failure_after_normal_sideband_exit
    http = http_mock
    expect_http(http, :accept)
    expect_http(http, :hangup, status: 500)
    worker = worker(http: http)

    begin
      raise "unrelated caller failure"
    rescue RuntimeError
      assert_raises(OpenAI::Errors::InternalServerError) { worker.handle(envelope) }
    end

    assert_equal(:cleanup_unconfirmed, worker.state(CALL_ID))
    assert_mock(http)
  end

  def test_enclosing_rescue_preserves_this_invocations_cancellation_when_hangup_fails
    http = http_mock
    expect_http(http, :accept)
    expect_http(http, :hangup, status: 500)
    primary = Async::Stop.new
    transport = Minitest::Mock.new
    transport.expect(:open, nil) { |**_options, &_block| raise primary }
    worker = worker(http: http, transport: transport)

    begin
      raise "unrelated caller failure"
    rescue RuntimeError
      assert_same(primary, assert_raises(Async::Stop) { worker.handle(envelope) })
    end

    assert_equal(:cleanup_unconfirmed, worker.state(CALL_ID))
    assert_mock(http)
    assert_mock(transport)
  end

  def test_deadline_or_cancellation_in_sideband_still_cleans_up
    [Timeout::Error.new("fake deadline"), Async::Stop.new].each do |primary|
      http = http_mock(:accept, :hangup)
      transport = Minitest::Mock.new
      transport.expect(:open, nil) { |**_options, &_block| raise primary }
      worker = worker(http: http, transport: transport)
      assert_same(primary, assert_raises(primary.class) { worker.handle(envelope) })
      assert_equal(:hangup_confirmed, worker.state(CALL_ID))
      assert_mock(http)
      assert_mock(transport)
    end
  end

  def test_runner_redacts_all_input_and_exception_details_and_continues
    http = http_mock(:reject)
    worker = worker(http: http, accepting: false)
    input = StringIO.new("not json\n#{JSON.generate(envelope)}\n#{JSON.generate(envelope)}\n")
    output = StringIO.new
    Worker.run(worker: worker, input: input, output: output)
    assert_equal("{\"status\":\"failed\"}\n{\"status\":\"rejected\"}\n{\"status\":\"duplicate\"}\n", output.string)
    assert_mock(http)
  end

  private def worker(http:, transport: FakeTransport.new(FakeSocket.new), **options)
    Worker.new(
      client: client(http_client: http),
      tenant: "fake-tenant",
      application_token: TOKEN,
      webhook_secret: SECRET,
      model: "gpt-realtime-2.1",
      transport: transport,
      **options
    )
  end

  private def http_mock(*operations)
    http = Minitest::Mock.new(NoHTTP.new)
    operations.each { expect_http(http, _1) }
    http
  end

  private def expect_http(http, operation, status: 200)
    response = OpenAI::HTTPClient::Response.new(status: status, headers: {}, body: "")
    http.expect(:execute, response) do |request|
      assert_equal("/v1/realtime/calls/#{CALL_ID}/#{operation}", request.url.path)
      assert_equal("Bearer test-key", request.headers.fetch("authorization"))
      if operation == :accept
        body = JSON.parse(request.body)
        assert_equal("realtime", body.fetch("type"))
        assert_equal("gpt-realtime-2.1", body.fetch("model"))
        assert_empty(body.fetch("tools"))
        assert_includes(body.fetch("instructions"), "Keep answers brief")
      elsif operation == :reject
        assert_equal(486, JSON.parse(request.body).fetch("status_code"))
      end

      yield(request) if block_given?
      true
    end
  end

  private def envelope(
    call_id: CALL_ID,
    event_id: "evt_fake",
    delivery_id: "wh_fake",
    type: "realtime.call.incoming",
    secret: SECRET,
    timestamp: Time.now.to_i
  )
    body = JSON.generate(
      id: event_id,
      created_at: timestamp,
      type: type,
      data: {
        call_id: call_id,
        session_id: "live_fake",
        type: "sip",
        sip_headers: [{name: "X-Tenant", value: "another-tenant"}]
      }
    )
    signature = [OpenSSL::HMAC.digest("sha256", secret, "#{delivery_id}.#{timestamp}.#{body}")].pack("m0")
    {
      "tenant" => "fake-tenant",
      "application_token" => TOKEN,
      "body" => body,
      "headers" => {
        "webhook-id" => delivery_id,
        "webhook-timestamp" => timestamp.to_s,
        "webhook-signature" => "v1,#{signature}"
      }
    }
  end
end
