#!/usr/bin/env ruby
# frozen_string_literal: true

require "async/http/server"
require "async/http/endpoint"
require "protocol/http/response"
require "json"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Live
      # Local demonstration only. Deployments need application authentication,
      # authorization, spend controls, and their own session ownership policy.
      class Conversation
        ASSETS = {
          "/" => ["index.html", "text/html; charset=utf-8"],
          "/conversation.mjs" => ["conversation.mjs", "text/javascript; charset=utf-8"],
          "/page.mjs" => ["page.mjs", "text/javascript; charset=utf-8"],
          "/style.css" => ["style.css", "text/css; charset=utf-8"]
        }.freeze

        def initialize(client:, port:, model: "gpt-live-1", backend_model: "gpt-5.6-luna")
          unless port.is_a?(Integer) && (1..65_535).cover?(port)
            raise ArgumentError, "port must be between 1 and 65535"
          end

          @client = client
          @authorities = ["127.0.0.1:#{port}"]
          # Browsers omit the default HTTP port.
          @authorities << "127.0.0.1" if port == 80
          @origins = @authorities.map { "http://#{_1}" }
          @model = model
          @backend_model = backend_model
          @creating = false
        end

        def call(request)
          return response(403, "Forbidden") unless @authorities.include?(request.authority)

          if request.method == "GET" && (asset = ASSETS[request.path])
            return response(200, File.read(File.join(__dir__, "conversation", asset.first)), asset.last)
          end

          return response(404, "Not found") unless request.path == "/session"
          return response(405, "Method not allowed") unless request.method == "POST"
          return response(403, "Forbidden") unless @origins.any? { request.headers["origin"] == [_1] }
          return response(415, "Expected application/sdp") unless request.headers["content-type"] == "application/sdp"
          return response(409, "Session creation already in progress") if @creating

          create_session(request)
        rescue StandardError
          # Never return or log SDK exception details, SDP, paths or credentials.
          response(502, "Session creation failed; remote finalization is unconfirmed.")
        ensure
          request.body&.close
        end

        private def create_session(request)
          @creating = true
          Async::Task.current.with_timeout(20) do
            offer = request.body&.join
            return response(400, "An SDP offer is required") if offer.nil? || offer.empty?

            result = @client.live.create(
              session: {
                model: @model,
                store: false,
                instructions: "Have a friendly, concise voice conversation. Let the user interrupt. " \
                  "Delegate questions requiring reasoning to the backend.",
                delegation: {
                  type: :responses,
                  responses: {model: @backend_model, tools: [], instructions: "Answer briefly and accurately."}
                },
                client: {
                  data_channel: {
                    allowed_client_events: ["session.close"],
                    allowed_server_events: %w[session.started session.closed error].map { {type: _1} }
                  }
                }
              },
              transport: {type: :webrtc, sdp: offer},
              request_options: {timeout: 15, max_retries: 0}
            )
            response(
              201,
              JSON.generate({session: {id: result.session.id}, transport: {type: "webrtc", sdp: result.transport.sdp}}),
              "application/json"
            )
          end

        ensure
          @creating = false
        end

        private def response(status, body, content_type = "text/plain; charset=utf-8")
          Protocol::HTTP::Response[
            status,
            {
              "content-type" => content_type,
              "cache-control" => "no-store",
              "x-content-type-options" => "nosniff",
              "referrer-policy" => "no-referrer",
              "permissions-policy" => "microphone=(self), camera=()",
              "content-security-policy" => "default-src 'self'; connect-src 'self'; media-src 'self' blob:; " \
                "object-src 'none'; base-uri 'none'; frame-ancestors 'none'"
            },
            [body]
          ]
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  begin
    port = Integer(ENV.fetch("PORT", "4567"))
    app = OpenAI::Examples::Live::Conversation.new(
      client: OpenAI::Client.new,
      port: port,
      model: ENV.fetch("OPENAI_LIVE_MODEL", "gpt-live-1"),
      backend_model: ENV.fetch("OPENAI_LIVE_BACKEND_MODEL", "gpt-5.6-luna")
    )
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    warn("Open http://127.0.0.1:#{port} and choose Start conversation. Press Ctrl-C to stop the server.")
    Async::HTTP::Server.new(app, endpoint).run.wait
  rescue Interrupt
    warn("Local server stopped. Close any browser conversation separately.")
  rescue StandardError
    warn("Could not run the Live conversation example. Check configuration; details were not logged.")
    exit(1)
  end
end
