#!/usr/bin/env ruby
# frozen_string_literal: true

# Toggle between ordinary API-key auth and HTTP X.509 workload identity with:
#
#   OPENAI_AUTH_MODE=api_key
#   OPENAI_AUTH_MODE=x509
#
# X.509 mode expects a PEM certificate chain (leaf first), its matching PEM
# private key, and the workload identity provider/service-account IDs. The
# private key may be encrypted; set OPENAI_MTLS_PRIVATE_KEY_PASSWORD when it is.

require_relative "../lib/openai"

auth_mode = ENV.fetch("OPENAI_AUTH_MODE", "api_key")
http_client = nil

client =
  case auth_mode
  when "api_key"
    OpenAI::Client.new
  when "x509"
    api_endpoint = URI(ENV.fetch("OPENAI_BASE_URL", "https://mtls.api.openai.com/v1"))
    valid_endpoint =
      api_endpoint.scheme&.casecmp?("https") &&
      !api_endpoint.host.to_s.empty? &&
      api_endpoint.userinfo.nil? &&
      !api_endpoint.host.include?("%") &&
      !api_endpoint.host.include?("\\")
    unless valid_endpoint
      raise ArgumentError, "OPENAI_BASE_URL must be an HTTPS URL without user information"
    end

    certificates = OpenSSL::X509::Certificate.load(
      File.binread(ENV.fetch("OPENAI_MTLS_CERTIFICATE_CHAIN"))
    )
    raise ArgumentError, "Expected a client certificate" if certificates.empty?

    leaf_certificate, *intermediates = certificates
    private_key = OpenSSL::PKey.read(
      File.binread(ENV.fetch("OPENAI_MTLS_PRIVATE_KEY")),
      ENV["OPENAI_MTLS_PRIVATE_KEY_PASSWORD"]
    )
    unless leaf_certificate.check_private_key(private_key)
      raise ArgumentError, "The client certificate and private key do not match"
    end

    allowed_destinations = [
      ["mtls.auth.openai.com", 443],
      [api_endpoint.host, api_endpoint.port]
    ].uniq.freeze
    http_client = OpenAI::NetHTTPClient.new do |http|
      unless http.use_ssl? && allowed_destinations.include?([http.address, http.port])
        raise ArgumentError, "Refusing to present the client certificate to an unexpected origin"
      end

      http.cert = leaf_certificate
      http.extra_chain_cert = intermediates
      http.key = private_key
    end

    OpenAI::Client.new(
      api_key: nil,
      workload_identity: OpenAI::Auth::X509WorkloadIdentity.new(
        identity_provider_id: ENV.fetch("OPENAI_IDENTITY_PROVIDER_ID"),
        service_account_id: ENV.fetch("OPENAI_SERVICE_ACCOUNT_ID")
      ),
      base_url: ENV["OPENAI_BASE_URL"],
      http_client: http_client
    )
  else
    raise ArgumentError, "OPENAI_AUTH_MODE must be api_key or x509"
  end

begin
  response = client.responses.create(
    model: ENV.fetch("OPENAI_MODEL"),
    input: "Reply with: workload identity configured"
  )
  puts(response.output_text)
ensure
  # The application owns an injected transport and closes it after in-flight
  # work completes. The SDK never closes caller-supplied HTTP clients.
  http_client&.close
end
