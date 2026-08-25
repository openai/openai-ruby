# frozen_string_literal: true

require_relative "../test_helper"

module OpenAI::Test::RealtimeConnectionTestSupport
  class FakeSocket
    attr_reader :writes, :close_args

    def initialize(*reads)
      @reads = reads
      @writes = []
      @closed = false
      @aborted = false
    end

    def read = @reads.shift
    def write(message) = @writes << message
    def closed? = @closed

    def close(code: 1000, reason: "")
      @closed = true
      @close_args = {code: code, reason: reason}
    end

    def abort
      @closed = true
      @aborted = true
    end

    def aborted? = @aborted
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

  private def client(**options)
    OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      **options
    )
  end

  private def text_delta(delta)
    JSON.generate(
      type: "response.output_text.delta",
      event_id: "event_1",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0,
      delta: delta
    )
  end
end
