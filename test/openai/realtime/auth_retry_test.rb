# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::RealtimeAuthRetryTest < Minitest::Test
  class Socket
    def closed? = @closed == true
    def close(code: 1000, reason: "")
      @closed = true
      [code, reason]
    end

    def abort = @closed = true
  end

  class RejectOnceTransport
    attr_reader :attempts

    def initialize(reject_every_attempt: false)
      @attempts = []
      @reject_every_attempt = reject_every_attempt
    end

    def open(url:, headers:, timeout:, **options)
      @attempts << {url: url, headers: headers, timeout: timeout, options: options}
      if @reject_every_attempt || @attempts.one?
        raise(
          OpenAI::Errors::RealtimeConnectionError.new(
            url: url,
            message: "upgrade rejected",
            http_status: 401
          )
        )
      end

      yield(Socket.new)
    end
  end

  class AcceptingTransport
    attr_reader :attempts

    def initialize = @attempts = []

    def open(url:, headers:, timeout:, **options)
      @attempts << {url: url, headers: headers, timeout: timeout, options: options}
      yield(Socket.new)
    end
  end

  def test_x509_workload_identity_rejects_realtime_before_token_or_websocket_dispatch
    identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp_123",
      service_account_id: "sa_123"
    )
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: identity,
      base_url: "https://trusted.example/v1",
      http_client: OpenAI::HTTPClient.new
    )
    transport = AcceptingTransport.new
    token_requests = 0
    get_token = lambda do |deadline:|
      refute_nil(deadline)
      token_requests += 1
      "sensitive-token"
    end

    client.workload_identity_auth.stub(:get_token, get_token) do
      %w[wss://attacker.invalid/v1 ws://attacker.invalid/v1].each do |websocket_base_url|
        error = assert_raises(OpenAI::Errors::Error) do
          client
            .realtime
            .connect(
              model: "gpt-realtime-2.1",
              websocket_base_url: websocket_base_url,
              transport: transport
            ) { |_connection| nil }
        end

        assert_match(/X\.509.*Realtime WebSocket/, error.message)
      end
    end

    assert_equal(0, token_requests)
    assert_empty(transport.attempts)
  end

  def test_workload_identity_refreshes_once_after_a_definitive_upgrade_401
    client = workload_identity_client
    transport = RejectOnceTransport.new
    tokens = ["stale-token", "fresh-token"]
    deadlines = []
    invalidations = 0

    get_token = lambda do |deadline:|
      deadlines << deadline
      tokens.shift
    end

    client.workload_identity_auth.stub(:get_token, get_token) do
      client.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
        client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |_connection|
          nil
        end
      end
    end

    assert_equal(1, invalidations)
    assert_equal(2, transport.attempts.length)
    assert_equal("Bearer stale-token", transport.attempts.fetch(0).dig(:headers, "authorization"))
    assert_equal("Bearer fresh-token", transport.attempts.fetch(1).dig(:headers, "authorization"))
    assert_instance_of(Float, deadlines.fetch(0))
    assert_equal(1, deadlines.uniq.length)
  end

  def test_workload_identity_does_not_retry_a_second_upgrade_401
    client = workload_identity_client
    transport = RejectOnceTransport.new(reject_every_attempt: true)
    tokens = ["stale-token", "fresh-token"]
    deadlines = []
    invalidations = 0

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      get_token = lambda do |deadline:|
        deadlines << deadline
        tokens.shift
      end

      client.workload_identity_auth.stub(:get_token, get_token) do
        client.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
          client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |_connection|
            nil
          end
        end
      end
    end

    assert_equal(401, error.http_status)
    assert_equal(1, deadlines.uniq.length)
    assert_equal(1, invalidations)
    assert_equal(2, transport.attempts.length)
  end

  def test_workload_identity_does_not_replay_the_application_block_after_a_401_error
    client = workload_identity_client
    transport = AcceptingTransport.new
    application_error = OpenAI::Errors::RealtimeConnectionError.new(
      url: URI("wss://example.com/v1/realtime"),
      message: "application authorization failed",
      http_status: 401
    )
    block_runs = 0
    invalidations = 0
    token_requests = 0

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      get_token = lambda do |deadline:|
        refute_nil(deadline)
        token_requests += 1
        "fresh-token"
      end

      client.workload_identity_auth.stub(:get_token, get_token) do
        client.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
          client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |_connection|
            block_runs += 1
            raise application_error
          end
        end
      end
    end

    assert_same(application_error, error)
    assert_equal(1, block_runs)
    assert_equal(1, transport.attempts.length)
    assert_equal(1, token_requests)
    assert_equal(0, invalidations)
  end

  def test_workload_identity_authentication_reduces_the_handshake_timeout
    client = workload_identity_client(timeout: 10)
    transport = AcceptingTransport.new
    observed_deadline = nil
    clock = [100.0, 100.25]

    OpenAI::Internal::Util.stub(:monotonic_secs, -> { clock.shift || 100.25 }) do
      get_token = lambda do |deadline:|
        observed_deadline = deadline
        "fresh-token"
      end

      client.workload_identity_auth.stub(:get_token, get_token) do
        client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |_connection|
          nil
        end
      end
    end

    assert_equal(110.0, observed_deadline)
    assert_in_delta(9.75, transport.attempts.fetch(0).fetch(:timeout))
  end

  def test_workload_identity_authentication_cannot_outlive_a_short_connect_timeout
    client = workload_identity_client(timeout: 0.01)
    transport = AcceptingTransport.new
    clock = [100.0, 100.02]
    observed_deadline = nil

    error = OpenAI::Internal::Util.stub(:monotonic_secs, -> { clock.shift || 100.02 }) do
      get_token = lambda do |deadline:|
        observed_deadline = deadline
        "fresh-token"
      end

      client.workload_identity_auth.stub(:get_token, get_token) do
        assert_raises(OpenAI::Errors::RealtimeConnectionError) do
          client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |_connection|
            nil
          end
        end
      end
    end

    assert_equal(100.01, observed_deadline)
    assert_instance_of(Timeout::Error, error.cause)
    assert_equal("Realtime WebSocket connection error.", error.message)
    assert_empty(transport.attempts)
  end

  def test_extra_query_is_rejected_before_workload_identity_authentication
    client = workload_identity_client
    transport = AcceptingTransport.new
    token_requests = 0

    get_token = lambda do |deadline:|
      refute_nil(deadline)
      token_requests += 1
      "unused-token"
    end

    error = client.workload_identity_auth.stub(:get_token, get_token) do
      assert_raises(ArgumentError) do
        client
          .realtime
          .connect(
            model: "gpt-realtime-2.1",
            request_options: {extra_query: {"credential" => "fake-sensitive-value"}},
            transport: transport
          ) { |_connection| nil }
      end
    end

    assert_includes(error.message, "`request_options[:extra_query]` is not supported")
    assert_equal(0, token_requests)
    assert_empty(transport.attempts)
  end

  def test_transport_options_are_snapshotted_before_workload_identity_authentication
    client = workload_identity_client
    transport = AcceptingTransport.new
    transport_options = {max_frame_size: 1_024}

    get_token = lambda do |deadline:|
      refute_nil(deadline)
      transport_options[:url] = URI("wss://attacker.invalid/realtime")
      transport_options[:headers] = {"authorization" => "Bearer stolen"}
      "fresh-token"
    end

    client.workload_identity_auth.stub(:get_token, get_token) do
      client
        .realtime
        .connect(
          model: "gpt-realtime-2.1",
          transport: transport,
          transport_options: transport_options
        ) { |_connection| nil }
    end

    attempt = transport.attempts.fetch(0)
    assert_equal("wss://example.com/v1/realtime?model=gpt-realtime-2.1", attempt.fetch(:url).to_s)
    assert_equal("Bearer fresh-token", attempt.dig(:headers, "authorization"))
    assert_equal({max_frame_size: 1_024}, attempt.fetch(:options))
  end

  private def workload_identity_client(timeout: 600)
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: "/not-read-by-this-test"
    )
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp_123",
      service_account_id: "sa_123",
      provider: provider
    )
    OpenAI::Client.new(
      api_key: nil,
      workload_identity: config,
      organization: "org_123",
      base_url: "https://example.com/v1",
      timeout: timeout
    )
  end
end
