# typed: strong

module OpenAI
  module Internal
    module Logging
      LOG_LEVELS = T.let(T.unsafe(nil), T::Hash[Symbol, Integer])
      REDACTED_HEADERS = T.let(T.unsafe(nil), T::Array[String])
      MAX_BODY_BYTES = T.let(T.unsafe(nil), Integer)
      MAX_ARRAY_ITEMS = T.let(T.unsafe(nil), Integer)
      OPAQUE_STRING_BYTES = T.let(T.unsafe(nil), Integer)
      SENSITIVE_BODY_KEY = T.let(T.unsafe(nil), Regexp)
      SENSITIVE_QUERY_KEY = T.let(T.unsafe(nil), Regexp)

      class Context
        sig do
          params(
            logger: T.untyped,
            log_level: Symbol,
            method: Symbol,
            url: URI::Generic
          ).returns(T.attached_class)
        end
        def self.new(logger:, log_level:, method:, url:)
        end

        sig do
          params(
            request: OpenAI::HTTPClient::Request,
            redirect_count: Integer
          ).void
        end
        def request_started(request, redirect_count:)
        end

        sig do
          params(response: OpenAI::HTTPClient::Response).returns(
            OpenAI::HTTPClient::Response
          )
        end
        def response_received(response)
        end

        sig { params(error: OpenAI::Errors::APIConnectionError).void }
        def attempt_failed(error)
        end

        sig do
          params(
            cause: T.any(Integer, OpenAI::Errors::APIConnectionError),
            delay: Float
          ).void
        end
        def retry_scheduled(cause, delay:)
        end

        sig { params(response: OpenAI::HTTPClient::Response).void }
        def completed(response)
        end

        sig { params(error: StandardError).void }
        def request_failed(error)
        end

        sig do
          params(
            body: String,
            headers: T::Hash[String, String],
            complete: T::Boolean,
            total_bytes: Integer,
            attempt: Integer
          ).void
        end
        def response_body(body, headers:, complete:, total_bytes:, attempt:)
        end
      end

      class ObservedBody
        include Enumerable

        Elem = type_member { { fixed: String } }

        sig do
          params(
            body: T::Enumerable[String],
            headers: T::Hash[String, String],
            context: OpenAI::Internal::Logging::Context,
            attempt: Integer
          ).returns(T.attached_class)
        end
        def self.new(body:, headers:, context:, attempt:)
        end

        sig { params(blk: T.untyped).returns(T.untyped) }
        def each(&blk)
        end

        sig { void }
        def close
        end
      end

      class << self
        sig { params(value: T.any(Symbol, String)).returns(Symbol) }
        def normalize_level(value)
        end

        sig { params(logger: T.untyped).void }
        def validate_logger!(logger)
        end

        sig { returns(Logger) }
        def default_logger
        end

        sig do
          params(configured_level: Symbol, event_level: Symbol).returns(
            T::Boolean
          )
        end
        def enabled?(configured_level, event_level)
        end

        sig { params(url: URI::Generic).returns(String) }
        def safe_path(url)
        end

        sig { params(url: URI::Generic).returns(String) }
        def safe_url(url)
        end

        sig { params(value: T.untyped).returns(String) }
        def safe_field(value)
        end

        sig { params(headers: T::Hash[String, String]).returns(String) }
        def format_headers(headers)
        end

        sig do
          params(body: T.untyped, headers: T::Hash[String, String]).returns(
            String
          )
        end
        def format_body(body, headers:)
        end

        sig { params(headers: T::Hash[String, String]).returns(T::Boolean) }
        def capture_response_body?(headers)
        end

        sig do
          params(
            body: String,
            headers: T::Hash[String, String],
            complete: T::Boolean,
            total_bytes: Integer
          ).returns(String)
        end
        def format_observed_body(body, headers:, complete:, total_bytes:)
        end
      end
    end
  end
end
