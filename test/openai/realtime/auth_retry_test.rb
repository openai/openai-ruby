# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::RealtimeAuthRetryTest < Minitest::Test
  class Socket
    def closed? = @closed == true
    def close(code: 1000, reason: "")
      @closed = true
      [code, reason]
    end
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
        raise OpenAI::Errors::RealtimeConnectionError.new(
          url: url,
          message: "upgrade rejected",
          http_status: 401
        )
      end

      yield(Socket.new)
    end
  end

  def test_workload_identity_refreshes_once_after_a_definitive_upgrade_401
    client = workload_identity_client
    transport = RejectOnceTransport.new
    tokens = ["stale-token", "fresh-token"]
    invalidations = 0

    client.workload_identity_auth.stub(:get_token, -> { tokens.shift }) do
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
  end

  def test_workload_identity_does_not_retry_a_second_upgrade_401
    client = workload_identity_client
    transport = RejectOnceTransport.new(reject_every_attempt: true)
    tokens = ["stale-token", "fresh-token"]
    invalidations = 0

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      client.workload_identity_auth.stub(:get_token, -> { tokens.shift }) do
        client.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
          client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |_connection|
            nil
          end
        end
      end
    end

    assert_equal(401, error.http_status)
    assert_equal(1, invalidations)
    assert_equal(2, transport.attempts.length)
  end

  private def workload_identity_client
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
      base_url: "https://example.com/v1"
    )
  end
end
