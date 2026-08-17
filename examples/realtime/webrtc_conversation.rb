#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module WebRTCConversation
        LOOPBACK_HOSTS = ["127.0.0.1", "::1"].freeze

        class App
          def initialize(
            client:,
            origin: "http://127.0.0.1:4567",
            html: File.binread(File.join(__dir__, "webrtc_conversation.html"))
          )
            @client = client
            origin = URI(origin)
            @expected_host = expected_host(origin)
            @expected_origin = "#{origin.scheme}://#{@expected_host}"
            @html = html
          end

          def handle(request, response)
            unless authorized?(request)
              return render(
                response,
                status: 403,
                content_type: "text/plain; charset=utf-8",
                body: "Forbidden\n"
              )
            end

            case [request.request_method, request.path]
            when ["GET", "/"]
              render(response, status: 200, content_type: "text/html; charset=utf-8", body: @html)
            when ["POST", "/token"]
              create_client_secret(response)
            else
              render(response, status: 404, content_type: "text/plain; charset=utf-8", body: "Not found\n")
            end
          rescue ArgumentError => e
            render(response, status: 400, content_type: "text/plain; charset=utf-8", body: "#{e.message}\n")
          rescue StandardError => e
            warn("Realtime WebRTC request failed: #{e.class}: #{e.message}")
            render(
              response,
              status: 502,
              content_type: "text/plain; charset=utf-8",
              body: "Realtime request failed\n"
            )
          end

          private def create_client_secret(response)
            secret = @client.realtime.client_secrets.create(session: session_config)
            body = JSON.generate(value: secret.value, expires_at: secret.expires_at)
            render(response, status: 201, content_type: "application/json", body: body)
          end

          private def authorized?(request)
            return false unless request["host"].to_s.downcase == @expected_host.downcase
            return true if request.request_method == "GET"

            request["origin"].to_s == @expected_origin
          end

          private def expected_host(origin)
            host = origin.hostname
            unless origin.scheme == "http" && host && origin.userinfo.nil? &&
                   ["", "/"].include?(origin.path) && origin.query.nil? && origin.fragment.nil?
              raise ArgumentError, "Expected an HTTP origin without a path, query, or credentials"
            end

            authority_host = host.include?(":") ? "[#{host}]" : host
            origin.port == origin.default_port ? authority_host : "#{authority_host}:#{origin.port}"
          end

          private def session_config
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
                    threshold: 0.5,
                    prefix_padding_ms: 300,
                    silence_duration_ms: 700,
                    create_response: true,
                    interrupt_response: true
                  }
                },
                output: {voice: ENV.fetch("OPENAI_REALTIME_VOICE", "marin")}
              }
            }
          end

          private def render(response, status:, content_type:, body:)
            response.status = status
            response["Content-Type"] = content_type
            response["Cache-Control"] = "no-store"
            response["X-Content-Type-Options"] = "nosniff"
            response["Cross-Origin-Resource-Policy"] = "same-origin"
            response["Content-Security-Policy"] =
              "default-src 'self'; connect-src 'self' https://api.openai.com; media-src 'self' blob:; " \
              "script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; " \
              "base-uri 'none'; form-action 'none'; frame-ancestors 'none'"
            response.body = body
          end
        end

        module_function

        def demo_origin(host:, port:)
          unless LOOPBACK_HOSTS.include?(host)
            raise ArgumentError, "REALTIME_DEMO_HOST must be a loopback address (127.0.0.1 or ::1)"
          end

          origin_host = host.include?(":") ? "[#{host}]" : host
          "http://#{origin_host}:#{port}"
        end

        def run
          require("webrick")

          host = ENV.fetch("REALTIME_DEMO_HOST", "127.0.0.1")
          port = Integer(ENV.fetch("REALTIME_DEMO_PORT", "4567"))
          origin = demo_origin(host: host, port: port)
          app = App.new(client: OpenAI::Client.new, origin: origin)
          server = WEBrick::HTTPServer.new(
            BindAddress: host,
            Port: port,
            Logger: WEBrick::Log.new($stderr, WEBrick::BasicLog::WARN),
            AccessLog: []
          )
          server.mount_proc("/") { |request, response| app.handle(request, response) }
          shutdown = proc { server.shutdown }
          Signal.trap("INT", &shutdown)
          Signal.trap("TERM", &shutdown)
          puts("Open #{origin} and click Start conversation. Press Ctrl-C here to stop.")
          server.start
        rescue LoadError
          raise "webrick is required; run `bundle install` before starting this example"
        end
      end
    end
  end
end

OpenAI::Examples::Realtime::WebRTCConversation.run if $PROGRAM_NAME == __FILE__
