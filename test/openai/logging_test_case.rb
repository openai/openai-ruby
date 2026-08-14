# frozen_string_literal: true

require_relative "test_helper"

class OpenAILoggingTestCase < Minitest::Test
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

    attr_reader :chunk_count, :close_count, :each_count

    def initialize(*chunks)
      @chunks = chunks
      @chunk_count = 0
      @close_count = 0
      @each_count = 0
    end

    def close = (@close_count += 1)

    def each
      @each_count += 1
      @chunks.each do |chunk|
        @chunk_count += 1
        yield(chunk)
      end
    end
  end

  class UnbufferableChunk < String
    def byteslice(*) = raise("stream chunk was buffered")
  end

  class FailingBody
    include Enumerable

    attr_reader :close_count

    def initialize(error)
      @error = error
      @close_count = 0
    end

    def each
      yield("partial")
      raise @error
    end

    def close = (@close_count += 1)
  end

  def setup
    super
    @openai_log = ENV.delete("OPENAI_LOG")
  end

  def teardown
    @openai_log.nil? ? ENV.delete("OPENAI_LOG") : ENV["OPENAI_LOG"] = @openai_log
    super
  end

  def diagnostic_client(
    http_client: StubHTTPClient.new { raise "unexpected HTTP request" },
    logger: nil,
    log_level: nil,
    on_retry: nil,
    **options
  )
    transport = StubHTTPClient.new { |request| http_client.execute(request) }
    client_options = {
      api_key: "test-key",
      **options,
      http_client: transport,
      logger: logger,
      log_level: log_level,
      on_retry: on_retry
    }
    OpenAI::Client.new(**client_options)
  end
end
