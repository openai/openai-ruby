# frozen_string_literal: true

module OpenAI
  module Realtime
    # Owns successive block-scoped sockets on one Async reactor. Calls from other
    # fibers or threads use mailboxes; the physical socket never leaves its owner.
    # No incoming events are prefetched: a receive request drives each read.
    #
    # @api private
    class Recovery
      def self.validate_options!(max_reconnect_attempts:, max_queue_bytes:, on_reconnected:)
        {max_reconnect_attempts: max_reconnect_attempts, max_queue_bytes: max_queue_bytes}.each do |name, value|
          unless value.is_a?(Integer) && value >= 0
            raise ArgumentError, "`#{name}` must be a nonnegative Integer."
          end
        end

        unless on_reconnected.nil? || on_reconnected.respond_to?(:call)
          raise ArgumentError, "`on_reconnected` must respond to `call`."
        end
      end

      def initialize(manager:, max_reconnect_attempts:, max_queue_bytes:, on_reconnected:)
        @manager = manager
        @max_attempts = max_reconnect_attempts
        @max_queue_bytes = max_queue_bytes
        @on_reconnected = on_reconnected
        @mutex = Mutex.new
        @commands = Queue.new
        @reads = Queue.new
        @stop_requests = Queue.new
        @ready = Queue.new
        @waiters = {}
        @pending = []
        @pending_bytes = 0
        @state = :connecting
        @generation = 0
        @attempts = 0
        @flushing = false
      end

      def inspect = "#<#{self.class.name}>"

      def open
        load_async
        ::Kernel.Sync() do |root|
          stopper = root.async do
            @stop_requests.pop
            @lifecycle&.stop
          end

          @lifecycle = root.async { run }
          begin
            kind, value = @ready.pop
            raise value, cause: nil if kind == :error

            result = yield(value)
            raise @error, cause: nil if @error

            result
          ensure
            $! ? abort : close
            @lifecycle.wait
            stopper.stop
          end
        end
      end

      def closed? = @mutex.synchronize { @state == :closed }

      def reconnecting?
        @mutex.synchronize { @state == :recovering || @state == :restoring }
      end

      def pending_messages = @mutex.synchronize { @pending.dup }

      def take_pending_messages
        @mutex.synchronize do
          raise state_error("Cannot remove queued events while flushing.") if @flushing

          messages = @pending
          @pending = []
          @pending_bytes = 0
          messages
        end
      end

      def read
        return @physical.receive_raw if Fiber.current.equal?(@owner_fiber)

        reply = @mutex.synchronize do
          raise @error, cause: nil if @error
          return nil if @state == :closed

          register(:read).tap { @reads << _1 }
        end

        await_reply(reply)
      end

      def write(text)
        return write_once(text) if Fiber.current.equal?(@owner_fiber)

        reply = @mutex.synchronize do
          raise @error, cause: nil if @error
          raise state_error("Cannot send on a closed Realtime WebSocket.") if [:closed, :ending].include?(@state)

          if @state != :open || @flushing
            if @max_queue_bytes.zero? || @pending_bytes + [text.bytesize, 1].max > @max_queue_bytes
              raise OpenAI::Errors::RealtimeQueueFullError
            end

            @pending << text.dup.freeze
            @pending_bytes += [text.bytesize, 1].max
            return nil
          end

          register(:write).tap { @commands << [:write, text.dup.freeze, _1, @generation] }
        end

        await_reply(reply)
        nil
      end

      def flush_pending
        if Fiber.current.equal?(@owner_fiber)
          raise state_error("Queue flush interrupted; remaining events were not sent.") unless flush
          return nil
        end

        reply = @mutex.synchronize do
          raise @error, cause: nil if @error
          raise state_error("Cannot flush until the replacement connection is ready.") unless @state == :open

          register(:flush).tap { @commands << [:flush, nil, _1, @generation] }
        end

        await_reply(reply)
        nil
      end

      # Cancel outstanding work and make a bounded attempt to send the close frame.
      def close(code: 1000, reason: "")
        stop({code: code, reason: reason})
      end

      def abort = stop(nil)

      private def stop(close_options)
        changed = @mutex.synchronize do
          next false if @state == :closed
          if @inflight
            fail_locked(
              "Realtime connection closed during a send; delivery is uncertain.",
              uncertain_message: @inflight
            )
          else
            @close_options = close_options
            finish_locked
          end

          true
        end

        @stop_requests << true if changed
        nil
      end

      private def register(kind)
        Queue.new.tap { @waiters[_1] = kind }
      end

      private def load_async
        require "async"

      rescue LoadError => e
        raise(
          LoadError.new(
            "Realtime reconnect requires Async. Add `gem \"async\"` (or `gem \"async-websocket\"`) to your Gemfile."
          ),
          cause: e
        )
      end

      private def await_reply(reply)
        kind, value = reply.pop
        raise value, cause: nil if kind == :error

        value
      ensure
        # Cancellation must not leave a read consuming an event for an abandoned
        # caller, or a write happening later without an observable outcome.
        abort if @mutex.synchronize { @waiters.key?(reply) }
      end

      private def respond(reply, value = nil, error: nil)
        return unless reply

        @mutex.synchronize do
          if @waiters.delete(reply)
            reply << [error ? :error : :ok, error || value]
          end
        end
      end

      private def run
        loop do
          break if closed?

          begin
            @manager.open { |physical| serve(physical) }
            break
          rescue StandardError, LoadError => e
            break if closed?
            if @callback_failed || e.is_a?(OpenAI::Errors::RealtimeReconnectError) || e.is_a?(LoadError)
              finish(e)
              break
            end

            unless recoverable?(e) && @attempts < @max_attempts
              @mutex.synchronize { fail_locked("Realtime reconnect stopped; the connection could not be recovered.") }
              break
            end

            @mutex.synchronize { @state = :recovering unless @state == :closed }
            @attempts += 1
            sleep(retry_delay)
          end
        end

      ensure
        finish
        @ready << [:error, @error || state_error("Realtime connection closed before opening.")] unless @connection
      end

      private def serve(physical)
        @owner_fiber = Fiber.current
        @physical = physical
        @mutex.synchronize do
          return if @state == :closed

          @generation += 1
          @state = @connection ? :restoring : :open
        end

        if @connection
          begin
            @on_reconnected&.call(@connection)
          rescue StandardError, LoadError
            @callback_failed = true
            raise
          end
        else
          @connection = OpenAI::Realtime::Connection.new(socket: self, url: physical.url, recovery: self)
          @ready << [:ok, @connection]
        end

        return if closed?

        @mutex.synchronize { @state = :open unless @state == :closed }
        reader = ::Async::Task.current.async { read_loop }
        until closed?
          kind, data, reply, generation = @commands.pop
          case kind
          when :lost
            raise data
          when :end
            break
          else
            writable = @mutex.synchronize { @state == :open && generation == @generation }
            unless writable
              respond(reply, error: state_error("Connection interrupted before sending; event was not sent."))
              next
            end

            if kind == :write
              write_once(data)
              respond(reply)
            elsif flush
              respond(reply)
            else
              respond(reply, error: state_error("Queue flush interrupted; remaining events were not sent."))
            end
          end
        end

      ensure
        begin
          reader&.stop
        ensure
          begin
            if @close_options
              ::Async::Task.current.with_timeout(1) { physical.close(**@close_options) }
            end

          rescue StandardError
            # Shutdown must not mask the operation's result or prevent cleanup.
            nil
          ensure
            physical.abort
            @physical = nil
          end
        end
      end

      private def read_loop
        loop do
          @read_reply ||= @reads.pop
          value = @physical.receive_raw
          if value.nil?
            @mutex.synchronize do
              if @inflight || !@pending.empty?
                fail_locked(
                  "Realtime connection closed with pending sends; in-flight delivery is uncertain.",
                  uncertain_message: @inflight
                )
              elsif @state != :closed
                @state = :ending
              end
            end

            if closed?
              @stop_requests << true
              return
            end
          end

          respond(@read_reply, value)
          @read_reply = nil
          if value.nil?
            @commands << [:end]
            break
          end
        end

      rescue StandardError => e
        @mutex.synchronize do
          if @inflight
            fail_locked(
              "Realtime connection interrupted during a send; delivery is uncertain.",
              uncertain_message: @inflight
            )
          elsif @state != :closed
            @state = :recovering
          end
        end

        if closed?
          @stop_requests << true
        else
          @commands << [:lost, e]
        end
      end

      private def write_once(text, queued: false)
        @mutex.synchronize do
          raise state_error("Cannot send on a closed Realtime WebSocket.") if @state == :closed
          @inflight = text.dup.freeze
        end

        begin
          @physical.send_raw(text)
        rescue StandardError
          error = @mutex.synchronize do
            fail_locked(
              "Realtime send failed; delivery is uncertain and the event was not retried.",
              uncertain_message: text
            )
          end

          raise error, cause: nil
        ensure
          @mutex.synchronize do
            @inflight = nil
            if queued && @pending.first.equal?(text)
              @pending.shift
              @pending_bytes -= [text.bytesize, 1].max
            end
          end
        end
      end

      private def flush
        @mutex.synchronize { @flushing = true }
        loop do
          text = @mutex.synchronize do
            return false unless [:open, :restoring].include?(@state)
            @pending.first
          end

          break unless text

          write_once(text, queued: true)
        end

        true
      ensure
        @mutex.synchronize { @flushing = false }
      end

      private def finish(error = nil)
        @mutex.synchronize { finish_locked(error) }
      end

      private def finish_locked(error = nil)
        return if @state == :closed

        @error = error
        @state = :closed
        @waiters.each do |reply, kind|
          failure = error ||
            (kind == :read ? nil : state_error("Realtime connection closed before completing the operation."))
          reply << [failure ? :error : :ok, failure]
        end

        @waiters.clear
        @commands.clear
        @reads.clear
        @read_reply = nil
      end

      private def fail_locked(message, uncertain_message: nil)
        return @error if @state == :closed && @error

        if @flushing && uncertain_message && @pending.first == uncertain_message
          @pending.shift
          @pending_bytes -= [uncertain_message.bytesize, 1].max
        end

        error = OpenAI::Errors::RealtimeReconnectError.new(
          message: message,
          unsent_messages: @pending,
          uncertain_message: uncertain_message&.dup&.freeze
        )
        finish_locked(error)
        error
      end

      private def state_error(message)
        OpenAI::Errors::RealtimeReconnectError.new(message: message)
      end

      private def retry_delay = [0.5 * (2 ** [@attempts - 1, 4].min), 8.0].min * (0.75 + (rand * 0.25))

      private def recoverable?(error)
        return false unless error.is_a?(OpenAI::Errors::RealtimeConnectionError)
        return [408, 429, 500, 502, 503, 504].include?(error.http_status) if error.http_status

        cause = error.cause
        if defined?(::Protocol::WebSocket::ClosedError) && cause.is_a?(::Protocol::WebSocket::ClosedError)
          return [1001, 1005, 1006, 1011, 1012, 1013].include?(cause.code)
        end

        cause.is_a?(EOFError) ||
          cause.is_a?(Errno::ECONNRESET) ||
          cause.is_a?(Errno::ECONNREFUSED) ||
          cause.is_a?(Errno::ETIMEDOUT) ||
          cause.is_a?(Errno::EPIPE) ||
          cause.is_a?(Timeout::Error) ||
          cause.is_a?(::Async::TimeoutError)
      end
    end
  end
end
