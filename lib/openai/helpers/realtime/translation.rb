# frozen_string_literal: true

module OpenAI
  module Errors
    class TranslationConnectionError < OpenAI::Errors::WebSocketConnectionError
      private def default_message = "Realtime Translation WebSocket connection error."

      private def sanitized_error_url(url)
        sanitized = url.dup
        sanitized.user = nil if sanitized.respond_to?(:user=)
        sanitized.password = nil if sanitized.respond_to?(:password=)
        sanitized.query = nil if sanitized.respond_to?(:query=)
        sanitized.fragment = nil if sanitized.respond_to?(:fragment=)
        sanitized
      rescue ArgumentError, URI::Error
        URI("wss://invalid")
      end
    end

    class TranslationProtocolError < OpenAI::Errors::WebSocketProtocolError
      def initialize = super("Invalid Realtime Translation WebSocket event.")
    end
  end

  module Realtime
    # Future event data is accessible explicitly without leaking in diagnostics.
    class UnknownTranslationServerEvent < OpenAI::Realtime::UnknownServerEvent
    end

    # Opening does not send any events. session.close flushes remaining output;
    # read through session.closed before leaving the block to consume it.
    class TranslationConnection < OpenAI::WebSocket::TypedConnection
      # Timeout implementations before Ruby 4 raise StandardError through the
      # scheduler. Cross transport error wrappers without changing raw callers.
      # rubocop:disable Lint/InheritException
      class FinishTimeout < Exception
      end
      # rubocop:enable Lint/InheritException

      private_constant :FinishTimeout

      # @api private
      def initialize(socket:, url:)
        super(
          socket: socket,
          url: url,
          client_event: OpenAI::Realtime::RealtimeTranslationClientEvent,
          server_event: OpenAI::Realtime::RealtimeTranslationServerEvent
        )
        @poisoned = false
        @closed = false
        @write_mutex = Mutex.new
        @read_state_mutex = Mutex.new
        @active_reads = 0
      end

      # Request a final flush and yield every trailing event, including
      # session.closed, to the existing receive owner. Call after the final
      # admitted audio send returns. No second reader or reconnect is started.
      # The block is required so trailing audio, text and errors cannot be lost.
      #
      # @param timeout [Float] maximum seconds for the close write and drain
      # @yield [OpenAI::Realtime::RealtimeTranslationServerEvent]
      # @return [OpenAI::Realtime::RealtimeTranslationSessionClosedEvent]
      def finish(timeout:)
        raise ArgumentError, "A block is required to consume trailing Translation events." unless block_given?
        seconds = Float(timeout)
        unless seconds.finite? && seconds.positive?
          raise ArgumentError, "Translation finish timeout must be finite and positive."
        end

        require "timeout"

        @read_state_mutex.synchronize do
          if @finish_owner
            raise(
              connection_error("Translation finish must run on the existing receive owner, between reads."),
              cause: nil
            )
          end

          # SDK .cause accessors can expose diagnostics hidden from native rendering.
          raise @finish_error, cause: Exception.instance_method(:cause).bind_call(@finish_error) if @finish_error
          return @finish_terminal if @finish_terminal
          if @active_reads.positive? || @finish_requested
            raise(
              connection_error("Translation finish must run on the existing receive owner, between reads."),
              cause: nil
            )
          end

          @finish_owner = Fiber.current
        end

        begin
          Timeout.timeout(seconds, FinishTimeout) do
            write_text(encode_client_event(type: "session.close"), finish: true)
            while (event = receive)
              terminal = event.is_a?(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent)
              @read_state_mutex.synchronize { @finish_terminal = event } if terminal
              yield(event)
              return event if terminal
            end

            raise connection_error("Translation socket closed before session.closed."), cause: nil
          end

        rescue FinishTimeout
          error = Timeout::Error.new("Timed out finishing the Translation session.")
          @read_state_mutex.synchronize { @finish_error = error }
          raise error, cause: nil
        rescue StandardError => error
          @read_state_mutex.synchronize { @finish_error = error }
          raise
        ensure
          @read_state_mutex.synchronize { @finish_owner = nil }
        end
      end

      private def write_text(text, finish: false)
        @write_mutex.synchronize do
          if @finish_requested || (@finish_owner && !finish)
            raise connection_error("Cannot send after Translation finish was requested."), cause: nil
          end

          raise connection_error("Cannot send on a closed Realtime Translation WebSocket."), cause: nil if closed?
          @finish_requested = true if finish
          super(text)
        end
      end

      private def read_raw_message
        @read_state_mutex.synchronize do
          if @finish_owner && @finish_owner != Fiber.current
            raise(
              connection_error("Translation finish must run on the existing receive owner, between reads."),
              cause: nil
            )
          end

          @active_reads += 1
        end

        begin
          super
        ensure
          @read_state_mutex.synchronize { @active_reads -= 1 }
        end
      end

      private :parse_event

      private def coerce_client_event(payload) = coerce_event(@client_event, payload, outbound: true)

      private def coerce(type, value) = coerce_event(type, value)

      private def client_event_error_message = "Invalid Realtime Translation client event."

      private def unknown_server_event(payload) = OpenAI::Realtime::UnknownTranslationServerEvent.new(data: payload)

      private def protocol_error = OpenAI::Errors::TranslationProtocolError.new

      private def transport_error = OpenAI::Errors::TranslationConnectionError.new(url: @url)
      private def failed_read_message = "Cannot read from a failed Realtime Translation WebSocket."

      private def connection_error(message)
        OpenAI::Errors::TranslationConnectionError.new(url: @url, message: message)
      end
    end
  end

  module Helpers
    module Realtime
      module ClientExtension
        # @api private
        def with_translation_connection_request(model:, websocket_base_url: nil, options: nil, &block)
          websocket_base_url = websocket_base_url&.to_s&.dup&.freeze
          query = {"model" => model.to_s.dup.freeze}.freeze
          build = lambda do |deadline|
            build_shared_websocket_connection_request(
              request: realtime.translations.__websocket_request(query: query),
              websocket_base_url: websocket_base_url,
              options: options,
              deadline: deadline,
              validate: -> (_) { validate_translation_websocket_request! },
              invalid_base_url_message: "websocket_base_url must be an absolute HTTP or WebSocket URL " \
                "without credentials, query, or fragment",
              malformed_base_url_message: "websocket_base_url is not a valid URL",
              preserve_base_url_cause: false,
              extra_query_message: "request_options extra_query is not supported for Realtime Translation WebSockets",
              max_retries_message: "request_options max_retries is not supported for Realtime Translation WebSockets",
              timeout_error: -> (url, _) { OpenAI::Errors::TranslationConnectionError.new(url: url) }
            )
          end

          with_websocket_connection_retry(
            error_class: OpenAI::Errors::TranslationConnectionError,
            build: build,
            &block
          )
        end

        private def validate_translation_websocket_request!
          if x509_identity?(@copy_options.fetch(:workload_identity))
            raise OpenAI::Errors::Error, "X.509 workload identity does not support Realtime Translation WebSockets"
          end

          if @provider_runtime
            raise OpenAI::Errors::Error, "Realtime Translation WebSockets are not supported by providers."
          end
        end
      end

      module Connections
        # Open a Translation socket with its own protocol. The server creates the
        # session; session.close requests a flush without closing this reader.
        def connect_translation(
          model:,
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
          raise ArgumentError, "A block is required to open a Realtime Translation WebSocket." unless block

          request = lambda do |&request_block|
            @client.with_translation_connection_request(
              model: model,
              websocket_base_url: websocket_base_url,
              options: request_options,
              &request_block
            )
          end

          default_transport = lambda do
            OpenAI::WebSocket::AsyncWebSocketTransport.new(
              product_name: "Realtime Translation",
              error_class: OpenAI::Errors::TranslationConnectionError,
              error_factory: -> (url:, message: nil, http_status: nil, **) {
                OpenAI::Errors::TranslationConnectionError.new(url: url, message: message, http_status: http_status)
              }
            )
          end

          OpenAI::WebSocket::ConnectionManager
            .new(
              transport: transport,
              transport_options: transport_options,
              default_transport: default_transport,
              connection_class: OpenAI::Realtime::TranslationConnection,
              request: request,
              block_error_message: "A block is required to open a Realtime Translation WebSocket.",
              abort_after_block: -> (_connection, pending_error) { !pending_error.nil? },
              transport_error_factory: -> (url:, error:) {
                status = error.http_status if error.is_a?(OpenAI::Errors::WebSocketConnectionError)
                OpenAI::Errors::TranslationConnectionError.new(url: url, http_status: status)
              }
            )
            .open(&block)
        end
      end
    end
  end
end
