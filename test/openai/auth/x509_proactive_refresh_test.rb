# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::X509ProactiveRefreshTest < Minitest::Test
  def setup
    super
    @native = OpenAI::NetHTTPClient.new
    @transport = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)
    @identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp_fake",
      service_account_id: "svc_acct_fake",
      refresh_buffer_seconds: 30
    )
  end

  def teardown
    @native.close
    super
  end

  def test_public_client_falls_back_to_valid_bearer_after_transient_proactive_refresh_failures
    failures = [408, 409, 429, 500, 503, OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]

    failures.each do |failure|
      client = new_client
      now = 100.0
      issuer_attempts = 0
      api_authorizations = []
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          if issuer_attempts == 1
            token_response
          elsif failure.is_a?(Integer)
            failure_response(failure)
          else
            raise failure.new(url: request.url)
          end
        else
          api_authorizations << request.headers.fetch("authorization")
          model_response
        end
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        @native.stub(:execute, dispatch) do
          assert_equal("fake-model", client.models.retrieve("first").id)
          now = 191.0
          assert_equal("fake-model", client.models.retrieve("second").id)
          assert_equal("fake-model", client.models.retrieve("third").id)
        end
      end

      assert_equal(2, issuer_attempts)
      assert_equal(["Bearer fake-valid-token"] * 3, api_authorizations)
    end
  end

  def test_proactive_refresh_cooldown_is_bounded_and_never_extends_token_lifetime
    client = new_client
    now = 100.0
    issuer_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_attempts += 1
        issuer_attempts == 1 ? token_response : failure_response(503)
      else
        model_response
      end
    end

    OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
      @native.stub(:execute, dispatch) do
        assert_equal("fake-model", client.models.retrieve("first").id)
        now = 191.0
        assert_equal("fake-model", client.models.retrieve("second").id)
        assert_equal(2, issuer_attempts)
        now = 195.9
        assert_equal("fake-model", client.models.retrieve("third").id)
        assert_equal(2, issuer_attempts)
        now = 196.0
        assert_equal("fake-model", client.models.retrieve("fourth").id)
        assert_equal(3, issuer_attempts)
        now = 220.0
        error = assert_raises(OpenAI::Errors::APIError) { client.models.retrieve("expired") }
        assert_equal(503, error.status)
      end
    end
  end

  def test_expired_and_concurrently_invalidated_bearers_never_receive_fallback
    [:expired, :invalidated].each do |state|
      client = new_client
      now = 100.0
      issuer_attempts = 0
      api_attempts = 0
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          if issuer_attempts == 1
            token_response
          else
            client.workload_identity_auth.invalidate_token("fake-valid-token") if state == :invalidated
            failure_response(503)
          end
        else
          api_attempts += 1
          model_response
        end
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        @native.stub(:execute, dispatch) do
          assert_equal("fake-model", client.models.retrieve("first").id)
          now = state == :expired ? 220.0 : 191.0
          error = assert_raises(OpenAI::Errors::APIError) { client.models.retrieve("second") }
          assert_equal(503, error.status)
        end
      end

      assert_equal(2, issuer_attempts)
      assert_equal(1, api_attempts)
    end
  end

  def test_nontransient_oauth_rejections_never_fall_back_to_the_cached_bearer
    [400, 401, 403, 404].each do |status|
      client = new_client
      now = 100.0
      issuer_attempts = 0
      api_attempts = 0
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          issuer_attempts == 1 ? token_response : failure_response(status)
        else
          api_attempts += 1
          model_response
        end
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        @native.stub(:execute, dispatch) do
          assert_equal("fake-model", client.models.retrieve("first").id)
          now = 191.0
          error = assert_raises(OpenAI::Errors::APIError) { client.models.retrieve("second") }
          assert_equal(status, error.status)
        end
      end

      assert_equal(2, issuer_attempts)
      assert_equal(1, api_attempts)
    end
  end

  def test_expired_caller_deadline_never_falls_back_to_an_unexpired_bearer
    client = new_client
    auth = client.workload_identity_auth
    now = 100.0
    failure = OpenAI::Errors::APIError.new(
      url: URI("https://mtls.auth.openai.com/oauth/token"),
      status: 503,
      message: "issuer temporarily unavailable"
    )

    OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
      @native.stub(:execute, -> (_request) { token_response }) do
        assert_equal("fake-valid-token", auth.get_token)
      end

      now = 191.0
      exchange = lambda do |deadline:|
        now = deadline + 1
        raise failure
      end

      auth.stub(:fetch_token_from_exchange, exchange) do
        error = assert_raises(OpenAI::Errors::APIError) { auth.get_token(deadline: 192.0) }
        assert_same(failure, error)
      end
    end
  end

  def test_token_expiring_during_fallback_validation_preserves_the_original_issuer_failure
    client = new_client
    auth = client.workload_identity_auth
    failure = OpenAI::Errors::APIError.new(
      url: URI("https://mtls.auth.openai.com/oauth/token"),
      status: 503,
      message: "issuer temporarily unavailable"
    )

    OpenAI::Internal::Util.stub(:monotonic_secs, -> { 100.0 }) do
      @native.stub(:execute, -> (_request) { token_response }) do
        assert_equal("fake-valid-token", auth.get_token)
      end
    end

    ticks = 0
    clock = lambda do
      ticks += 1
      if ticks <= 2
        191.0
      elsif ticks == 3 && caller_locations(2, 1).fetch(0).label.end_with?("#token_expired?")
        219.9
      else
        220.1
      end
    end

    OpenAI::Internal::Util.stub(:monotonic_secs, clock) do
      auth.stub(:fetch_token_from_exchange, -> (**_options) { raise failure }) do
        error = assert_raises(OpenAI::Errors::APIError) { auth.get_token }
        assert_same(failure, error)
      end
    end

    assert_operator(
      auth.instance_variable_get(:@cached_token_refresh_at_monotonic),
      :<=,
      auth.instance_variable_get(:@cached_token_expires_at_monotonic)
    )
  end

  private def new_client
    OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport, max_retries: 0)
  end

  private def token_response
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {},
      body: JSON.generate(
        access_token: "fake-valid-token",
        issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
        token_type: "Bearer",
        expires_in: 120
      )
    )
  end

  private def failure_response(status)
    OpenAI::HTTPClient::Response.new(status: status, headers: {}, body: "")
  end

  private def model_response
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(id: "fake-model", created: 1, object: "model", owned_by: "openai")
    )
  end
end
