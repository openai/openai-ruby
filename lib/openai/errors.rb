# frozen_string_literal: true

module OpenAI
  module Errors
    class Error < StandardError
      # @!attribute cause
      #
      #   @return [StandardError, nil]
    end

    class InvalidWebhookSignatureError < OpenAI::Errors::Error
    end

    # Raised when a polling helper cannot continue safely.
    class PollingError < OpenAI::Errors::Error
    end

    # Raised when a polling helper exceeds its overall timeout.
    class PollingTimeoutError < OpenAI::Errors::PollingError
      # The last resource returned by the API before the timeout, or `nil` when
      # the deadline elapsed before the first response.
      #
      # @return [Object, nil]
      attr_reader :resource

      # The configured overall polling timeout in seconds.
      #
      # @return [Float]
      attr_reader :timeout

      # A human-readable description of the operation being polled.
      #
      # @return [String]
      attr_reader :operation

      # @api private
      #
      # @param operation [String]
      # @param timeout [Float]
      # @param resource [Object, nil]
      def initialize(operation:, timeout:, resource:)
        @operation = operation
        @timeout = timeout
        @resource = resource
        super("Timed out waiting for #{operation} after #{timeout} seconds.")
      end
    end

    class ConversionError < OpenAI::Errors::Error
      # @return [StandardError, nil]
      def cause = @cause.nil? ? super : @cause

      # @api private
      #
      # @param on [Class<StandardError>]
      # @param method [Symbol]
      # @param target [Object]
      # @param value [Object]
      # @param cause [StandardError, nil]
      def initialize(on:, method:, target:, value:, cause: nil)
        cls = on.name.split("::").last

        message = [
          "Failed to parse #{cls}.#{method} from #{value.class} to #{target.inspect}.",
          "To get the unparsed API response, use #{cls}[#{method.inspect}].",
          cause && "Cause: #{cause.message}"
        ].filter(&:itself).join(" ")

        @cause = cause
        super(message)
      end
    end

    class APIError < OpenAI::Errors::Error
      # @return [URI::Generic]
      attr_accessor :url

      # @return [Integer, nil]
      attr_accessor :status

      # @return [Hash{String=>String}, nil]
      attr_accessor :headers

      # @return [Object, nil]
      attr_accessor :body

      # @return [String, nil]
      attr_accessor :code

      # @return [String, nil]
      attr_accessor :param

      # @return [String, nil]
      attr_accessor :type

      # The ID of the API request, returned via the `x-request-id` response
      # header. This is nil when no HTTP response was received or the response
      # did not include the header.
      #
      # @return [String, nil]
      def request_id = headers&.[]("x-request-id")

      # @api private
      #
      # @param url [URI::Generic]
      # @param status [Integer, nil]
      # @param headers [Hash{String=>String}, nil]
      # @param body [Object, nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(url:, status: nil, headers: nil, body: nil, request: nil, response: nil, message: nil)
        @url = url
        @status = status
        @headers = headers
        @body = body
        @request = request
        @response = response
        super(message)
      end
    end

    class APIConnectionError < OpenAI::Errors::APIError
      # @!attribute status
      #
      #   @return [nil]

      # @!attribute body
      #
      #   @return [nil]

      # @!attribute code
      #
      #   @return [nil]

      # @!attribute param
      #
      #   @return [nil]

      # @!attribute type
      #
      #   @return [nil]

      # @api private
      #
      # @param url [URI::Generic]
      # @param status [nil]
      # @param headers [Hash{String=>String}, nil]
      # @param body [nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(
        url:,
        status: nil,
        headers: nil,
        body: nil,
        request: nil,
        response: nil,
        message: "Connection error."
      )
        super
      end
    end

    class APITimeoutError < OpenAI::Errors::APIConnectionError
      # @api private
      #
      # @param url [URI::Generic]
      # @param status [nil]
      # @param headers [Hash{String=>String}, nil]
      # @param body [nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(
        url:,
        status: nil,
        headers: nil,
        body: nil,
        request: nil,
        response: nil,
        message: "Request timed out."
      )
        super
      end
    end

    class APIStatusError < OpenAI::Errors::APIError
      # @api private
      #
      # @param url [URI::Generic]
      # @param status [Integer]
      # @param headers [Hash{String=>String}, nil]
      # @param body [Object, nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      #
      # @return [self]
      def self.for(url:, status:, headers:, body:, request:, response:, message: nil)
        kwargs = {
          url: url,
          status: status,
          headers: headers,
          body: body,
          request: request,
          response: response,
          message: message
        }

        case status
        in 400
          OpenAI::Errors::BadRequestError.new(**kwargs)
        in 401
          OpenAI::Errors::AuthenticationError.new(**kwargs)
        in 403
          OpenAI::Errors::PermissionDeniedError.new(**kwargs)
        in 404
          OpenAI::Errors::NotFoundError.new(**kwargs)
        in 409
          OpenAI::Errors::ConflictError.new(**kwargs)
        in 422
          OpenAI::Errors::UnprocessableEntityError.new(**kwargs)
        in 429
          OpenAI::Errors::RateLimitError.new(**kwargs)
        in (500..)
          OpenAI::Errors::InternalServerError.new(**kwargs)
        else
          OpenAI::Errors::APIStatusError.new(**kwargs)
        end
      end

      # @!parse
      #   # @return [Integer]
      #   attr_accessor :status

      # @!parse
      #   # @return [String, nil]
      #   attr_accessor :code

      # @!parse
      #   # @return [String, nil]
      #   attr_accessor :param

      # @!parse
      #   # @return [String, nil]
      #   attr_accessor :type

      # @api private
      #
      # @param url [URI::Generic]
      # @param status [Integer]
      # @param headers [Hash{String=>String}, nil]
      # @param body [Object, nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(url:, status:, headers:, body:, request:, response:, message: nil)
        message ||= case OpenAI::Internal::Util.dig(body, :message)
        in String | Symbol | Numeric | true | false => upstream_message
          upstream_message
        else
          safe_status_message(url: url, status: status, headers: headers, body: body)
        end

        @code = OpenAI::Internal::Type::Converter.coerce(String, OpenAI::Internal::Util.dig(body, :code))
        @param = OpenAI::Internal::Type::Converter.coerce(String, OpenAI::Internal::Util.dig(body, :param))
        @type = OpenAI::Internal::Type::Converter.coerce(String, OpenAI::Internal::Util.dig(body, :type))
        super(
          url: url,
          status: status,
          headers: headers,
          body: body,
          request: request,
          response: response,
          message: message&.to_s
        )
      end

      private def safe_status_message(url:, status:, headers:, body:)
        sensitive_description = %r{
          https?:// |
          \bdata:[^,]{0,512}, |
          \b(?:bearer|basic)\s+(?!tokens?\b|credentials?\b|authentication\b)\S |
          \b(?:(?:access|refresh|id|session)\s+)?(?:tokens?|credentials?)\s+
              (?!is\b|was\b|invalid\b|expired\b|missing\b|required\b)[a-z0-9._-]{8,} |
          \b[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\b |
          \beyJ[a-z0-9_-]+\.[a-z0-9_-]+\.[a-z0-9_-]+ |
          \b(?:AKIA|ASIA)[a-z0-9]{16}\b |
          \b(?:sk|rk|ek)(?:[-_][a-z0-9]{16,}|(?:[-_][a-z0-9]+){2,}) |
          \b(?:invalid|expired|missing|required|malformed|unsupported|incorrect|unknown|
              revoked|disabled|empty|too\s+(?:long|short|large|small))\b
              (?:
                [\s\S]{0,512}\b(?:private|customer\s+(?:prompt|input|response|output|content|data)|
                    model\s+(?:response|output))\b |
                \s*[\r\n\(\[\{<"';,/—–-]+\s*
                    (?!expected\b|(?:a|an)\s+(?:string|integer|number|boolean|object|array)\b|
                        maximum\b|max\b|minimum\b|min\b|limit\b|check\b|please\b|add\b|
                        retry\b|refresh\b|sign\b)\S
              ) |
          \b(?:[a-z0-9]+[-_])*
              (?:api[-_\s]?key|access[-_\s]?token|client[-_\s]?secret|authorization|awsaccesskeyid|
                  (?:customer|user)[-_\s]?(?:id|identifier)|email|
                  (?:set[-_\s]?)?cookie|credentials?|assertions?|tokens?|keys?|signature|secret|password|
                  prompt|input|responses?|outputs?|messages?|content)
              (?:[-_][a-z0-9]+|\[[a-z0-9_-]*\])*
              (?:["']?\s*[:=]\s*|\s+(?:is|was)\s+|\s+["'“‘]\s*)
              (?!
                (?:invalid|valid|expired|missing|required|malformed|truncated|unsupported|incorrect|unknown|
                    revoked|disabled|empty|too\s+(?:long|short|large|small)|string|integer|
                    number|boolean|object|array|null|\d+(?:\s+tokens?)?)\b
                    (?!\s*[:=]\s*(?!expected\b|string\b|integer\b|number\b|boolean\b)\S)
              )
              \S
        }ix
        credential_description = %r{
          \b(?:api[-_\s]?keys?|(?:access|refresh|id|session)[-_\s]?tokens?|tokens?|
              client[-_\s]?secrets?|private[-_\s]?keys?|secrets?|credentials?|
              passwords?|authorization|(?:set[-_\s]?)?cookies?|assertions?|signatures?)\b
        }ix
        content_description = /\b(?:prompt|input|responses?|outputs?|messages?|content|customer|data)\b/i
        safe_description = %r{
          \A(?:
            [\s'"“”‘’().,:;!?-]+ | \d+ |
            \b(?:invalid_(?:request|client|grant|scope|token|subject_token|prompt|
                    image(?:_format|_url|_mode)?|base64_image)|
                unauthorized_client|unsupported_(?:grant_type|response_type|image_media_type)|
                access_denied|insufficient_scope|server_error|temporarily_unavailable|
                rate_limit_exceeded|data_residency_mismatch|bio_policy|vector_store_timeout|
                image_(?:too_(?:large|small)|parse_error|content_policy_violation|
                    file_(?:too_large|not_found))|empty_image_file|failed_to_download_image)\b |
            \b(?:a|an|the|this|your|for|of|to|from|in|on|with|by|and|or|has|have|is|was|were|
                be|not|no|does|do|could|cannot|must|should|when|it|invalid|expired|missing|
                required|malformed|unsupported|incorrect|unknown|revoked|disabled|empty|blank|
                unavailable|too|long|short|large|small|api|key|keys|access|refresh|id|session|
                bearer|basic|client|secret|secrets|token|tokens|credentials|authentication|
                authorization|signature|password|assertion|please|sign|again|add|one|account|
                settings|check|format|operation|configured|configuration|failed|rejected|
                denied|provided|permissions|expected|string|integer|number|boolean|object|
                array|null|maximum|max|minimum|min|limit|length|request|requested|provider|
                input|response|output|message|content|data|url|selected|model|processed|role|
                user|value|field|header|exist|match|exceeds|exceed|exceeded|context|contains|
                contain|many|parsed|as|json|truncated|because|valid|but|permission|resource|
                scopes|scope|nested|oauth|error|explanation|top|level|failure|forged|log|entry|
                rate|reached|try|later|you|current|quota|plan|billing|details|found|internal|
                server|service|temporarily|http|status)\b
          )+\z
        }ix
        upstream_message = [
          OpenAI::Internal::Util.dig(body, [:error, :message]),
          OpenAI::Internal::Util.dig(body, [:error, :error_description]),
          OpenAI::Internal::Util.dig(body, :error_description),
          OpenAI::Internal::Util.dig(body, :error)
        ].find do |candidate|
          next false unless candidate.is_a?(String)

          classified_candidate = candidate[...512].encode(Encoding::UTF_8, invalid: :replace, undef: :replace)
          next false if classified_candidate.strip.empty? || classified_candidate.match?(sensitive_description)
          next false unless classified_candidate.match?(safe_description)

          classified_markers = classified_candidate.gsub(/(?<=[a-z0-9])(?=[A-Z])/, " ").tr("_-", "  ")
          credential = classified_markers.match?(credential_description)
          content = classified_markers.match?(content_description)
          if classified_candidate.match?(/\d/)
            diagnostic_words = classified_candidate.downcase.scan(/[a-z]+|\d+/)
            if credential
              quantity_indexes = diagnostic_words.each_index.select { diagnostic_words[_1].match?(/\A\d+\z/) }
              quantity_prefix = quantity_indexes.one? ? diagnostic_words[...quantity_indexes.first] : []
              safe_prefix_words = %w[the your request input output context maximum max minimum min limit length] +
                %w[contains exceeds exceed exceeded is of too long]
              only_quantity_tokens = classified_markers.scan(credential_description).all? { _1.match?(/\Atokens?\z/i) }
              safe_limit = content &&
                only_quantity_tokens &&
                quantity_indexes.one? &&
                diagnostic_words[quantity_indexes.first].length <= 8 &&
                quantity_prefix.all? { safe_prefix_words.include?(_1) } &&
                quantity_prefix.any? { %w[request input output context].include?(_1) } &&
                quantity_prefix.any? do
                  %w[maximum max minimum min limit length contains exceeds exceed exceeded].include?(_1)
                end &&
                [%w[token], %w[tokens], %w[input token], %w[input tokens], %w[output token], %w[output tokens]].include?(
                  diagnostic_words[(quantity_indexes.first + 1)..]
                )
              next false unless safe_limit
            else
              status_code = diagnostic_words.last
              safe_status_code = status_code.length == 3 &&
                ("100".."599").cover?(status_code) &&
                [%w[error], %w[status], %w[http status]].include?(diagnostic_words[...-1])
              safe_named_code = classified_candidate.match?(/\A[a-z]+(?:_[a-z0-9]+){1,4}\z/i)
              next false unless safe_status_code || safe_named_code
            end
          end

          true
        end

        safe_url = OpenAI::Internal::Logging.safe_url(url).sub(/[?#].*/, "")
        fields = ["status=#{status}", "url=#{safe_url}"]
        request_id = headers&.[]("x-request-id")
        if request_id
          rendered_request_id = request_id.to_s
          safe_request_id = %r{
            \A(?:
              req_(?:[a-z0-9]{1,16}(?:_[a-z0-9]{1,12})?|[a-f0-9]{17,124}) |
              req-[a-z0-9]{1,16}-[a-z0-9]{1,32} |
              trace(?:_[a-z0-9]{1,16}|(?:\.[a-z0-9]{1,16}){1,4}) |
              [a-z0-9]{1,16}(?:-[a-z0-9]{1,16}){0,3}-(?:req|trace)-[a-z0-9]{1,32} |
              runtime-(?:chat|response|stream)-request |
              [a-f0-9]{8}(?:-[a-f0-9]{4}){3}-[a-f0-9]{12}
            )\z
          }ix
          if rendered_request_id.bytesize <= 128 &&
              rendered_request_id.ascii_only? &&
              rendered_request_id.match?(safe_request_id)
            fields << "request_id=#{bounded_status_field(request_id, limit: 128)}"
          end
        end

        fields << "message=#{bounded_status_field(upstream_message, limit: 512)}" if upstream_message

        fields.join(" ")
      end

      private def bounded_status_field(value, limit:)
        text = value.to_s
        escaped = OpenAI::Internal::Logging.safe_field(text[...limit])
        return escaped if text.length <= limit && escaped.bytesize <= limit

        "#{escaped.byteslice(0, limit)}..."
      end
    end

    class BadRequestError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 400
    end

    class AuthenticationError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 401
    end

    class PermissionDeniedError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 403
    end

    class NotFoundError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 404
    end

    class ConflictError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 409
    end

    class UnprocessableEntityError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 422
    end

    class RateLimitError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 429
    end

    class InternalServerError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = (500..)
    end

    class OAuthError < OpenAI::Errors::APIStatusError
      # @return [OpenAI::Models::OAuthErrorCode::Variants, nil]
      attr_reader :error_code

      def initialize(status:, body:, headers:)
        @error_code = OpenAI::Internal::Type::Converter.coerce(OpenAI::Models::OAuthErrorCode, body&.dig(:error))

        message = if body&.dig(:error_description)
          body[:error_description]
        elsif @error_code
          @error_code
        else
          "OAuth2 authentication error"
        end

        super(
          url: URI("https://auth.openai.com/oauth/token"),
          status: status,
          headers: headers,
          body: body,
          request: nil,
          response: nil,
          message: message
        )
      end
    end

    class SubjectTokenProviderError < OpenAI::Errors::Error
      attr_reader :provider
      attr_accessor :cause

      def initialize(message:, provider:, cause: nil)
        super(message)
        @provider = provider
        @cause = cause
      end
    end
  end
end
