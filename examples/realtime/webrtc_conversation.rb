#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"
require "async/http/endpoint"
require "async/http/server"

module OpenAI
  module Examples
    module Realtime
      module WebRTCConversation
        LOOPBACK_HOSTS = ["127.0.0.1", "::1"].freeze
        TOKEN_LIFETIME_SECONDS = 60
        ISSUANCES_PER_MINUTE = 5
        SECURITY_HEADERS = {
          "cache-control" => "no-store",
          "pragma" => "no-cache",
          "referrer-policy" => "no-referrer",
          "x-content-type-options" => "nosniff",
          "cross-origin-resource-policy" => "same-origin",
          "permissions-policy" => "microphone=(self)"
        }.freeze

        class StrictHTTPConnection < ::Async::HTTP::Protocol::HTTP1::Server
          def next_request
            super
          rescue ::Protocol::HTTP1::BadRequest
            nil
          end

          def read_request_line
            line = super
            return unless line

            _method, target, _version = line
            raise ::Protocol::HTTP1::BadRequest, "Expected an origin-form request target" unless target.start_with?("/")

            line
          end

          def read_headers
            headers = super
            normalized = headers.to_h
            if normalized.key?("transfer-encoding") ||
                normalized.key?("upgrade") ||
                (normalized.key?("content-length") && normalized.fetch("content-length") != "0")
              raise ::Protocol::HTTP1::BadRequest, "Request bodies and protocol upgrades are unsupported"
            end

            headers
          rescue ::Protocol::HTTP::DuplicateHeaderError
            raise ::Protocol::HTTP1::BadRequest, "Duplicate singleton HTTP request header", cause: nil
          end

          def fail_request(status)
            @persistent = false
            headers = SECURITY_HEADERS.merge("content-security-policy" => "default-src 'none'; frame-ancestors 'none'")
            write_response(@version, status, headers)
            write_body(@version, nil)
          rescue IOError, SystemCallError
            nil
          end
        end

        module StrictHTTPProtocol
          module_function

          def server(peer, **options)
            StrictHTTPConnection.new(::IO::Stream(peer), "HTTP/1.1", **options)
          end
        end

        class App
          def initialize(
            client:,
            origin:,
            authorization_policy:,
            html: File.binread(File.join(__dir__, "webrtc_conversation.html")),
            csrf_token: SecureRandom.hex(32),
            clock: -> { Process.clock_gettime(Process::CLOCK_MONOTONIC) },
            error_output: $stderr
          )
            @client = client
            @expected_host, @expected_origin = validated_origin(origin)
            @authorization_policy = authorization_policy
            @csrf_token = csrf_token
            @nonce = SecureRandom.hex(24)
            @html = html.gsub("__CSP_NONCE__", @nonce).gsub("__CSRF_TOKEN__", @csrf_token)
            @clock = clock
            @error_output = error_output
            @issued_at = Hash.new { |issuances, principal| issuances[principal] = [] }
            @issuance_lock = Mutex.new
          end

          def call(request)
            return render(403, "Forbidden\n") unless trusted_host?(request)

            case [request.method, request.path]
            when ["GET", "/"]
              render(200, @html, content_type: "text/html; charset=utf-8")
            when ["POST", "/token"]
              issue_client_secret(request)
            else
              render(404, "Not found\n")
            end

          rescue StandardError => error
            @error_output.puts("[realtime] token issuance failed: #{error.class}")
            render(502, "Realtime request failed\n")
          end

          private

          def issue_client_secret(request)
            return render(403, "Forbidden\n") unless trusted_origin?(request)

            authorization = single_header(request, "authorization")
            bearer_token = authorization&.delete_prefix("Bearer ")
            return render(401, "Unauthorized\n") if bearer_token.nil? || bearer_token == authorization

            principal = @authorization_policy.call(bearer_token, request)
            return render(403, "Forbidden\n") unless principal.is_a?(String) && !principal.empty?
            return render(429, "Too many requests\n") unless reserve_issuance(principal)

            secret = @client.realtime.client_secrets.create(
              expires_after: {anchor: :created_at, seconds: TOKEN_LIFETIME_SECONDS},
              session: session_configuration
            )

            render(
              201,
              JSON.generate(value: secret.value, expires_at: secret.expires_at),
              content_type: "application/json"
            )
          end

          def trusted_host?(request)
            host = single_header(request, "host")
            authority = request.authority
            return false unless (authority || host)&.casecmp?(@expected_host)

            host.nil? || host.casecmp?(@expected_host)
          end

          def trusted_origin?(request)
            single_header(request, "origin") == @expected_origin &&
              secure_match?(single_header(request, "x-realtime-csrf"), @csrf_token)
          end

          def single_header(request, name)
            values = request.headers.to_a.filter_map do |key, value|
              value if key.casecmp?(name)
            end

            return unless values.length == 1 && values.fetch(0).is_a?(String)

            value = values.fetch(0)
            value unless value.match?(/[\r\n\x00]/)
          end

          def reserve_issuance(principal)
            @issuance_lock.synchronize do
              now = @clock.call
              issuances = @issued_at[principal]
              issuances.reject! { |issued_at| now - issued_at >= 60 }
              return false if issuances.length >= ISSUANCES_PER_MINUTE

              issuances << now
              true
            end
          end

          def validated_origin(value)
            origin = URI.parse(value)
            host = origin.hostname
            unless origin.scheme == "http" &&
                LOOPBACK_HOSTS.include?(host) &&
                origin.userinfo.nil? &&
                ["", "/"].include?(origin.path) &&
                origin.query.nil? &&
                origin.fragment.nil?
              raise ArgumentError, "Expected an HTTP loopback origin without credentials or a path"
            end

            authority_host = host.include?(":") ? "[#{host}]" : host
            authority = origin.port == origin.default_port ? authority_host : "#{authority_host}:#{origin.port}"
            [authority, "#{origin.scheme}://#{authority}"]
          rescue URI::InvalidURIError
            raise ArgumentError, "Expected an HTTP loopback origin without credentials or a path"
          end

          def session_configuration
            {
              type: :realtime,
              model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
              output_modalities: [:audio],
              instructions: ENV.fetch(
                "OPENAI_REALTIME_INSTRUCTIONS",
                "Have a natural spoken conversation. Keep each response concise."
              ),
              audio: {
                input: {
                  turn_detection: {
                    type: :server_vad,
                    create_response: true,
                    interrupt_response: true
                  }
                },
                output: {voice: ENV.fetch("OPENAI_REALTIME_VOICE", "marin")}
              }
            }
          end

          def render(status, body, content_type: "text/plain; charset=utf-8")
            headers = SECURITY_HEADERS.merge(
              "content-type" => content_type,
              "content-security-policy" => "default-src 'none'; connect-src 'self' https://api.openai.com; " \
                "media-src 'self' blob:; script-src 'nonce-#{@nonce}'; " \
                "style-src 'nonce-#{@nonce}'; base-uri 'none'; " \
                "form-action 'none'; frame-ancestors 'none'"
            )
            ::Protocol::HTTP::Response[status, headers, [body]]
          end

          def secure_match?(actual, expected)
            return false unless actual.is_a?(String)

            OpenSSL.fixed_length_secure_compare(
              OpenSSL::Digest::SHA256.digest(actual),
              OpenSSL::Digest::SHA256.digest(expected)
            )
          end
        end

        module_function

        def run
          application_token = ENV.fetch("REALTIME_DEMO_AUTH_TOKEN")
          principal = ENV.fetch("REALTIME_DEMO_USER_ID")
          unless application_token.bytesize >= 32 && !principal.empty?
            raise ArgumentError, "Provide a 32-character application token and a nonempty authorized user ID"
          end

          host = ENV.fetch("REALTIME_DEMO_HOST", "127.0.0.1")
          port = Integer(ENV.fetch("REALTIME_DEMO_PORT", "4567"))
          raise ArgumentError, "REALTIME_DEMO_HOST must be a loopback address" unless LOOPBACK_HOSTS.include?(host)
          raise ArgumentError, "REALTIME_DEMO_PORT must be between 1 and 65535" unless (1..65_535).cover?(port)

          authority = host.include?(":") ? "[#{host}]:#{port}" : "#{host}:#{port}"
          origin = "http://#{authority}"
          policy = lambda do |provided_token, _request|
            expected_digest = OpenSSL::Digest::SHA256.digest(application_token)
            provided_digest = OpenSSL::Digest::SHA256.digest(provided_token)
            principal if OpenSSL.fixed_length_secure_compare(provided_digest, expected_digest)
          end

          app = App.new(client: OpenAI::Client.new, origin: origin, authorization_policy: policy)
          endpoint = ::Async::HTTP::Endpoint.parse(origin)
          server = ::Async::HTTP::Server.new(app, endpoint, protocol: StrictHTTPProtocol)

          puts("Open #{origin}, enter your application token, and start a conversation.")
          server.run.wait
        end
      end
    end
  end
end

OpenAI::Examples::Realtime::WebRTCConversation.run if $PROGRAM_NAME == __FILE__
