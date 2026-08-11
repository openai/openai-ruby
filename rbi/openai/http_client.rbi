# typed: strong

module OpenAI
  class HTTPClient
    class Request
      sig { returns(Symbol) }
      attr_reader :method

      sig { returns(URI::Generic) }
      attr_reader :url

      sig { returns(T::Hash[String, String]) }
      attr_reader :headers

      sig { returns(T.anything) }
      attr_reader :body

      sig { returns(T.nilable(Float)) }
      attr_reader :timeout

      sig do
        params(
          method: Symbol,
          url: URI::Generic,
          headers: T::Hash[String, String],
          body: T.anything,
          timeout: T.nilable(Float)
        ).returns(T.attached_class)
      end
      def self.new(method:, url:, headers:, body:, timeout:)
      end
    end

    class Response
      sig { returns(Integer) }
      attr_reader :status

      sig { returns(T::Hash[String, String]) }
      attr_reader :headers

      sig { returns(T::Enumerable[String]) }
      attr_reader :body

      sig do
        params(
          status: Integer,
          headers: T::Hash[String, String],
          body: T.any(String, T::Enumerable[String])
        ).returns(T.attached_class)
      end
      def self.new(status:, headers:, body:)
      end
    end

    sig do
      params(request: OpenAI::HTTPClient::Request).returns(
        OpenAI::HTTPClient::Response
      )
    end
    def execute(request)
    end
  end
end
