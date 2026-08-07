#!/usr/bin/env ruby
# frozen_string_literal: true

# This example sends an API-key request over mutual TLS by configuring the
# SDK's pooled Net::HTTP connections with Ruby's native OpenSSL support. Set
# OPENAI_CLIENT_CERTIFICATE_CHAIN to a PEM file containing the leaf certificate
# followed by any required intermediates, OPENAI_CLIENT_KEY to the matching
# private key, and OPENAI_MODEL to a model available to the project.
# OPENAI_CLIENT_KEY_PASSPHRASE is optional.

require_relative "../lib/openai"

# Set this to the mTLS endpoint for your data residency. EU Data Residency uses
# https://mtls-eu.api.openai.com/v1. For enrollment and current endpoint
# guidance, see:
# https://help.openai.com/en/articles/10876024-openai-mutual-tls-beta-program
mtls_endpoint = URI("https://mtls.api.openai.com/v1")
certificates = OpenSSL::X509::Certificate.load(
  File.binread(ENV.fetch("OPENAI_CLIENT_CERTIFICATE_CHAIN"))
)
raise ArgumentError, "Expected a client certificate" if certificates.empty?

leaf_certificate, *intermediates = certificates
private_key = OpenSSL::PKey.read(
  File.binread(ENV.fetch("OPENAI_CLIENT_KEY")),
  ENV["OPENAI_CLIENT_KEY_PASSPHRASE"]
)
unless leaf_certificate.check_private_key(private_key)
  raise ArgumentError, "The client certificate and private key do not match"
end

now = Time.now
raise ArgumentError, "The client certificate is not yet valid" if now < leaf_certificate.not_before
raise ArgumentError, "The client certificate has expired" if now > leaf_certificate.not_after

mtls_destination = [mtls_endpoint.host, mtls_endpoint.port]
http_client = OpenAI::NetHTTPClient.new do |http|
  unless http.use_ssl? && mtls_destination == [http.address, http.port]
    raise ArgumentError, "Refusing to present the client certificate to an unexpected origin"
  end

  http.cert = leaf_certificate
  http.extra_chain_cert = intermediates
  http.key = private_key
end

client = OpenAI::Client.new(
  api_key: ENV.fetch("OPENAI_API_KEY"),
  base_url: mtls_endpoint.to_s,
  http_client: http_client
)

begin
  response = client.responses.create(
    model: ENV.fetch("OPENAI_MODEL"),
    input: "Reply with: mTLS transport configured"
  )
  puts(response.output_text)
ensure
  http_client.close
end
