# frozen_string_literal: true

module OpenAI
  module WebSocket
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
      def receive_raw
        message = @socket.read
        message&.to_str
      end

      # Send an already encoded text message.
      def send_raw(data)
        raise connection_error(closed_send_message) if closed?

        text = data.dup
        text.force_encoding(Encoding::UTF_8) if text.encoding == Encoding::BINARY
        text = text.encode(Encoding::UTF_8) unless text.encoding == Encoding::UTF_8
        raise ArgumentError, invalid_text_message unless text.valid_encoding?

        @socket.write(text)
        nil
      end

      # Close the connection.
      def close(code: 1000, reason: "")
        return if closed?

        @socket.close(code: code, reason: reason)
        nil
      end

      # Abort without waiting for the WebSocket close handshake.
      #
      # @api private
      def abort
        return if closed?

        @socket.abort
        nil
      end

      # @return [Boolean]
      def closed? = @socket.closed?

      private def parse_event(_data)
        raise NotImplementedError
      end

      private def connection_error(_message)
        raise NotImplementedError
      end

      private def closed_send_message = "Cannot send on a closed WebSocket."

      private def invalid_text_message = "WebSocket text must contain valid UTF-8"
    end
  end
end
