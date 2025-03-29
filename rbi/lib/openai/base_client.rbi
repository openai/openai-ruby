# typed: strong

module OpenAI
  # @api private
  class BaseClient
    abstract!

    RequestComponentsShape =
      T.type_alias do
        {
          method: Symbol,
          path: T.any(String, T::Array[String]),
          query: T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]),
          headers: T.nilable(
            T::Hash[String,
                    T.nilable(
                      T.any(
                        String,
                        Integer,
                        T::Array[T.nilable(T.any(String, Integer))]
                      )
                    )]
          ),
          body: T.nilable(T.anything),
          unwrap: T.nilable(Symbol),
          page: T.nilable(T::Class[OpenAI::BasePage[OpenAI::BaseModel]]),
          stream: T.nilable(T::Class[OpenAI::BaseStream[T.anything, OpenAI::BaseModel]]),
          model: T.nilable(OpenAI::Converter::Input),
          options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
        }
      end

    RequestInputShape =
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
      sig { params(req: OpenAI::BaseClient::RequestComponentsShape).void }
      def validate!(req)
      end

      # @api private
      sig do
        params(status: Integer, headers: T.any(T::Hash[String, String], Net::HTTPHeader)).returns(T::Boolean)
      end
      def should_retry?(status, headers:)
      end

      # @api private
      sig do
        params(
          request: OpenAI::BaseClient::RequestInputShape,
          status: Integer,
          response_headers: T.any(T::Hash[String, String], Net::HTTPHeader)
        )
          .returns(OpenAI::BaseClient::RequestInputShape)
      end
      def follow_redirect(request, status:, response_headers:)
      end

      # @api private
      sig do
        params(
          status: T.any(Integer, OpenAI::APIConnectionError),
          stream: T.nilable(T::Enumerable[String])
        ).void
      end
      def reap_connection!(status, stream:)
      end
    end

    # @api private
    sig { returns(OpenAI::PooledNetRequester) }
    attr_accessor :requester

    # @api private
    sig do
      params(
        base_url: String,
        timeout: Float,
        max_retries: Integer,
        initial_retry_delay: Float,
        max_retry_delay: Float,
        headers: T::Hash[String,
                         T.nilable(T.any(String, Integer, T::Array[T.nilable(T.any(String, Integer))]))],
        idempotency_header: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.new(
      base_url:,
      timeout: 0.0,
      max_retries: 0,
      initial_retry_delay: 0.0,
      max_retry_delay: 0.0,
      headers: {},
      idempotency_header: nil
    )
    end

    # @api private
    sig { overridable.returns(T::Hash[String, String]) }
    private def auth_headers
    end

    # @api private
    sig { returns(String) }
    private def generate_idempotency_key
    end

    # @api private
    sig do
      overridable
        .params(req: OpenAI::BaseClient::RequestComponentsShape, opts: OpenAI::Util::AnyHash)
        .returns(OpenAI::BaseClient::RequestInputShape)
    end
    private def build_request(req, opts)
    end

    # @api private
    sig { params(headers: T::Hash[String, String], retry_count: Integer).returns(Float) }
    private def retry_delay(headers, retry_count:)
    end

    # @api private
    sig do
      params(
        request: OpenAI::BaseClient::RequestInputShape,
        redirect_count: Integer,
        retry_count: Integer,
        send_retry_header: T::Boolean
      )
        .returns([Integer, Net::HTTPResponse, T::Enumerable[String]])
    end
    private def send_request(request, redirect_count:, retry_count:, send_retry_header:)
    end

    # Execute the request specified by `req`. This is the method that all resource
    #   methods call into.
    sig do
      params(
        method: Symbol,
        path: T.any(String, T::Array[String]),
        query: T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]),
        headers: T.nilable(
          T::Hash[String,
                  T.nilable(
                    T.any(
                      String,
                      Integer,
                      T::Array[T.nilable(T.any(String, Integer))]
                    )
                  )]
        ),
        body: T.nilable(T.anything),
        unwrap: T.nilable(Symbol),
        page: T.nilable(T::Class[OpenAI::BasePage[OpenAI::BaseModel]]),
        stream: T.nilable(T::Class[OpenAI::BaseStream[T.anything, OpenAI::BaseModel]]),
        model: T.nilable(OpenAI::Converter::Input),
        options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
      )
        .returns(T.anything)
    end
    def request(
      method,
      path,
      query: {},
      headers: {},
      body: nil,
      unwrap: nil,
      page: nil,
      stream: nil,
      model: OpenAI::Unknown,
      options: {}
    )
    end

    sig { returns(String) }
    def inspect
    end
  end
end
