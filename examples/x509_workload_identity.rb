#!/usr/bin/env ruby
# frozen_string_literal: true

# This enrolled-credential smoke test performs both a real X.509 token exchange
# and an actual OpenAI mTLS API request. It does not use or require an API key.
# Required: OPENAI_CLIENT_CERTIFICATE_CHAIN, OPENAI_CLIENT_KEY,
# IDENTITY_PROVIDER_ID, SERVICE_ACCOUNT_ID, and an organization enabled for
# certificate-authenticated workload identity. The optional key passphrase is
# OPENAI_CLIENT_KEY_PASSPHRASE. Set OPENAI_X509_PROXY_MODE=http_connect only for
# a caller-configured HTTP CONNECT proxy that keeps proxy credentials isolated.

require_relative "../lib/openai"

chain = OpenSSL::X509::Certificate.load(
  File.binread(ENV.fetch("OPENAI_CLIENT_CERTIFICATE_CHAIN"))
)
raise ArgumentError, "Expected an enrolled client certificate" if chain.empty?

leaf, *intermediates = chain
key = OpenSSL::PKey.read(
  File.binread(ENV.fetch("OPENAI_CLIENT_KEY")),
  ENV["OPENAI_CLIENT_KEY_PASSPHRASE"]
)
raise ArgumentError, "The enrolled certificate and private key do not match" unless leaf.check_private_key(key)

now = Time.now
raise ArgumentError, "The enrolled certificate is not yet valid" if now < leaf.not_before
raise ArgumentError, "The enrolled certificate has expired" if now > leaf.not_after

api_origin = ENV.fetch("OPENAI_X509_API_ORIGIN", "https://mtls.api.openai.com")
api_host = URI(api_origin).host
approved_hosts = ["mtls.auth.openai.com", api_host].freeze
native_http_client = OpenAI::NetHTTPClient.new do |connection|
  unless connection.use_ssl? && connection.port == 443 && approved_hosts.include?(connection.address)
    raise ArgumentError, "Refusing to present the enrolled certificate to an unexpected destination"
  end

  connection.cert = leaf
  connection.extra_chain_cert = intermediates
  connection.key = key
end

transport = OpenAI::Auth::X509Transport.new(
  http_client: native_http_client,
  certificate_identity: :static,
  proxy: ENV.fetch("OPENAI_X509_PROXY_MODE", "direct").to_sym,
  api_origin: api_origin
)
identity = OpenAI::Auth::X509WorkloadIdentity.new(
  identity_provider_id: ENV.fetch("IDENTITY_PROVIDER_ID"),
  service_account_id: ENV.fetch("SERVICE_ACCOUNT_ID")
)
client = OpenAI::Client.new(api_key: nil, workload_identity: identity, http_client: transport)

begin
  model = client.models.list.first
  raise "The enrolled service account cannot access any models" if model.nil?

  puts("[x509] real issuer exchange and mTLS API request succeeded")
ensure
  native_http_client.close
end
