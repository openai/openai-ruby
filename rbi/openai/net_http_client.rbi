# typed: strong

module OpenAI
  class NetHTTPClient < OpenAI::HTTPClient
    KEEP_ALIVE_TIMEOUT = 30

    DEFAULT_MAX_CONNECTIONS = T.let(T.unsafe(nil), Integer)

    sig { params(url: URI::Generic).returns(Net::HTTP) }
    private def connect(url:)
    end

    sig { params(conn: Net::HTTP, deadline: T.nilable(Float)).void }
    private def calibrate_socket_timeout(conn, deadline)
    end

    sig do
      params(
        request: OpenAI::HTTPClient::Request,
        blk: T.proc.params(arg0: String).void
      )
        .returns([Net::HTTPGenericRequest, T.proc.void])
    end
    private def build_request(request, &blk)
    end

    sig do
      params(
        url: URI::Generic,
        deadline: T.nilable(Float),
        blk: T.proc.params(arg0: Net::HTTP).void
      )
        .void
    end
    private def with_pool(url, deadline:, &blk)
    end

    sig do
      params(
        connection: Net::HTTP,
        url: URI::Generic,
        deadline: T.nilable(Float)
      )
        .void
    end
    private def configure_connection(connection, url, deadline:)
    end

    sig { params(connection: Net::HTTP).void }
    private def close_connection(connection)
    end

    sig { void }
    def close
    end

    sig do
      params(request: OpenAI::HTTPClient::Request).returns(
        OpenAI::HTTPClient::Response
      )
    end
    def execute(request)
    end

    sig do
      params(
        size: Integer,
        connection_configurator: T.nilable(T.proc.params(http: Net::HTTP).void)
      )
        .returns(T.attached_class)
    end
    def self.new(
      size: OpenAI::NetHTTPClient::DEFAULT_MAX_CONNECTIONS,
      &connection_configurator
    )
    end
  end
end
