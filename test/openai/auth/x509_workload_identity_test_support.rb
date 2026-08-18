# frozen_string_literal: true

require_relative "../test_helper"

module X509WorkloadIdentityTestSupport
  class StubHTTPClient < OpenAI::HTTPClient
    attr_reader :requests

    def initialize(&execute)
      super()
      @execute = execute
      @requests = []
      @mutex = Mutex.new
    end

    def execute(request)
      @mutex.synchronize { @requests << request }
      @execute.call(request)
    end
  end

  private

  def x509_config(refresh_buffer_seconds: 1200)
    OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      refresh_buffer_seconds: refresh_buffer_seconds
    )
  end

  def x509_auth(
    http_client,
    sleeper: -> (_delay) { nil },
    monotonic_clock: nil,
    refresh_buffer_seconds: 1200
  )
    kwargs = {http_client: http_client, sleeper: sleeper}
    kwargs[:monotonic_clock] = monotonic_clock unless monotonic_clock.nil?
    OpenAI::Auth::WorkloadIdentityAuth.new(
      x509_config(refresh_buffer_seconds: refresh_buffer_seconds),
      nil,
      **kwargs
    )
  end

  def x509_client(http_client)
    OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client,
      max_retries: 0
    )
  end

  def http_response(status:, body:, headers: {})
    body = JSON.generate(body) unless body.is_a?(String)
    OpenAI::HTTPClient::Response.new(
      status: status,
      headers: {"content-type" => "application/json"}.merge(headers),
      body: body
    )
  end
end
