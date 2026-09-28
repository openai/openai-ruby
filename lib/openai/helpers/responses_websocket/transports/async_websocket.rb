# frozen_string_literal: true

module OpenAI
  module Responses
    module Transports
      # Responses facade for the shared optional async WebSocket transport.
      #
      # @api private
      class AsyncWebSocket < OpenAI::WebSocket::AsyncWebSocketTransport
        # Native frame parsing bounds each allocation before reading its body. Keep
        # room for legal control frames, then enforce the exact data-only total.
        class BoundedFramer
          def initialize(framer, max_bytes:, max_frames:)
            @framer = framer
            @max_bytes = max_bytes
            @max_frames = max_frames
            @message_bytes = 0
            @message_frames = 0
            @aborted = false
          end

          def read_frame
            maximum_size = if @max_frames && @message_frames >= @max_frames
              125
            elsif @max_bytes
              [@max_bytes - @message_bytes, 125].max
            else
              ::Protocol::WebSocket::MAXIMUM_ALLOWED_FRAME_SIZE
            end

            frame = @framer.read_frame(maximum_size)
            unless frame.control?
              @message_bytes += frame.length
              @message_frames += 1
              if (@max_bytes && @message_bytes > @max_bytes) || (@max_frames && @message_frames > @max_frames)
                raise ::Protocol::WebSocket::ProtocolError, "Responses WebSocket message exceeds configured limit."
              end

              if frame.finished?
                @message_bytes = 0
                @message_frames = 0
              end
            end

            frame
          rescue ::Protocol::WebSocket::ProtocolError
            # Native protocol-error cleanup would flush to the rejected connection.
            self.abort
            raise
          end

          def write_frame(frame) = @framer.write_frame(frame)

          def flush = @framer.flush

          def close
            @framer.close unless @aborted
          end

          def abort
            return if @aborted

            @aborted = true
            @framer.abort
          end
        end

        private_constant :BoundedFramer

        def initialize
          error_factory = lambda do |url:, message: nil, http_status: nil, **_options|
            OpenAI::Errors::ResponsesConnectionError.new(
              url: url,
              message: message,
              http_status: http_status
            )
          end

          super(
            product_name: "Responses",
            error_class: OpenAI::Errors::ResponsesConnectionError,
            error_factory: error_factory,
            dependency_message: "Responses WebSockets require the async-websocket gem. Add it to your Gemfile."
          )
        end

        private def negotiation_options(endpoint_options)
          max_bytes = endpoint_options.delete(:max_message_bytes)
          max_frames = endpoint_options.delete(:max_message_frames)
          return {} if max_bytes.nil? && max_frames.nil?

          {max_message_bytes: max_bytes, max_message_frames: max_frames}.each do |name, value|
            unless value.nil? || (value.is_a?(Integer) && value.positive?)
              raise ArgumentError, "#{name} must be a positive Integer or nil"
            end
          end

          handler = lambda do |framer, protocol, extensions, **options|
            framer.extend(AbortableFramer)
            bounded = BoundedFramer.new(framer, max_bytes: max_bytes, max_frames: max_frames)
            ::Async::WebSocket::Connection.call(bounded, protocol, extensions, **options)
          end

          options = {handler: handler}
          # A decoded-byte limit cannot safely use the gem's whole-message inflate.
          # No byte limit keeps the gem's default compression negotiation unchanged.
          options[:extensions] = ::Protocol::WebSocket::Extensions::Client.new([]) if max_bytes
          options
        end
      end
    end
  end
end
