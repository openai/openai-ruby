# frozen_string_literal: true

module OpenAI::Test::RealtimeTransportTestHelpers
  class AbortFramer
    class RawIO
      def initialize = @closed = false
      def close = @closed = true
      def closed? = @closed
    end

    class Stream
      attr_reader :io

      def initialize = @io = RawIO.new
      def to_io = @io
    end

    class Pool
      def release(_connection) = nil
    end

    def initialize
      @stream = Stream.new
      @pool = Pool.new
      @connection = Object.new
    end

    def aborted? = @stream.io.closed?
  end
end
