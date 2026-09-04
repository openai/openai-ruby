# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::X509ProactiveRefreshTest < Minitest::Test
  extend Minitest::Serial

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
    clock = {now: 100.0}
    issuer_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_attempts += 1
        issuer_attempts == 1 ? token_response : failure_response(503)
      else
        model_response
      end
    end

    OpenAI::Internal::Util.stub(:monotonic_secs, -> { clock.fetch(:now) }) do
      @native.stub(:execute, dispatch) do
        assert_equal("fake-model", client.models.retrieve("first").id)
        clock[:now] = 191.0
        assert_equal("fake-model", client.models.retrieve("second").id)
        assert_equal(2, issuer_attempts)
        clock[:now] = 195.9
        assert_equal("fake-model", client.models.retrieve("third").id)
        assert_equal(2, issuer_attempts)
        clock[:now] = 196.0
        assert_equal("fake-model", client.models.retrieve("fourth").id)
        assert_equal(3, issuer_attempts)
        clock[:now] = 220.0
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

  def test_token_expiring_after_fallback_acceptance_preserves_the_original_issuer_failure
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

    clock = {ticks: [191.0, 191.0, 219.9, 220.1]}
    OpenAI::Internal::Util.stub(:monotonic_secs, -> { clock.fetch(:ticks).shift || 220.1 }) do
      auth.stub(:fetch_token_from_exchange, -> (**_options) { raise failure }) do
        error = assert_raises(OpenAI::Errors::APIError) { auth.get_token }
        assert_same(failure, error)
        assert_equal(503, error.status)
      end
    end

    assert_same(failure, auth.instance_variable_get(:@refresh_error))
  end

  def test_cached_fallback_preserves_issuer_minimum_across_auth_replay
    [
      {"retry-after" => "2"},
      {"retry-after" => "90"},
      {"retry-after" => "1e999"},
      {"retry-after-ms" => "1e999", "retry-after" => "0"}
    ].each do |headers|
      now = 100.0
      client = new_client.with_options(max_retry_delay: 5)
      issuer_times = []
      api_attempts = 0
      sleeps = []
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_times << now
          if issuer_times.length == 2
            body = Enumerator.new do |output|
              now += 0.5
              output << ""
            end

            OpenAI::HTTPClient::Response.new(status: 503, headers: headers, body: body)
          else
            response = token_response
            if issuer_times.length > 2
              response = OpenAI::HTTPClient::Response.new(
                status: 200,
                headers: {},
                body: JSON.generate(
                  access_token: "fake-recovered-token",
                  token_type: "Bearer",
                  expires_in: 120,
                  issued_token_type: "urn:ietf:params:oauth:token-type:access_token"
                )
              )
            end

            response
          end
        else
          api_attempts += 1
          api_attempts == 2 ? failure_response(401) : model_response
        end
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        client.stub(
          :sleep,
          -> (delay) {
            sleeps << delay
            now += delay
          }
        ) do
          @native.stub(:execute, dispatch) do
            assert_equal("fake-model", client.models.retrieve("prime").id)
            now = 191.0
            if headers["retry-after"] == "2"
              assert_equal("fake-model", client.models.retrieve("replay").id)
              assert_equal([100.0, 191.0, 193.0], issuer_times)
              assert_equal([1.5], sleeps)
            else
              error = assert_raises(OpenAI::Errors::APIError) { client.models.retrieve("replay") }
              assert_equal(503, error.status)
              assert_equal(headers, error.headers)
              assert_equal([100.0, 191.0], issuer_times)
              assert_empty(sleeps)
              assert_equal("fake-model", client.models.retrieve("new-request").id)
              assert_equal([100.0, 191.0, 191.5], issuer_times)
            end
          end
        end
      end
    end
  end

  def test_cached_fallback_preserves_issuer_minimum_across_api_retry
    ["8", "90", "1e999"].each do |hint|
      client = new_client.with_options(max_retries: 1, max_retry_delay: 10)
      now = 100.0
      issuer_times = []
      api_attempts = 0
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_times << now
          if issuer_times.length == 2
            OpenAI::HTTPClient::Response.new(status: 503, headers: {"retry-after" => hint}, body: "")
          else
            token_response
          end
        else
          api_attempts += 1
          if api_attempts == 2
            OpenAI::HTTPClient::Response.new(status: 503, headers: {"retry-after" => "6"}, body: "")
          else
            model_response
          end
        end
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        client.stub(:sleep, -> (delay) { now += delay }) do
          @native.stub(:execute, dispatch) do
            assert_equal("fake-model", client.models.retrieve("prime").id)
            now = 191.0
            assert_equal("fake-model", client.models.retrieve("retry").id)
          end
        end
      end

      assert_equal(hint == "8" ? [100.0, 191.0, 199.0] : [100.0, 191.0], issuer_times)
      assert_equal(3, api_attempts)
    end
  end

  def test_cached_fallback_minimum_cannot_exceed_the_request_deadline
    client = new_client.with_options(timeout: 1, max_retry_delay: 5)
    now = 100.0
    issuer_attempts = 0
    api_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_attempts += 1
        if issuer_attempts == 1
          token_response
        else
          OpenAI::HTTPClient::Response.new(status: 503, headers: {"retry-after" => "2"}, body: "")
        end
      else
        api_attempts += 1
        api_attempts == 1 ? model_response : failure_response(401)
      end
    end

    OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
      @native.stub(:execute, dispatch) do
        assert_equal("fake-model", client.models.retrieve("prime").id)
        now = 191.0
        assert_raises(OpenAI::Errors::APITimeoutError) { client.models.retrieve("replay") }
      end
    end

    assert_equal(2, issuer_attempts)
    assert_equal(2, api_attempts)
  end

  def test_shared_refresh_waiters_honor_minimum_when_reading_the_issuer_body_fails
    ["2", "90", "1e999"].each do |hint|
      now = 100.0
      issuer_attempts = []
      sleeps = []
      body_started = Queue.new
      release_body = Queue.new
      release_leader = Queue.new
      leader = nil
      waiter = nil
      client = new_client.with_options(
        max_retries: 1,
        initial_retry_delay: 0,
        max_retry_delay: 5,
        on_retry: -> (_event) { release_leader.pop if Thread.current == leader }
      )
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts << [Thread.current, now]
          if issuer_attempts.length == 1
            body = Enumerator.new do |_output|
              body_started << true
              release_body.pop
              raise OpenAI::Errors::APIConnectionError.new(url: request.url, message: "fake-private-body")
            end

            OpenAI::HTTPClient::Response.new(status: 503, headers: {"retry-after" => hint}, body: body)
          else
            token_response
          end
        else
          model_response
        end
      end

      call = lambda do
        client.models.retrieve("fake-model")
      rescue OpenAI::Errors::APIError => error
        error
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        client.stub(
          :sleep,
          -> (delay) {
            sleeps << [Thread.current, delay]
            now += delay
          }
        ) do
          @native.stub(:execute, dispatch) do
            leader = Thread.new(&call)
            Timeout.timeout(1) { body_started.pop }
            waiter = Thread.new(&call)
            Timeout.timeout(1) { Thread.pass until waiter.status == "sleep" }
            release_body << true
            waiter_result = Timeout.timeout(1) { waiter.value }
            release_leader << true
            leader_result = Timeout.timeout(1) { leader.value }

            if hint == "2"
              assert_equal("fake-model", waiter_result.id)
              assert_equal("fake-model", leader_result.id)
              assert_equal([[leader, 100.0], [waiter, 102.0]], issuer_attempts)
              assert_equal([[waiter, 2.0]], sleeps)
            else
              [leader_result, waiter_result].each do |error|
                assert_instance_of(OpenAI::Errors::APIConnectionError, error)
                assert_nil(error.headers)
                assert_nil(error.status)
                refute_includes(error.message, "fake-private-body")
              end

              assert_equal([[leader, 100.0]], issuer_attempts)
              assert_empty(sleeps)
              assert_equal("fake-model", client.models.retrieve("fresh-request").id)
              assert_equal([100.0, 100.0], issuer_attempts.map(&:last))
            end
          end
        end
      end

    ensure
      release_body << true
      release_leader << true
      leader&.kill&.join if leader&.alive?
      waiter&.kill&.join if waiter&.alive?
    end
  end

  def test_cached_participants_inherit_proactive_refresh_minima_before_auth_replay
    ["2", "90", "1e999"].each do |hint|
      now = 100.0
      client = new_client.with_options(max_retry_delay: 5)
      issuer_times = []
      sleeps = []
      issuer_started = Queue.new
      release_issuer = Queue.new
      follower_started = Queue.new
      release_follower = Queue.new
      leader = nil
      follower = nil
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_times << now
          if issuer_times.length == 2
            issuer_started << true
            release_issuer.pop
            body = Enumerator.new do |output|
              now += 0.5
              output << ""
            end

            OpenAI::HTTPClient::Response.new(status: 503, headers: {"retry-after" => hint}, body: body)
          elsif issuer_times.length > 2
            OpenAI::HTTPClient::Response.new(
              status: 200,
              headers: {},
              body: JSON.generate(
                access_token: "fake-recovered-token",
                token_type: "Bearer",
                expires_in: 120,
                issued_token_type: "urn:ietf:params:oauth:token-type:access_token"
              )
            )
          else
            token_response
          end
        elsif request.url.path.end_with?("/follower") && request.headers["authorization"] == "Bearer fake-valid-token"
          follower_started << true
          release_follower.pop
          failure_response(401)
        else
          model_response
        end
      end

      call = lambda do |name|
        client.models.retrieve(name)
      rescue OpenAI::Errors::APIError => error
        error
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        client.stub(
          :sleep,
          -> (delay) {
            sleeps << delay
            now += delay
          }
        ) do
          @native.stub(:execute, dispatch) do
            assert_equal("fake-model", client.models.retrieve("prime").id)
            now = 191.0
            leader = Thread.new { call.call("leader") }
            Timeout.timeout(1) { issuer_started.pop }
            follower = Thread.new { call.call("follower") }
            Timeout.timeout(1) { follower_started.pop }
            release_issuer << true
            assert_equal("fake-model", Timeout.timeout(1) { leader.value }.id)
            release_follower << true
            result = Timeout.timeout(1) { follower.value }

            if hint == "2"
              assert_equal("fake-model", result.id)
              assert_equal([100.0, 191.0, 193.0], issuer_times)
              assert_equal([1.5], sleeps)
            else
              assert_instance_of(OpenAI::Errors::APIError, result)
              assert_equal(503, result.status)
              assert_equal({"retry-after" => hint}, result.headers)
              assert_equal([100.0, 191.0], issuer_times)
              assert_empty(sleeps)
              assert_equal("fake-model", client.models.retrieve("independent-request").id)
              assert_equal([100.0, 191.0, 191.5], issuer_times)
            end
          end
        end
      end

    ensure
      release_issuer&.push(true)
      release_follower&.push(true)
      leader&.kill&.join if leader&.alive?
      follower&.kill&.join if follower&.alive?
    end
  end

  def test_waiting_participant_preserves_an_earlier_stronger_issuer_minimum
    now = 100.0
    events = []
    sleeps = []
    client = new_client.with_options(max_retry_delay: 5, max_retries: 2, on_retry: -> (event) { events << event })
    issuer_times = []
    first_wait = Queue.new
    release_first = Queue.new
    issuer_started = Queue.new
    release_issuer = Queue.new
    first = nil
    second = nil
    paused = false
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_times << now
        case issuer_times.length
        when 1
          token_response
        when 2
          OpenAI::HTTPClient::Response.new(status: 503, headers: {"retry-after" => "90"}, body: "")
        when 3
          issuer_started << true
          release_issuer.pop
          OpenAI::HTTPClient::Response.new(status: 503, headers: {"retry-after" => "1"}, body: "")
        else
          OpenAI::HTTPClient::Response.new(
            status: 200,
            headers: {},
            body: JSON.generate(
              access_token: "fake-recovered-token",
              token_type: "Bearer",
              expires_in: 120,
              issued_token_type: "urn:ietf:params:oauth:token-type:access_token"
            )
          )
        end
      elsif request.url.path.end_with?("/first") && issuer_times.length == 2
        OpenAI::HTTPClient::Response.new(status: 401, headers: {"retry-after" => "0.1"}, body: "")
      else
        model_response
      end
    end

    call = lambda do |name, max_retries|
      client.models.retrieve(name, request_options: {max_retries: max_retries})
    rescue OpenAI::Errors::APIError => error
      error
    end

    OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
      client.stub(
        :sleep,
        -> (delay) {
          sleeps << delay
          if Thread.current == first && !paused
            paused = true
            first_wait << true
            release_first.pop
          end

          now += delay
        }
      ) do
        @native.stub(:execute, dispatch) do
          assert_equal("fake-model", client.models.retrieve("prime").id)
          now = 191.0
          first = Thread.new { call.call("first", 2) }
          Timeout.timeout(1) { first_wait.pop }
          second = Thread.new { call.call("second", 0) }
          Timeout.timeout(1) { issuer_started.pop }
          release_first << true
          Timeout.timeout(1) { Thread.pass until first.status == "sleep" && now > 191.0 }
          release_issuer << true
          first_result = Timeout.timeout(1) { first.value }
          second_result = Timeout.timeout(1) { second.value }
          assert_instance_of(OpenAI::Errors::APIError, first_result)
          assert_equal({"retry-after" => "90"}, first_result.headers)
          assert_instance_of(OpenAI::Errors::APIError, second_result)
          assert_equal({"retry-after" => "1"}, second_result.headers)
          assert_equal([100.0, 191.0, 191.0], issuer_times)
          assert_equal([401], events.map(&:status))
          assert_equal(1, sleeps.length)
          assert_in_delta(0.1, sleeps.first, 0.00001)
        end
      end
    end

  ensure
    release_first&.push(true)
    release_issuer&.push(true)
    first&.kill&.join if first&.alive?
    second&.kill&.join if second&.alive?
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
