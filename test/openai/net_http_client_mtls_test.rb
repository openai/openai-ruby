# frozen_string_literal: true

require_relative "test_helper"
require_relative "support/mtls_wire_harness"
require "open3"
require "rbconfig"

# This characterizes Net::HTTP wire behavior only. The static token response is
# a bearer-transfer canary, not an implementation of the X.509 exchange protocol.
class OpenAI::Test::NetHTTPClientMTLSTest < Minitest::Test
  Harness = OpenAI::Test::MTLSWireHarness
  SUBPROCESS_ENV = "OPENAI_RUBY_MTLS_WIRE_SUBPROCESS"
  SUBPROCESS_TIMEOUT = 15
  SUBPROCESS_TERM_GRACE = 1

  def test_wire_observations_cover_client_identity_chain_and_credential_boundaries
    return run_wire_observations if ENV[SUBPROCESS_ENV] == "1"

    # Other Minitest resource tests remain concurrent. Isolating the proxy
    # environment prevents this real-wire scenario from rerouting their traffic.
    output, status = run_in_subprocess
    assert_predicate(status, :success?, output)
  end

  private def run_in_subprocess
    input, output, waiter = Open3.popen2e(
      {SUBPROCESS_ENV => "1"},
      RbConfig.ruby,
      File.expand_path(__FILE__)
    )
    input.close
    reader = Thread.new { output.read }
    timed_out = waiter.join(SUBPROCESS_TIMEOUT).nil?
    terminate_subprocess(waiter) if timed_out
    captured = reader.value
    captured << "\nmTLS wire subprocess exceeded #{SUBPROCESS_TIMEOUT} seconds\n" if timed_out
    [captured, waiter.value]
  ensure
    unless waiter.nil?
      begin
        Process.kill("KILL", waiter.pid) if waiter.alive?
      rescue Errno::ESRCH
        nil
      end

      waiter.join
    end

    input&.close unless input&.closed?
    output&.close unless output&.closed?
    reader&.kill if reader&.alive?
    reader&.join
  end

  private def terminate_subprocess(waiter)
    Process.kill("TERM", waiter.pid)
    return unless waiter.join(SUBPROCESS_TERM_GRACE).nil?

    Process.kill("KILL", waiter.pid)
    waiter.join
  rescue Errno::ESRCH
    waiter.join
  end

  private def run_wire_observations
    hostnames = %w[
      token.x509.test
      api.x509.test
      missing-certificate.x509.test
      incomplete-chain.x509.test
      other-server.x509.test
    ]
    pki = Harness::PKI.new(hostnames: hostnames)
    servers = {
      "token.x509.test" => Harness::MTLSServer.new(
        hostname: "token.x509.test",
        pki: pki,
        body: {access_token: "fake-api-access-token"}
      ),
      "api.x509.test" => Harness::MTLSServer.new(
        hostname: "api.x509.test",
        pki: pki,
        body: {host: "api.x509.test"},
        expected_connections: 2
      ),
      "missing-certificate.x509.test" => Harness::MTLSServer.new(
        hostname: "missing-certificate.x509.test",
        pki: pki
      ),
      "incomplete-chain.x509.test" => Harness::MTLSServer.new(
        hostname: "incomplete-chain.x509.test",
        pki: pki
      ),
      "mismatched-server.x509.test" => Harness::MTLSServer.new(
        hostname: "mismatched-server.x509.test",
        certificate_hostname: "other-server.x509.test",
        pki: pki
      )
    }

    authority_ports = servers.to_h { |hostname, server| ["#{hostname}:443", server.local_port] }
    connection_hosts = %w[
      token.x509.test
      api.x509.test
      api.x509.test
      missing-certificate.x509.test
      incomplete-chain.x509.test
      mismatched-server.x509.test
    ]
    proxy = Harness::ConnectProxy.new(
      authority_ports: authority_ports,
      expected_connections: connection_hosts.length
    )

    passphrase = "fake-test-passphrase"
    certificates = OpenSSL::X509::Certificate.load(pki.client_chain_pem)
    private_key = OpenSSL::PKey.read(pki.encrypted_client_key_pem(passphrase), passphrase)
    assert_equal(2, certificates.length)
    assert_equal(certificates.first.public_key.to_der, private_key.public_key.to_der)

    configured_destinations = []
    http_client = OpenAI::NetHTTPClient.new(size: 1) do |http|
      configured_destinations << [http.address, http.port]
      configure_tls(
        http,
        trust_store: pki.trust_store,
        certificate: certificates.first,
        chain: certificates.drop(1),
        private_key: private_key
      )
    end

    missing_certificate_client = OpenAI::NetHTTPClient.new(size: 1) do |http|
      configure_tls(http, trust_store: pki.trust_store)
    end

    incomplete_chain_client = OpenAI::NetHTTPClient.new(size: 1) do |http|
      configure_tls(
        http,
        trust_store: pki.trust_store,
        certificate: certificates.first,
        private_key: private_key
      )
    end

    alternate_identity_client = OpenAI::NetHTTPClient.new(size: 1) do |http|
      identity = pki.client_identity(:b)
      configure_tls(
        http,
        trust_store: pki.trust_store,
        certificate: identity.certificate,
        chain: [pki.intermediate_certificate],
        private_key: identity.key
      )
    end

    Harness.with_proxy_environment(proxy.uri) do
      token_response = execute(http_client, servers.fetch("token.x509.test").url)
      token = token_response.fetch("access_token")
      api_response = execute(
        http_client,
        servers.fetch("api.x509.test").url,
        headers: {"authorization" => "Bearer #{token}"}
      )
      alternate_api_response = execute(
        alternate_identity_client,
        servers.fetch("api.x509.test").url,
        headers: {"authorization" => "Bearer #{token}"}
      )
      assert_equal({"host" => "api.x509.test"}, api_response)
      assert_equal({"host" => "api.x509.test"}, alternate_api_response)

      assert_raises(OpenAI::Errors::APIConnectionError) do
        execute(missing_certificate_client, servers.fetch("missing-certificate.x509.test").url)
      end

      assert_raises(OpenAI::Errors::APIConnectionError) do
        execute(incomplete_chain_client, servers.fetch("incomplete-chain.x509.test").url)
      end

      assert_raises(OpenAI::Errors::APIConnectionError) do
        execute(http_client, servers.fetch("mismatched-server.x509.test").url)
      end
    end

    http_client.close
    missing_certificate_client.close
    incomplete_chain_client.close
    alternate_identity_client.close
    proxy_records = proxy.finish
    server_records = servers.transform_values(&:finish)

    assert_equal(
      [
        ["token.x509.test", 443],
        ["api.x509.test", 443],
        ["mismatched-server.x509.test", 443]
      ],
      configured_destinations
    )
    assert_proxy_credentials_are_isolated(proxy_records, connection_hosts)
    assert_origin_credentials_are_isolated(server_records)
    assert_client_chain_was_presented(server_records, pki)
    assert_server_names_match_http_authorities(server_records)

    assert_handshake_failed_before_request(server_records, "missing-certificate.x509.test")
    assert_handshake_failed_before_request(server_records, "incomplete-chain.x509.test")
    assert_no_request_was_received(server_records, "mismatched-server.x509.test")
  ensure
    http_client&.close
    missing_certificate_client&.close
    incomplete_chain_client&.close
    alternate_identity_client&.close
    proxy&.close
    servers&.each_value(&:close)
  end

  private def configure_tls(http, trust_store:, certificate: nil, chain: [], private_key: nil)
    http.cert_store = trust_store
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.verify_hostname = true
    return if certificate.nil?

    http.cert = certificate
    http.extra_chain_cert = chain
    http.key = private_key
  end

  private def execute(http_client, url, headers: {})
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: url,
      headers: headers,
      body: nil,
      timeout: 2
    )
    response = http_client.execute(request)
    JSON.parse(response.body.to_a.join)
  end

  private def assert_proxy_credentials_are_isolated(records, hostnames)
    assert_equal(hostnames.map { "#{_1}:443" }, records.map(&:authority))
    expected_proxy_authorization = "Basic cHJveHktdXNlcjpwcm94eS1wYXNz"
    records.each do |record|
      assert_equal(expected_proxy_authorization, record.headers.fetch("proxy-authorization"))
      refute_includes(record.headers, "authorization")
    end
  end

  private def assert_origin_credentials_are_isolated(records)
    token_headers = records.fetch("token.x509.test").fetch(0).headers
    api_records = records.fetch("api.x509.test")
    refute_includes(token_headers, "authorization")
    api_records.each do |record|
      assert_equal("Bearer fake-api-access-token", record.headers.fetch("authorization"))
    end

    records.each_value do |host_records|
      host_records.each { refute_includes(_1.headers, "proxy-authorization") }
    end
  end

  private def assert_client_chain_was_presented(records, pki)
    expected_intermediate = pki.intermediate_certificate.to_der
    token_record = records.fetch("token.x509.test").fetch(0)
    api_records = records.fetch("api.x509.test")
    expected_leaves = [
      pki.client_identity(:a).certificate.to_der,
      pki.client_identity(:b).certificate.to_der
    ]
    assert_equal(expected_leaves.fetch(0), token_record.peer_certificate.to_der)
    assert_equal(expected_leaves, api_records.map { _1.peer_certificate.to_der })
    [token_record, *api_records].each do |record|
      assert_nil(record.handshake_error)
      assert_includes(record.peer_certificate_chain.map(&:to_der), expected_intermediate)
    end
  end

  private def assert_server_names_match_http_authorities(records)
    records.each do |hostname, host_records|
      host_records.each do |record|
        assert_equal(hostname, record.server_name)
        next if record.request_line.nil?

        assert_equal(hostname, record.headers.fetch("host"))
      end
    end
  end

  private def assert_handshake_failed_before_request(records, hostname)
    record = records.fetch(hostname).fetch(0)
    assert_nil(record.request_line)
    assert_instance_of(OpenSSL::SSL::SSLError, record.handshake_error)
  end

  private def assert_no_request_was_received(records, hostname)
    assert_nil(records.fetch(hostname).fetch(0).request_line)
  end
end
