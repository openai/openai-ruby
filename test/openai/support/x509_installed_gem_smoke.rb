# frozen_string_literal: true

# This runs in an isolated Ruby process with only the built gem on its SDK load
# path. The source checkout supplies ephemeral test PKI, never SDK classes.
require "openai"

module OpenAI
  module Test
  end
end

require_relative "mtls_wire_harness"

harness = OpenAI::Test::MTLSWireHarness
hostnames = %w[mtls.auth.openai.com mtls.api.openai.com]
pki = harness::PKI.new(hostnames: hostnames)
issuer = harness::MTLSServer.new(
  hostname: hostnames.fetch(0),
  pki: pki,
  body: {
    access_token: "fake-installed-gem-token",
    issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
    token_type: "Bearer",
    expires_in: 120
  }
)
api = harness::MTLSServer.new(
  hostname: hostnames.fetch(1),
  pki: pki,
  body: {id: "fake-packaged-model", created: 1, object: "model", owned_by: "openai"}
)
proxy = harness::ConnectProxy.new(
  authority_ports: {
    "#{issuer.hostname}:443" => issuer.local_port,
    "#{api.hostname}:443" => api.local_port
  },
  expected_connections: 2
)
certificate = pki.client_identity
native = OpenAI::NetHTTPClient.new(size: 1) do |connection|
  harness.configure_http_connect_proxy(connection, proxy.uri)
  connection.cert_store = pki.trust_store
  connection.cert = certificate.certificate
  connection.extra_chain_cert = [pki.intermediate_certificate]
  connection.key = certificate.key
end

transport = OpenAI::Auth::X509Transport.new(
  http_client: native,
  certificate_identity: :static,
  proxy: :http_connect
)
identity = OpenAI::Auth::X509WorkloadIdentity.new(
  identity_provider_id: "idp_fake_packaged",
  service_account_id: "svc_acct_fake_packaged"
)
client = OpenAI::Client.new(api_key: nil, workload_identity: identity, http_client: transport)

begin
  harness.with_proxy_environment(proxy.uri) do
    result = client.models.retrieve("fake-packaged-model")
    raise "Unexpected installed-gem API result" unless result.id == "fake-packaged-model"
  end

  native.close
  issuer_record = issuer.finish.fetch(0)
  api_record = api.finish.fetch(0)
  proxy_records = proxy.finish

  expected_identity = certificate.certificate.to_der
  unless issuer_record.peer_certificate.to_der == expected_identity &&
      api_record.peer_certificate.to_der == expected_identity
    raise "The installed gem did not present the expected certificate on both TLS legs"
  end

  raise "Issuer received an API credential" if issuer_record.headers.key?("authorization")
  unless api_record.headers["authorization"] == "Bearer fake-installed-gem-token"
    raise "The installed gem did not present the exchanged bearer at the API"
  end

  if proxy_records.any? { _1.headers.key?("authorization") }
    raise "The installed gem leaked an API bearer to the CONNECT proxy"
  end

  puts("installed gem X.509 issuer/API mTLS verification passed")
ensure
  native&.close
  proxy&.close
  issuer&.close
  api&.close
end
