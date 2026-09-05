# frozen_string_literal: true

require_relative "../test_helper"

module OpenAI::Test::ResponsesWebSocketConnectionTestSupport
  class FakeSocket
    attr_reader :writes, :close_args

    def initialize(*reads)
      @reads = reads
      @writes = []
      @closed = false
      @aborted = false
    end

    def read = @reads.shift

    def write(message)
      @writes << message
      nil
    end

    def closed? = @closed

    def close(code: 1000, reason: "")
      @closed = true
      @close_args = {code: code, reason: reason}
      nil
    end

    def abort
      @closed = true
      @aborted = true
      nil
    end

    def aborted? = @aborted
  end

  class FailingWriteSocket < FakeSocket
    def write(_message) = raise IOError, "write failed with sensitive-body"
  end

  class FailingReadSocket < FakeSocket
    def read = raise IOError, "read failed with sensitive-body"
  end

  class FailingConnectionReadSocket < FakeSocket
    def read
      raise OpenAI::Errors::ResponsesConnectionError.new(url: URI("wss://example.com/v1/responses"))
    end
  end

  class PoisonClosedProbeSocket < FailingWriteSocket
    attr_reader :closed_checks

    def initialize
      super
      @closed_checks = 0
    end

    def closed?
      @closed_checks += 1
      super
    end
  end

  class FakeTransport
    attr_reader :open_args

    def initialize(socket)
      @socket = socket
    end

    def open(url:, headers:, timeout:, **options)
      @open_args = {url: url, headers: headers, timeout: timeout, options: options}
      yield(@socket)
    end
  end

  class RejectOnceTransport < FakeTransport
    attr_reader :attempts

    def initialize
      super(FakeSocket.new)
      @attempts = []
    end

    def open(url:, headers:, timeout:, **options)
      @attempts << {url: url, headers: headers, timeout: timeout, options: options}
      if @attempts.one?
        raise(
          OpenAI::Errors::ResponsesConnectionError.new(
            url: url,
            message: "upgrade rejected",
            http_status: 401
          )
        )
      end

      yield(@socket)
    end
  end

  private def client(**options)
    OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      **options
    )
  end

  private def workload_identity_client(timeout: 600)
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: "/not-read-by-this-test"
    )
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp_123",
      service_account_id: "sa_123",
      provider: provider
    )
    OpenAI::Client.new(
      api_key: nil,
      workload_identity: config,
      organization: "org_123",
      base_url: "https://example.com/v1",
      timeout: timeout
    )
  end

  private def text_delta(delta, stream_id: nil)
    JSON.generate(
      {
        type: "response.output_text.delta",
        sequence_number: 1,
        item_id: "item_1",
        output_index: 0,
        content_index: 0,
        delta: delta,
        logprobs: []
      }.compact.merge(stream_id ? {stream_id: stream_id} : {})
    )
  end
end
