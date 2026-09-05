# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Shared block-scoped WebSocket opening and cleanup.
    #
    # @api private
    class ConnectionManager
      RESERVED_TRANSPORT_OPTIONS = [
        :alpn_protocols,
        :headers,
        :hostname,
        :port,
        :protocol,
        :scheme,
        :ssl_context,
        :timeout,
        :url
      ].freeze

      # @api private
      def initialize(
        transport:,
        transport_options:,
        default_transport:,
        connection_class:,
        request:,
        block_error_message:,
        abort_after_block:,
        transport_error_message: "transport must respond to open",
        reserved_options_error_message: nil
      )
        @transport = transport
        @default_transport = default_transport
        @connection_class = connection_class
        @request = request
        @block_error_message = block_error_message
        @abort_after_block = abort_after_block
        @transport_error_message = transport_error_message
        @reserved_options_error_message = reserved_options_error_message
        @transport_options = validated_transport_options(transport_options)
      end

      # @api private
      def open
        raise ArgumentError, @block_error_message unless block_given?

        transport = @transport || @default_transport.call
        raise ArgumentError, @transport_error_message unless transport.respond_to?(:open)

        @request.call do |request, mark_handshake_completed|
          transport
            .open(
              url: request.fetch(:url),
              headers: request.fetch(:headers),
              timeout: request.fetch(:timeout),
              **@transport_options
            ) do |socket|
              mark_handshake_completed.call
              connection = @connection_class.new(socket: socket, url: request.fetch(:url))
              begin
                yield(connection)
              ensure
                cleanup(connection)
              end
            end
        end
      end

      private def validated_transport_options(transport_options)
        options = transport_options.dup.freeze
        reserved = options.keys.select do |key|
          (key.is_a?(String) || key.is_a?(Symbol)) && RESERVED_TRANSPORT_OPTIONS.include?(key.to_sym)
        end

        unless reserved.empty?
          message = if @reserved_options_error_message
            @reserved_options_error_message.call(reserved)
          else
            "transport_options cannot include #{reserved.map(&:inspect).join(", ")}"
          end

          raise ArgumentError, message
        end

        options
      end

      private def cleanup(connection)
        pending_error = $ERROR_INFO
        begin
          if @abort_after_block.call(connection, pending_error)
            connection.abort
          else
            connection.close
          end

        rescue StandardError
          raise if pending_error.nil?
        end
      end
    end
  end
end
