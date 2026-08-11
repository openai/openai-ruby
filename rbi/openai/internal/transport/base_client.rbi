# typed: strong

module OpenAI
  module Internal
    module Transport
      # @api private
      class BaseClient
        include OpenAI::Internal::Transport::RequestClient
        extend OpenAI::Internal::Util::SorbetRuntimeSupport

        abstract!

        RequestComponents = T.type_alias { T::Hash[Symbol, T.anything] }

        RequestInput =
          T.type_alias do
            {
              method: Symbol,
              url: URI::Generic,
              headers: T::Hash[String, String],
              body: T.anything,
              max_retries: Integer,
              timeout: Float
            }
          end

        # from whatwg fetch spec
        MAX_REDIRECTS = 20

        PLATFORM_HEADERS = T::Hash[String, String]

        class << self
          # @api private
          sig do
            params(
              req: OpenAI::Internal::Transport::BaseClient::RequestComponents
            ).void
          end
          def validate!(req)
          end

          # @api private
          sig do
            params(status: Integer, headers: T::Hash[String, String]).returns(
              T::Boolean
            )
          end
          def should_retry?(status, headers:)
          end

          # @api private
          sig { params(body: T.untyped).returns(T::Boolean) }
          def request_body_replayable?(body)
          end

          # @api private
          sig do
            params(
              request: OpenAI::Internal::Transport::BaseClient::RequestInput,
              status: Integer,
              response_headers: T::Hash[String, String]
            ).returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
          end
          def follow_redirect(request, status:, response_headers:)
          end

          # @api private
          sig do
            params(
              status: T.any(Integer, OpenAI::Errors::APIConnectionError),
              stream: T.nilable(T::Enumerable[String])
            ).void
          end
          def reap_connection!(status, stream:)
          end
        end

        sig { returns(URI::Generic) }
        attr_reader :base_url

        sig { returns(Float) }
        attr_reader :timeout

        sig { returns(Integer) }
        attr_reader :max_retries

        sig { returns(Float) }
        attr_reader :initial_retry_delay

        sig { returns(Float) }
        attr_reader :max_retry_delay

        sig { returns(T::Hash[String, String]) }
        attr_reader :headers

        sig { returns(T.nilable(String)) }
        attr_reader :idempotency_header

        # @api private
        sig { returns(T.untyped) }
        attr_reader :requester

        sig { returns(T.untyped) }
        attr_reader :logger

        sig { returns(Symbol) }
        attr_reader :log_level

        # @api private
        sig do
          params(
            base_url: String,
            timeout: Float,
            max_retries: Integer,
            initial_retry_delay: Float,
            max_retry_delay: Float,
            headers:
              T::Hash[
                String,
                T.nilable(
                  T.any(
                    String,
                    Integer,
                    T::Array[T.nilable(T.any(String, Integer))]
                  )
                )
              ],
            idempotency_header: T.nilable(String),
            http_client: T.untyped,
            logger: T.untyped,
            log_level: T.any(Symbol, String)
          ).returns(T.attached_class)
        end
        def self.new(
          base_url:,
          timeout: 0.0,
          max_retries: 0,
          initial_retry_delay: 0.0,
          max_retry_delay: 0.0,
          headers: {},
          idempotency_header: nil,
          http_client: nil,
          logger: nil,
          log_level: :off
        )
        end

        # @api private
        sig { overridable.returns(T::Hash[String, String]) }
        private def auth_headers
        end

        # @api private
        sig do
          overridable
            .params(
              request: OpenAI::Internal::Transport::BaseClient::RequestInput,
              redirect_count: Integer,
              retry_count: Integer
            )
            .returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
        end
        private def prepare_request(request, redirect_count:, retry_count:)
        end

        # @api private
        sig { returns(String) }
        private def user_agent
        end

        # @api private
        sig { returns(String) }
        private def generate_idempotency_key
        end

        # @api private
        sig do
          overridable
            .params(
              req: OpenAI::Internal::Transport::BaseClient::RequestComponents,
              opts: OpenAI::Internal::AnyHash
            )
            .returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
        end
        private def build_request(req, opts)
        end

        # @api private
        sig do
          params(
            request: OpenAI::Internal::Transport::BaseClient::RequestInput
          ).returns(T::Boolean)
        end
        private def request_replayable?(request)
        end

        # @api private
        sig do
          params(
            headers: T::Hash[String, String],
            retry_count: Integer
          ).returns(Float)
        end
        private def retry_delay(headers, retry_count:)
        end

        # @api private
        sig do
          params(
            url: URI::Generic,
            status: Integer,
            headers: T::Hash[String, String],
            response: OpenAI::HTTPClient::Response,
            stream: T::Enumerable[String]
          ).returns(T.noreturn)
        end
        private def raise_status_error!(
          url:,
          status:,
          headers:,
          response:,
          stream:
        )
        end

        # @api private
        sig do
          params(
            request: OpenAI::Internal::Transport::BaseClient::RequestInput,
            redirect_count: Integer,
            retry_count: Integer,
            send_retry_header: T::Boolean,
            log_context: OpenAI::Internal::Logging::Context
          ).returns(OpenAI::HTTPClient::Response)
        end
        def send_request(
          request,
          redirect_count:,
          retry_count:,
          send_retry_header:,
          log_context:
        )
        end

        # Execute the request specified by `req`. This is the method that all resource
        # methods call into.
        #
        sig do
          override
            .params(
              req: OpenAI::Internal::Transport::BaseClient::RequestComponents
            )
            .returns(T.anything)
        end
        def request(req)
        end

        # @api private
        sig do
          params(
            req: OpenAI::Internal::Transport::BaseClient::RequestComponents
          ).returns(OpenAI::RawResponse[T.anything])
        end
        def raw_request(req)
        end

        # @api private
        sig do
          params(
            req: OpenAI::Internal::Transport::BaseClient::RequestComponents
          ).returns(
            [
              URI::Generic,
              OpenAI::HTTPClient::Response,
              OpenAI::Internal::Logging::Context
            ]
          )
        end
        private def perform_request(req)
        end

        # @api private
        sig do
          params(
            log_context: OpenAI::Internal::Logging::Context,
            response: OpenAI::HTTPClient::Response,
            blk: T.proc.returns(T.anything)
          ).returns(T.anything)
        end
        private def finish_request(log_context, response, &blk)
        end

        # @api private
        sig do
          params(
            req: OpenAI::Internal::Transport::BaseClient::RequestComponents,
            url: URI::Generic,
            response: OpenAI::HTTPClient::Response
          ).returns(T.anything)
        end
        private def parse_response(req, url:, response:)
        end

        # @api private
        sig { returns(String) }
        def inspect
        end
      end
    end
  end
end
