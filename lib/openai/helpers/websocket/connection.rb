# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Retire failed sockets and uncertain writes without changing the raw connection contract.
    #
    # @api private
    module GuardedConnection
      def closed? = @poisoned || @closed || super

      def close(code: 1000, reason: "")
        @poisoned || @closed ? abort : super
        @closed = true
        nil
      rescue StandardError
        @poisoned = true
        raise transport_error, cause: nil
      end

      # @api private
      def abort
        super
        @closed = true
        nil
      rescue StandardError
        @poisoned = true
        raise transport_error, cause: nil
      end

      private def write_text(text)
        super
      rescue StandardError
        raise transport_error, cause: nil
      end

      private def read_raw_message
        raise connection_error(failed_read_message) if @poisoned
        return nil if @closed
        text = super
        @closed = text.nil?
        text
      rescue StandardError
        @poisoned = true
        raise transport_error, cause: nil
      end

      private def socket_closed?
        super
      rescue StandardError
        @poisoned = true
        raise transport_error, cause: nil
      end

    end

    # Product-neutral socket lifecycle and text I/O.
    #
    # @api private
    class Connection
      include Enumerable

      # @return [URI::Generic]
      attr_reader :url

      # @api private
      def initialize(socket:, url:)
        @socket = socket
        @url = url
        @poisoned = false
      end

      # Yield server events until the remote peer closes the connection.
      def each
        return enum_for(__method__) unless block_given?

        while (event = receive)
          yield(event)
        end

        self
      end

      # Receive and parse the next server event, or return nil after a clean close.
      def receive
        data = receive_raw
        return nil if data.nil?

        parse_event(data)
      end

      # Receive the next raw WebSocket message.
      #
      # @api private
      def receive_raw = read_raw_message

      private def read_raw_message
        raise connection_error("Cannot read from a failed WebSocket.") if @poisoned

        message = @socket.read
        message&.to_str
      end

      # Send an already encoded text message.
      #
      # @api private
      def send_raw(data)
        raise connection_error(closed_send_message) if closed?

        text = data.dup
        text.force_encoding(Encoding::UTF_8) if text.encoding == Encoding::BINARY
        text = text.encode(Encoding::UTF_8) unless text.encoding == Encoding::UTF_8
        raise ArgumentError, invalid_text_message unless text.valid_encoding?

        write_text(text)
      end

      # Close the connection.
      def close(code: 1000, reason: "")
        return abort if @poisoned
        return if socket_closed?

        @socket.close(code: code, reason: reason)
        nil
      end

      # Abort without waiting for the WebSocket close handshake.
      #
      # @api private
      def abort
        return if socket_closed?

        @socket.abort
        nil
      end

      # @return [Boolean]
      def closed? = @poisoned || socket_closed?

      private def parse_event(_data)
        raise NotImplementedError
      end

      private def connection_error(_message)
        raise NotImplementedError
      end

      private def closed_send_message = "Cannot send on a closed WebSocket."

      private def invalid_text_message = "WebSocket text must contain valid UTF-8"

      private def socket_closed? = @socket.closed?

      private def write_text(text)
        complete = false
        @socket.write(text)
        complete = true
        nil
      ensure
        unless complete
          # Retire the physical socket immediately: an already-running reader
          # can otherwise flush buffered application bytes while replying to close.
          @poisoned = true
          begin
            @socket.abort
          rescue StandardError
            # Preserve the original write failure or cancellation.
            nil
          end
        end
      end
    end
  end
end
