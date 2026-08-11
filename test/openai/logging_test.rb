# frozen_string_literal: true

require_relative "test_helper"

class LoggingTest < Minitest::Test
  extend Minitest::Serial

  class CapturingLogger
    attr_reader :events

    def initialize
      @events = []
    end

    def debug(message) = @events << [:debug, message]
    def info(message) = @events << [:info, message]
    def warn(message) = @events << [:warn, message]
    def error(message) = @events << [:error, message]
  end

  class RaisingLogger
    def debug(_message) = raise("debug logger failed")
    def info(_message) = raise("info logger failed")
    def warn(_message) = raise("warn logger failed")
    def error(_message) = raise("error logger failed")
  end

  class StubHTTPClient < OpenAI::HTTPClient
    def initialize(&execute)
      super()
      @execute = execute
    end

    def execute(request) = @execute.call(request)
  end

  class CloseableBody
    include Enumerable

    attr_reader :close_count, :each_count

    def initialize(*chunks)
      @chunks = chunks
      @close_count = 0
      @each_count = 0
    end

    def close = (@close_count += 1)

    def each
      @each_count += 1
      @chunks.each { yield(_1) }
    end
  end

  class UnbufferableChunk < String
    def byteslice(*) = raise("stream chunk was buffered")
  end

  def setup
    super
    @openai_log = ENV.delete("OPENAI_LOG")
  end

  def teardown
    @openai_log.nil? ? ENV.delete("OPENAI_LOG") : ENV["OPENAI_LOG"] = @openai_log
    super
  end

  def test_logging_is_off_by_default
    client = OpenAI::Client.new(api_key: "test-key")

    assert_equal(:off, client.log_level)
    assert_nil(client.logger)
  end

  def test_client_accepts_a_structural_logger_and_log_level
    logger = CapturingLogger.new
    client = OpenAI::Client.new(api_key: "test-key", logger: logger, log_level: "info")

    assert_same(logger, client.logger)
    assert_equal(:info, client.log_level)
  end

  def test_supplying_a_logger_does_not_enable_logging_without_a_level
    logger = CapturingLogger.new
    client = OpenAI::Client.new(api_key: "test-key", logger: logger)

    assert_same(logger, client.logger)
    assert_equal(:off, client.log_level)
  end

  def test_openai_log_enables_the_default_logger
    ENV["OPENAI_LOG"] = "debug"

    client = OpenAI::Client.new(api_key: "test-key")

    assert_instance_of(Logger, client.logger)
    assert_equal(:debug, client.log_level)
  end

  def test_explicit_log_level_wins_over_openai_log
    ENV["OPENAI_LOG"] = "debug"

    client = OpenAI::Client.new(api_key: "test-key", log_level: :off)

    assert_nil(client.logger)
    assert_equal(:off, client.log_level)
  end

  def test_standard_logger_can_apply_a_stricter_severity_filter
    output = StringIO.new
    logger = Logger.new(output)
    logger.level = Logger::WARN
    attempts = 0
    http_client = StubHTTPClient.new do |_request|
      attempts += 1
      OpenAI::HTTPClient::Response.new(
        status: attempts == 1 ? 500 : 200,
        headers: {"content-type" => "application/json"},
        body: attempts == 1 ? '{"error":"retry"}' : '{"ok":true}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      logger: logger,
      log_level: :debug
    )

    assert_equal(true, client.request(method: :get, path: "probe")[:ok])
    assert_includes(output.string, "request retry")
    refute_includes(output.string, "request started")
    refute_includes(output.string, "request complete")
  end

  def test_client_rejects_an_invalid_log_level
    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(api_key: "test-key", log_level: :verbose)
    end

    assert_equal(
      "`log_level` must be one of :off, :error, :warn, :info, or :debug",
      error.message
    )
  end

  def test_client_rejects_an_invalid_logger
    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(api_key: "test-key", logger: Object.new, log_level: :info)
    end

    assert_equal("`logger` must respond to `debug`, `info`, `warn`, and `error`", error.message)
  end

  def test_info_logs_a_safe_logical_request_summary
    logger = CapturingLogger.new
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {
          "content-type" => "application/json",
          "set-cookie" => "session=secret-cookie",
          "x-request-id" => "req_success"
        },
        body: '{"answer":"sensitive response"}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "secret-key",
      base_url: "https://example.com/v1",
      http_client: http_client,
      logger: logger,
      log_level: :info
    )

    response = client.request(
      method: :post,
      path: "probe",
      body: {prompt: "sensitive prompt"}
    )

    assert_equal("sensitive response", response[:answer])
    assert_equal([:info], logger.events.map(&:first))
    message = logger.events.fetch(0).fetch(1)
    assert_includes(message, "request complete")
    assert_includes(message, "method=POST")
    assert_includes(message, "path=/v1/probe")
    assert_includes(message, "status=200")
    assert_includes(message, "request_id=req_success")
    assert_includes(message, "attempts=1")
    assert_match(/duration_ms=\d+(?:\.\d+)?/, message)
    refute_includes(message, "secret-key")
    refute_includes(message, "secret-cookie")
    refute_includes(message, "sensitive prompt")
    refute_includes(message, "sensitive response")
  end

  def test_debug_logs_redacted_headers_and_bounded_json_bodies
    logger = CapturingLogger.new
    response_body = {
      answer: "response content",
      secret: "response-secret"
    }
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {
          "content-type" => "application/json",
          "set-cookie" => "session=secret-cookie",
          "x-request-id" => "req_debug"
        },
        body: JSON.generate(response_body)
      )
    end
    client = OpenAI::Client.new(
      api_key: "secret-key",
      base_url: "https://example.com/v1",
      http_client: http_client,
      logger: logger,
      log_level: :debug
    )

    response = client.request(
      method: :post,
      path: "probe",
      query: {api_key: "query-secret"},
      headers: {"x-api-key" => "header-secret"},
      body: {
        prompt: "request content",
        token: "body-secret",
        embedding: Array.new(200, 0.25)
      }
    )

    assert_equal("response content", response[:answer])
    debug_log = logger.events.filter_map { _2 if _1 == :debug }.join("\n")
    assert_includes(debug_log, "request started")
    assert_includes(debug_log, "response received")
    assert_includes(debug_log, "response body")
    assert_includes(debug_log, "request content")
    assert_includes(debug_log, "response content")
    assert_includes(debug_log, "[REDACTED]")
    assert_includes(debug_log, "[ARRAY OMITTED items=200]")
    refute_includes(debug_log, "secret-key")
    refute_includes(debug_log, "query-secret")
    refute_includes(debug_log, "header-secret")
    refute_includes(debug_log, "secret-cookie")
    refute_includes(debug_log, "body-secret")
    refute_includes(debug_log, "response-secret")
  end

  def test_redaction_is_case_insensitive_for_headers_and_credential_query_parameters
    headers = OpenAI::Internal::Logging.format_headers(
      "Authorization" => "authorization-secret",
      "X-Amz-Security-Token" => "aws-secret",
      "X-Client-Secret" => "client-header-secret",
      "Safe-Header" => "visible"
    )
    url = OpenAI::Internal::Logging.safe_url(
      URI(
        "https://user:password@example.com/probe?Credential=query-secret&" \
        "access_token=oauth-secret&client_secret=client-secret&" \
        "X-Amz-Signature=signature-secret&safe=visible"
      )
    )

    assert_includes(headers, "[REDACTED]")
    assert_includes(headers, "visible")
    refute_includes(headers, "authorization-secret")
    refute_includes(headers, "aws-secret")
    refute_includes(headers, "client-header-secret")
    assert_includes(url, "safe=visible")
    assert_includes(url, "%5BREDACTED%5D")
    refute_includes(url, "query-secret")
    refute_includes(url, "oauth-secret")
    refute_includes(url, "client-secret")
    refute_includes(url, "signature-secret")
    refute_includes(url, "user:password@")
    assert_equal("req_good\\nforged", OpenAI::Internal::Logging.safe_field("req_good\nforged"))
  end

  def test_debug_logging_omits_large_opaque_and_oversized_json_values
    opaque = "a" * (OpenAI::Internal::Logging::OPAQUE_STRING_BYTES + 1)
    formatted = OpenAI::Internal::Logging.format_body(
      JSON.generate(image: opaque),
      headers: {"content-type" => "application/json"}
    )
    oversized = OpenAI::Internal::Logging.format_body(
      JSON.generate(prompt: "x" * OpenAI::Internal::Logging::MAX_BODY_BYTES),
      headers: {"content-type" => "application/json"}
    )
    incomplete = OpenAI::Internal::Logging.format_observed_body(
      "partial",
      headers: {"content-type" => "text/plain"},
      complete: false,
      total_bytes: 7
    )

    assert_includes(formatted, "[OPAQUE DATA OMITTED bytes=#{opaque.bytesize}]")
    refute_includes(formatted, opaque)
    assert_includes(oversized, "[JSON BODY OMITTED]")
    assert_equal("[BODY CLOSED EARLY] bytes=7", incomplete)
  end

  def test_retry_logs_include_reason_delay_and_attempt_count
    logger = CapturingLogger.new
    attempts = 0
    http_client = StubHTTPClient.new do |_request|
      attempts += 1
      OpenAI::HTTPClient::Response.new(
        status: attempts == 1 ? 500 : 200,
        headers: {"content-type" => "application/json", "x-request-id" => "req_#{attempts}"},
        body: attempts == 1 ? '{"error":"retry"}' : '{"ok":true}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      logger: logger,
      log_level: :debug
    )

    assert_equal(true, client.request(method: :get, path: "probe")[:ok])

    starts = logger.events.filter_map { |_, message| message if message.include?("request started") }
    bodies = logger.events.filter_map { |_, message| message if message.include?("response body") }
    log_ids = logger.events.flat_map { |_, message| message.scan(/log_id=(log_[0-9a-f]+)/).flatten }.uniq
    assert_equal(2, starts.length)
    assert_equal(2, bodies.length)
    assert_equal(1, log_ids.length)
    warning = logger.events.find { |level,| level == :warn }.fetch(1)
    assert_includes(warning, "request retry")
    assert_includes(warning, "status=500")
    assert_includes(warning, "delay_seconds=0")
    completion = logger.events.find { |level,| level == :info }.fetch(1)
    assert_includes(completion, "request_id=req_2")
    assert_includes(completion, "attempts=2")
  end

  def test_terminal_errors_emit_one_safe_error_event
    logger = CapturingLogger.new
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 400,
        headers: {"content-type" => "application/json", "x-request-id" => "req_error"},
        body: '{"error":{"message":"sensitive failure"}}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      logger: logger,
      log_level: :error
    )

    assert_raises(OpenAI::Errors::BadRequestError) do
      client.request(method: :get, path: "probe")
    end

    assert_equal([:error], logger.events.map(&:first))
    message = logger.events.fetch(0).fetch(1)
    assert_includes(message, "request failed")
    assert_includes(message, "status=400")
    assert_includes(message, "request_id=req_error")
    assert_includes(message, "attempts=1")
    refute_includes(message, "sensitive failure")
  end

  def test_debug_logging_does_not_consume_or_disclose_streamed_responses
    logger = CapturingLogger.new
    source = CloseableBody.new(UnbufferableChunk.new("data: {\"message\":\"stream-secret\"}\n\n"))
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "text/event-stream", "x-request-id" => "req_stream"},
        body: source
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      logger: logger,
      log_level: :debug
    )

    events = client.request(method: :get, path: "stream")

    assert_equal(0, source.each_count)
    data = JSON.parse(events.to_a.fetch(0).fetch(:data), symbolize_names: true)
    assert_equal("stream-secret", data.fetch(:message))
    assert_equal(1, source.each_count)
    assert_equal(1, source.close_count)
    debug_log = logger.events.filter_map { _2 if _1 == :debug }.join("\n")
    assert_includes(debug_log, "[STREAM BODY OMITTED]")
    refute_includes(debug_log, "stream-secret")
  end

  def test_debug_logging_omits_multipart_file_contents
    logger = CapturingLogger.new
    http_client = StubHTTPClient.new do |request|
      request.body.to_a
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: '{"ok":true}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      logger: logger,
      log_level: :debug
    )
    file = OpenAI::FilePart.new(StringIO.new("file-secret"), filename: "payload.txt")

    assert_equal(
      true,
      client.request(
        method: :post,
        path: "upload",
        headers: {"content-type" => "multipart/form-data"},
        body: {file: file}
      )[:ok]
    )

    debug_log = logger.events.filter_map { _2 if _1 == :debug }.join("\n")
    assert_includes(debug_log, "[MULTIPART BODY OMITTED]")
    refute_includes(debug_log, "file-secret")
  end

  def test_debug_logging_omits_binary_response_contents_without_changing_the_result
    logger = CapturingLogger.new
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/octet-stream"},
        body: "binary-secret"
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      logger: logger,
      log_level: :debug
    )

    response = client.request(method: :get, path: "binary")

    assert_equal("binary-secret", response.read)
    debug_log = logger.events.filter_map { _2 if _1 == :debug }.join("\n")
    assert_includes(debug_log, "[BINARY BODY OMITTED]")
    refute_includes(debug_log, "binary-secret")
  end

  def test_debug_logging_omits_binary_request_contents_without_changing_the_request
    logger = CapturingLogger.new
    sent_body = nil
    http_client = StubHTTPClient.new do |request|
      sent_body = request.body
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: '{"ok":true}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      logger: logger,
      log_level: :debug
    )

    assert_equal(
      true,
      client.request(
        method: :post,
        path: "binary",
        headers: {"content-type" => "application/octet-stream"},
        body: "binary-request-secret"
      )[:ok]
    )

    assert_equal("binary-request-secret", sent_body)
    debug_log = logger.events.filter_map { _2 if _1 == :debug }.join("\n")
    assert_includes(debug_log, "[BINARY BODY OMITTED]")
    refute_includes(debug_log, "binary-request-secret")
  end

  def test_raw_responses_use_the_same_logging_pipeline
    logger = CapturingLogger.new
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json", "x-request-id" => "req_raw"},
        body: '{"ok":true}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      logger: logger,
      log_level: :debug
    )

    response = client.raw_request(method: :get, path: "probe")

    assert_equal('{"ok":true}', response.read)
    assert_equal({ok: true}, response.parse)
    completions = logger.events.count do |level, message|
      level == :info && message.include?("request complete")
    end
    bodies = logger.events.count { |level, message| level == :debug && message.include?("response body") }
    assert_equal(1, completions)
    assert_equal(1, bodies)
    assert_includes(logger.events.map(&:last).join("\n"), "request_id=req_raw")
  end

  def test_logger_failures_do_not_replace_api_results_or_errors
    successful_http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: '{"ok":true}'
      )
    end
    successful_client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: successful_http_client,
      logger: RaisingLogger.new,
      log_level: :debug
    )

    assert_equal(true, successful_client.request(method: :get, path: "probe")[:ok])

    failing_http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 400,
        headers: {"content-type" => "application/json"},
        body: '{"error":{"message":"bad request"}}'
      )
    end
    failing_client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: failing_http_client,
      logger: RaisingLogger.new,
      log_level: :debug
    )

    assert_raises(OpenAI::Errors::BadRequestError) do
      failing_client.request(method: :get, path: "probe")
    end
  end

  def test_log_formatting_failures_do_not_replace_api_results
    logger = CapturingLogger.new
    invalid_utf8 = "\xFF".b
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json", "x-invalid" => invalid_utf8},
        body: '{"ok":true}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      logger: logger,
      log_level: :debug
    )

    assert_equal(true, client.request(method: :get, path: "probe")[:ok])
  end
end
