#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "json"
require "timeout"
require "uri"

require_relative "../../../lib/openai"
require_relative "../sideband"

module OpenAI::Examples::Realtime
  # Single-operator, loopback-only application. This is not SDK runtime code.
  class BrowserApp
    class Rejected < StandardError
      attr_reader :status
      def initialize(status)
        @status = status
        super("Request rejected")
      end
    end

    ASSETS = {
      "/" => ["index.html", "text/html"],
      "/direct" => ["index.html", "text/html"],
      "/backend" => ["index.html", "text/html"],
      "/peer.js" => ["peer.js", "text/javascript"],
      "/page.js" => ["page.js", "text/javascript"]
    }.freeze

    def initialize(
      client:,
      token:,
      port: 9292,
      model: "gpt-realtime-2.1",
      sideband: false,
      manual_turns: false,
      clock: -> { Process.clock_gettime(Process::CLOCK_MONOTONIC) },
      output: $stderr
    )
      raise ArgumentError, "Use an application token of at least 32 characters" if token.bytesize < 32
      @client, @token, @model, @sideband = client, token, model, sideband
      @manual_turns = manual_turns
      @origin = URI::HTTP.build(host: "127.0.0.1", port: port).to_s
      @authority = @origin.delete_prefix("http://")
      @clock, @output = clock, output
      @mutex = Mutex.new
      @call = nil
      @cancelled = {}
      @next_create = 0
      @closing = false
    end

    def service(request, response)
      response["Cache-Control"] = "no-store"
      response["Referrer-Policy"] = "no-referrer"
      response["X-Content-Type-Options"] = "nosniff"
      response["Cross-Origin-Resource-Policy"] = "same-origin"
      response["Permissions-Policy"] = "microphone=(self), camera=()"
      response["Content-Security-Policy"] = "default-src 'none'; script-src 'self'; connect-src 'self' https://api.openai.com; media-src 'self' blob:; base-uri 'none'; frame-ancestors 'none'; form-action 'none'"
      raise Rejected.new(403) unless request["host"] == @authority

      if request.request_method == "GET" && ASSETS.key?(request.path)
        file, content_type = ASSETS.fetch(request.path)
        response["Content-Type"] = content_type
        response.body = File.read(File.join(__dir__, file))
        return
      end

      authenticate!(request)
      @mutex.synchronize do
        raise Rejected.new(503) if @closing
        dispatch(request, response)
      end

    rescue Rejected => e
      response.status = e.status
      response.body = "Request rejected."
    rescue StandardError
      response.status = 502
      response.body = "Signaling failed."
      @output.puts("[browser] signaling failed")
    end

    # Called by the server timer even when the browser disappears without Stop.
    def reap
      @mutex.synchronize { cleanup if @call && @clock.call >= @call.fetch(:deadline) }
    end

    def shutdown
      @mutex.synchronize do
        @closing = true
        cleanup if @call
      end
    end

    private

    def authenticate!(request)
      raise Rejected.new(405) unless request.request_method == "POST"
      raise Rejected.new(403) unless request["origin"] == @origin
      expected = Digest::SHA256.digest("Bearer #{@token}")
      supplied = Digest::SHA256.digest(request["authorization"].to_s)
      difference = expected.bytes.zip(supplied.bytes).reduce(0) { |memo, (a, b)| memo | (a ^ b) }
      raise Rejected.new(401) unless difference.zero?
    end

    def dispatch(request, response)
      response["Content-Type"] = "application/json"
      case request.path
      when "/api/secret"
        rate_limit!
        secret = @client.realtime.client_secrets.create(
          expires_after: {anchor: :created_at, seconds: 30},
          session: session,
          request_options: creation_options
        )
        # No call exists on this backend. Failed delivery leaves a secret which
        # expires; there is no public secret revocation endpoint to invent here.
        response.body = JSON.generate({value: secret.value})
      when "/api/calls"
        raise Rejected.new(415) unless request["content-type"] == "application/sdp"
        id = operation_id(request)
        raise Rejected.new(409) if @call || @cancelled.include?(id)
        rate_limit!
        create_call(id, request.body.to_s, response)
      when "/api/ack", "/api/renew"
        owned_call!(request)
        raise Rejected.new(409) if @call[:ending] || @clock.call >= @call[:deadline]
        raise Rejected.new(409) if request.path == "/api/renew" && !@call[:acknowledged]
        @call[:acknowledged] = true
        @call[:deadline] = @clock.call + 60
        response.body = "{}"
      when "/api/stop"
        # Only application operation IDs are accepted, never browser call IDs.
        id = operation_id(request)
        # A Stop can overtake its create on another HTTP connection. Retain the
        # cancellation for this process lifetime; never allocate that ID later.
        @cancelled[id] = true
        if @call && @call[:id] == id
          cleanup
          raise Rejected.new(503) if @call
        end

        response.body = "{}"
      else
        raise Rejected.new(404)
      end
    end

    def session
      config = {type: :realtime, model: @model, instructions: "Keep answers short.", max_output_tokens: 128, tools: []}
      config[:audio] = {input: {turn_detection: nil}} if @manual_turns
      config
    end

    def creation_options
      {
        timeout: 15,
        max_retries: 0,
        extra_headers: {"OpenAI-Safety-Identifier" => Digest::SHA256.hexdigest(@token)}
      }
    end

    def rate_limit!
      raise Rejected.new(429) if @clock.call < @next_create
      @next_create = @clock.call + 5
    end

    def operation_id(request)
      id = request["x-operation-id"].to_s
      raise Rejected.new(400) unless /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/.match?(id)
      id
    end

    def owned_call!(request)
      raise Rejected.new(404) unless @call && @call[:id] == operation_id(request)
    end

    def create_call(id, offer, response)
      # Shipped SDK owns allocation/response buffering until this returns. Do not
      # duplicate its interrupted-creation cleanup or retry uncertain creates.
      result = @client.realtime.calls.create(sdp: offer, session: session, request_options: creation_options)
      call_id = call_id_from_location(result.headers["location"])
      raise "Creation returned no usable call identifier" unless call_id
      @call = {id: id, call_id: call_id, deadline: @clock.call + 20}
      begin
        answer = result.body.to_a.join
        if @sideband
          Timeout.timeout(15) do
            Sideband.run(client: @client, call_id: call_id, instructions: "Keep answers short.", output: @output)
          end
        end

        payload = JSON.generate({sdp: answer})
        @call[:deadline] = @clock.call + 20
        response.chunked = true
        response.body = proc do |socket|
          begin
            socket.write(payload)
          rescue StandardError
            @mutex.synchronize { cleanup if @call && @call[:id] == id }
            raise
          end
        end
      rescue StandardError
        cleanup
        raise
      end
    end

    def call_id_from_location(location)
      return unless location.is_a?(String)
      url = URI.join("https://api.openai.com/v1/realtime/calls", location)
      return unless url.scheme == "https" && url.host == "api.openai.com" && url.port == 443
      return if url.userinfo || url.query || url.fragment
      %r{\A/v1/realtime/calls/([A-Za-z0-9_-]+)\z}.match(url.path)&.captures&.first
    rescue URI::InvalidURIError
      nil
    end

    def cleanup
      @call[:ending] = true
      Timeout.timeout(5) do
        @client.realtime.calls.hangup(@call.fetch(:call_id), request_options: {timeout: 5, max_retries: 0})
      end

      @call = nil
      @output.puts("[browser] call released")
    rescue OpenAI::Errors::NotFoundError
      @call = nil
      @output.puts("[browser] call released")
    rescue StandardError
      @call[:deadline] = @clock.call + 5
      @output.puts("[browser] hangup failed; retry pending")
    end
  end
end

if $PROGRAM_NAME == __FILE__
  require "webrick"

  port = Integer(ENV.fetch("PORT", "9292"))
  app = OpenAI::Examples::Realtime::BrowserApp.new(
    client: OpenAI::Client.new(
      api_key: ENV.fetch("OPENAI_API_KEY"),
      base_url: "https://api.openai.com/v1",
      max_retries: 0
    ),
    token: ENV.fetch("BROWSER_APP_TOKEN"),
    port: port,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
    sideband: ENV["BROWSER_SIDEBAND"] == "1",
    manual_turns: ENV["BROWSER_MANUAL_TURNS"] == "1"
  )
  # Suppress HTTP logs: they can contain bearer credentials, SDP, or paths.
  server = WEBrick::HTTPServer.new(
    BindAddress: "127.0.0.1",
    Port: port,
    AccessLog: [],
    Logger: WEBrick::Log.new(File::NULL),
    RequestTimeout: 20
  )
  server.mount_proc("/") { |request, response| app.service(request, response) }
  %w[INT TERM].each { |signal| Signal.trap(signal) { server.shutdown } }
  sweeper = Thread.new do
    loop do
      sleep(1)
      app.reap
    end
  end

  begin
    warn("[browser] ready http://127.0.0.1:#{port}/direct and /backend")
    server.start
  ensure
    sweeper.kill
    sweeper.join
    app.shutdown
  end
end
