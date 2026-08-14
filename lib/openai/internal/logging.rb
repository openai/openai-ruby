# frozen_string_literal: true

module OpenAI
  module Internal
    # Request logging helpers shared by generated clients.
    #
    # @api private
    module Logging
      LOG_LEVELS = {off: 0, error: 1, warn: 2, info: 3, debug: 4}.freeze
      REDACTED_HEADERS = %w[
        api-key
        authorization
        cookie
        proxy-authorization
        set-cookie
        x-amz-security-token
        x-api-key
      ].freeze
      MAX_BODY_BYTES = 16 * 1024
      MAX_ARRAY_ITEMS = 100
      OPAQUE_STRING_BYTES = 1_024
      SENSITIVE_BODY_KEY = /(?:api[-_]?key|authorization|credential|password|secret|signature|token)/i
      SENSITIVE_QUERY_KEY = /
        (?:
          (?:\A|[-_\[])(?:key|sig)
          | (?-i:K)ey
          | api[-_]?key
          | authorization
          | credentials?
          | password
          | secret
          | signature
          | token
        )
        (?:\[|\]|\z)
      /ix
      URL_HEADER_KEY = /(?:\A|[-_])(?:location|url|uri)\z|\A(?:link|refresh)\z/i

      class Context
        def initialize(logger:, log_level:, on_retry:, method:, url:)
          @logger = logger
          @log_level = log_level
          @on_retry = on_retry
          @id = nil
          @method = method.to_s.upcase
          @url = url
          @started_at = OpenAI::Internal::Util.monotonic_secs
          @attempt_started_at = @started_at
          @attempts = 0
        end

        def request_started(request, redirect_count:)
          @attempts += 1
          log(:debug) do
            "[openai] request started log_id=#{id} attempt=#{@attempts} " \
              "redirect=#{redirect_count} method=#{request.method.to_s.upcase} " \
              "url=#{OpenAI::Internal::Logging.safe_url(request.url)} " \
              "headers=#{OpenAI::Internal::Logging.format_headers(request.headers)} " \
              "body=#{OpenAI::Internal::Logging.format_body(request.body, headers: request.headers)}"
          end
          @attempt_started_at = OpenAI::Internal::Util.monotonic_secs
        end

        def response_received(response)
          log(:debug) do
            "[openai] response received log_id=#{id} attempt=#{@attempts} " \
              "status=#{response.status} request_id=#{safe_field(response.headers['x-request-id'])} " \
              "duration_ms=#{attempt_duration_ms} " \
              "headers=#{OpenAI::Internal::Logging.format_headers(response.headers)}"
          end
          return response unless enabled?(:debug)

          observed = ObservedBody.new(
            body: response.body,
            headers: response.headers,
            context: self,
            attempt: @attempts
          )
          OpenAI::HTTPClient::Response.new(
            status: response.status,
            headers: response.headers,
            body: observed
          )
        end

        def attempt_failed(error)
          log(:debug) do
            "[openai] request attempt failed log_id=#{id} attempt=#{@attempts} " \
              "error=#{error.class} duration_ms=#{attempt_duration_ms}"
          end
        end

        def retry_scheduled(cause, delay:, response:, retry_count:, max_retries:)
          reason = cause.is_a?(Integer) ? "status=#{cause}" : "error=#{cause.class}"
          log(:warn) do
            "[openai] request retry log_id=#{id} attempt=#{@attempts} " \
              "#{reason} delay_seconds=#{delay}"
          end

          event = OpenAI::RetryEvent.new(
            attempt: retry_count + 2,
            max_attempts: max_retries + 1,
            delay: delay,
            response: response,
            error: cause.is_a?(OpenAI::Errors::APIConnectionError) ? cause : nil
          )
          @on_retry&.call(event)
        rescue StandardError
          nil
        end

        def completed(response)
          log(:info) do
            "[openai] request complete log_id=#{id} method=#{@method} " \
              "path=#{OpenAI::Internal::Logging.safe_path(@url)} " \
              "status=#{response.status} request_id=#{safe_field(response.headers['x-request-id'])} " \
              "attempts=#{@attempts} duration_ms=#{duration_ms}"
          end
        end

        def observe_stream(stream, response:)
          return stream unless enabled?(:error)

          stream.observe(context: self, response: response)
        end

        def request_failed(error)
          status = error.is_a?(OpenAI::Errors::APIError) ? error.status : nil
          request_id = error.is_a?(OpenAI::Errors::APIError) ? error.request_id : nil
          log(:error) do
            "[openai] request failed log_id=#{id} method=#{@method} " \
              "path=#{OpenAI::Internal::Logging.safe_path(@url)} " \
              "status=#{status || 'none'} request_id=#{safe_field(request_id)} " \
              "error=#{error.class} attempts=#{@attempts} duration_ms=#{duration_ms}"
          end
        end

        def response_body(body, headers:, complete:, total_bytes:, attempt:)
          log(:debug) do
            formatted = OpenAI::Internal::Logging.format_observed_body(
              body,
              headers: headers,
              complete: complete,
              total_bytes: total_bytes
            )
            "[openai] response body log_id=#{id} " \
              "attempt=#{attempt} duration_ms=#{duration_ms} body=#{formatted}"
          end
        end

        private def duration_ms
          ((OpenAI::Internal::Util.monotonic_secs - @started_at) * 1_000).round(2)
        end

        private def id = @id ||= "log_#{SecureRandom.hex(6)}"

        private def attempt_duration_ms
          ((OpenAI::Internal::Util.monotonic_secs - @attempt_started_at) * 1_000).round(2)
        end

        private def enabled?(event_level)
          !@logger.nil? && OpenAI::Internal::Logging.enabled?(@log_level, event_level)
        end

        private def safe_field(value) = OpenAI::Internal::Logging.safe_field(value)

        private def log(event_level)
          return unless enabled?(event_level)

          message = yield
          case event_level
          in :debug
            @logger.debug(message)
          in :info
            @logger.info(message)
          in :warn
            @logger.warn(message)
          in :error
            @logger.error(message)
          end
        rescue StandardError
          nil
        end
      end

      class ObservedBody
        include Enumerable

        def initialize(body:, headers:, context:, attempt:)
          @body = body
          @headers = headers
          @context = context
          @attempt = attempt
          @captured = String.new(encoding: Encoding::BINARY)
          @capture_body = OpenAI::Internal::Logging.capture_response_body?(headers)
          @bytes = 0
          @complete = false
          @closed = false
        end

        def each
          return enum_for unless block_given?
          return if @closed

          begin
            @body.each do |chunk|
              capture(chunk)
              yield(chunk)
            end
            @complete = true
          ensure
            close
          end
        end

        def close
          return if @closed

          @closed = true
          OpenAI::Internal::Util.close_fused!(@body)
          @context.response_body(
            @captured,
            headers: @headers,
            complete: @complete,
            total_bytes: @bytes,
            attempt: @attempt
          )
        end

        private def capture(chunk)
          @bytes += chunk.bytesize
          return unless @capture_body

          remaining = OpenAI::Internal::Logging::MAX_BODY_BYTES - @captured.bytesize
          @captured << chunk.byteslice(0, remaining) if remaining.positive?
        end
      end

      class << self
        def normalize_level(value)
          level = value.to_s.downcase.to_sym if value.is_a?(String) || value.is_a?(Symbol)
          return level if LOG_LEVELS.key?(level)

          raise ArgumentError, "`log_level` must be one of :off, :error, :warn, :info, or :debug"
        end

        def validate_logger!(logger)
          return if logger.nil?

          methods = [:debug, :info, :warn, :error]
          return if methods.all? { logger.respond_to?(_1) }

          raise ArgumentError, "`logger` must respond to `debug`, `info`, `warn`, and `error`"
        end

        def default_logger = ::Logger.new($stderr)

        def enabled?(configured_level, event_level)
          LOG_LEVELS.fetch(configured_level) >= LOG_LEVELS.fetch(event_level)
        end

        def safe_path(url)
          uri = sanitized_uri(url)
          path = uri.path.to_s.empty? ? "/" : uri.path
          uri.query.nil? ? path : "#{path}?#{uri.query}"
        rescue ArgumentError, URI::Error
          "[URL OMITTED]"
        end

        def safe_url(url)
          sanitized_uri(url).to_s
        rescue ArgumentError, URI::Error
          "[URL OMITTED]"
        end

        def safe_field(value)
          return "none" if value.nil?

          value.to_s.dump.delete_prefix('"').delete_suffix('"')
        end

        # @api private
        def sensitive_header?(name)
          normalized_name = name.to_s.downcase
          REDACTED_HEADERS.include?(normalized_name) || SENSITIVE_QUERY_KEY.match?(normalized_name)
        end

        # @api private
        def credential_header?(name)
          normalized_name = name.to_s.downcase
          idempotency = normalized_name.match(/(?:\A|[-_])idempotency[-_]key\z/)
          return sensitive_header?(normalized_name) unless idempotency

          prefix = normalized_name[...idempotency.begin(0)]
          prefix.split(/[-_]/).any? { sensitive_header?(_1) }
        end

        def format_headers(headers)
          redacted =
            headers.sort.to_h do |name, value|
              normalized_name = name.to_s.downcase
              rendered =
                if sensitive_header?(normalized_name)
                  "[REDACTED]"
                elsif URL_HEADER_KEY.match?(normalized_name)
                  sanitized_url_value(value)
                else
                  value
                end
              [name, rendered]
            end
          JSON.generate(redacted)
        end

        def format_body(body, headers:)
          content_type = headers["content-type"].to_s
          return "[NO BODY]" if body.nil?
          return "[MULTIPART BODY OMITTED]" if content_type.match?(%r{\Amultipart/}i)
          return "[STREAMING BODY OMITTED]" unless body.is_a?(String)
          return "[BINARY BODY OMITTED] bytes=#{body.bytesize}" unless textual_content_type?(content_type)

          format_text_body(body, content_type: content_type, total_bytes: body.bytesize)
        end

        def capture_response_body?(headers)
          content_type = headers["content-type"].to_s
          textual_content_type?(content_type) && !content_type.match?(%r{\Atext/event-stream}i)
        end

        def format_observed_body(body, headers:, complete:, total_bytes:)
          content_type = headers["content-type"].to_s
          return "[STREAM BODY OMITTED] bytes=#{total_bytes}" if content_type.match?(%r{\Atext/event-stream}i)
          return "[BODY CLOSED EARLY] bytes=#{total_bytes}" unless complete
          unless textual_content_type?(content_type)
            return "[BINARY BODY OMITTED] bytes=#{total_bytes}"
          end
          if total_bytes > MAX_BODY_BYTES && json_content_type?(content_type)
            return "[JSON BODY OMITTED] bytes=#{total_bytes} reason=too_large"
          end

          format_text_body(body, content_type: content_type, total_bytes: total_bytes)
        end

        private def sanitized_uri(url)
          uri = url.dup
          uri.user = nil
          uri.password = nil
          return uri if uri.query.nil?

          uri.query = sanitized_query(uri.query)
          uri
        end

        private def sanitized_query(query)
          pairs = URI.decode_www_form(query).map do |name, value|
            [name, SENSITIVE_QUERY_KEY.match?(name) ? "[REDACTED]" : scrub_embedded_url(value)]
          end
          URI.encode_www_form(pairs)
        rescue ArgumentError
          nil
        end

        private def sanitized_url_value(value)
          safe_url(URI(value.to_s))
        rescue URI::InvalidURIError
          "[URL OMITTED]"
        end

        private def scrub_embedded_url(value)
          value.match?(%r{\Ahttps?://}i) ? sanitized_url_value(value) : value
        end

        private def textual_content_type?(content_type)
          content_type.empty? ||
            content_type.match?(%r{\Atext/}i) ||
            content_type.match?(/(?:json|xml|x-www-form-urlencoded)/i)
        end

        private def json_content_type?(content_type) = content_type.match?(%r{(?:\A|[+/])json(?:;|\z)}i)

        private def format_text_body(body, content_type:, total_bytes:)
          if json_content_type?(content_type)
            return "[JSON BODY OMITTED] bytes=#{total_bytes} reason=too_large" if total_bytes > MAX_BODY_BYTES

            parsed = JSON.parse(body)
            return JSON.generate(scrub_value(parsed))
          end

          unless content_type.match?(%r{\Aapplication/x-www-form-urlencoded(?:;|\z)}i)
            return "[TEXT BODY OMITTED] bytes=#{total_bytes}"
          end
          return "[FORM BODY OMITTED] bytes=#{total_bytes} reason=too_large" if total_bytes > MAX_BODY_BYTES

          sanitized = sanitized_query(body)
          sanitized.nil? ? "[INVALID FORM BODY OMITTED] bytes=#{total_bytes}" : sanitized.inspect
        rescue JSON::ParserError
          "[INVALID JSON BODY OMITTED] bytes=#{total_bytes}"
        end

        private def scrub_value(value, key: nil)
          return "[REDACTED]" if key && SENSITIVE_BODY_KEY.match?(key.to_s)

          case value
          in Hash
            value.to_h { |name, nested| [name, scrub_value(nested, key: name)] }
          in Array if value.length > MAX_ARRAY_ITEMS
            "[ARRAY OMITTED items=#{value.length}]"
          in Array
            value.map { scrub_value(_1) }
          in String if opaque_string?(value)
            "[OPAQUE DATA OMITTED bytes=#{value.bytesize}]"
          in String
            scrub_embedded_url(value)
          else
            value
          end
        end

        private def opaque_string?(value)
          return false if value.bytesize < OPAQUE_STRING_BYTES

          encoded = value.sub(/\Adata:[^,]*;base64,/i, "")
          encoded.match?(%r{\A[A-Za-z0-9+/_=\s-]+\z}) ||
            encoded.match?(/\A[A-Za-z0-9_-]+(?:\.[A-Za-z0-9_-]+){1,4}\z/)
        end
      end
    end
  end
end
