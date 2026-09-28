# frozen_string_literal: true

module OpenAI
  module Responses
    module Transports
      # Responses facade for the shared optional async WebSocket transport.
      #
      # @api private
      class AsyncWebSocket < OpenAI::WebSocket::AsyncWebSocketTransport
        # HTTP/1's buffered stream can inspect RSV1 without consuming bytes.
        # Leave every part of frame parsing to the installed native protocol gem.
        module PeekableFramer
          # @api private
          def next_frame_compressed?
            first_byte = @stream.peek(1)&.getbyte(0) || 0
            (first_byte & (::Protocol::WebSocket::Frame::RSV1 << 4)) != 0
          end
        end

        private_constant :PeekableFramer

        # Native frame parsing bounds each allocation before reading its body. Keep
        # room for legal control frames, then enforce the exact data-only total.
        class BoundedFramer
          def initialize(framer, max_bytes:, max_frames:, max_plain_bytes: nil)
            @framer = framer
            @max_bytes = max_bytes
            @max_frames = max_frames
            @max_plain_bytes = max_plain_bytes
            @message_bytes = 0
            @message_frames = 0
            @aborted = false
            @compressed = false
            @compression_negotiated = false
          end

          # @api private
          attr_writer :compression_negotiated

          def read_frame
            limit = @max_bytes
            if @max_plain_bytes
              # Continuations of compressed messages never set RSV1 themselves.
              # An unsolicited RSV1 cannot enlarge the limit when no compression
              # was negotiated. The gem still validates reserved bits and opcodes.
              compressed = @compression_negotiated &&
                (@message_frames.zero? ? @framer.next_frame_compressed? : @compressed)
              limit = [limit, @max_plain_bytes].min unless compressed
            end

            maximum_size = if @max_frames && @message_frames >= @max_frames
              125
            elsif limit
              [limit - @message_bytes, 125].max
            else
              ::Protocol::WebSocket::MAXIMUM_ALLOWED_FRAME_SIZE
            end

            frame = @framer.read_frame(maximum_size)
            unless frame.control?
              if @message_frames.zero?
                @compressed = @compression_negotiated && frame.flag?(::Protocol::WebSocket::Frame::RSV1)
              end

              @message_bytes += frame.length
              @message_frames += 1
              if (@max_bytes && @message_bytes > @max_bytes) ||
                  (@max_frames && @message_frames > @max_frames) ||
                  (!@compressed && @max_plain_bytes && @message_bytes > @max_plain_bytes)
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

        # Keep the negotiated native reader, frame parsing and RSV checks. Bound
        # inflation before collecting its full output; Zlib yields at most a
        # native output chunk beyond the configured decoded-message limit.
        module BoundedInflate
          # @api private
          def bound_decoded_messages(max_bytes, framer)
            @responses_decoded_limit = max_bytes
            @responses_bounded_framer = framer
          end

          private def inflate(buffer)
            inflater = @responses_inflater ||= ::Zlib::Inflate.new(-window_bits)
            start_out = inflater.total_out
            decoded = +"".b
            begin
              inflater.inflate(buffer + ::Protocol::WebSocket::Extension::Compression::Inflate::TRAILER) do |chunk|
                if inflater.total_out - start_out > @responses_decoded_limit
                  raise ::Protocol::WebSocket::ProtocolError, "Responses WebSocket message exceeds configured limit."
                end

                decoded << chunk
              end
              # A PMCE SYNC_FLUSH does not yield the partial final chunk.
              # Check the produced byte count before extracting that tail.
              if inflater.total_out - start_out > @responses_decoded_limit
                raise ::Protocol::WebSocket::ProtocolError, "Responses WebSocket message exceeds configured limit."
              end

              decoded << inflater.flush_next_out
            rescue ::Protocol::WebSocket::ProtocolError
              @responses_bounded_framer.abort
              inflater.close
              @responses_inflater = nil
              raise
            ensure
              unless context_takeover || @responses_inflater.nil?
                inflater.close
                @responses_inflater = nil
              end
            end

            decoded
          end
        end

        private_constant :BoundedInflate

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
          max_wire_bytes = endpoint_options.delete(:max_wire_message_bytes)
          return {} if max_bytes.nil? && max_frames.nil? && max_wire_bytes.nil?

          {max_message_bytes: max_bytes, max_message_frames: max_frames, max_wire_message_bytes: max_wire_bytes}.each do |
              name,
              value
            |
            unless value.nil? || (value.is_a?(Integer) && value.positive?)
              raise ArgumentError, "#{name} must be a positive Integer or nil"
            end
          end

          handler = lambda do |framer, protocol, extensions, **options|
            framer.extend(AbortableFramer, PeekableFramer)
            bounded = BoundedFramer.new(
              framer,
              max_bytes: max_wire_bytes || max_bytes,
              max_frames: max_frames,
              max_plain_bytes: max_wire_bytes ? max_bytes : nil
            )
            connection = ::Async::WebSocket::Connection.call(bounded, protocol, extensions, **options)
            if max_wire_bytes &&
                max_bytes &&
                connection.reader.is_a?(::Protocol::WebSocket::Extension::Compression::Inflate)
              connection.reader.extend(BoundedInflate)
              connection.reader.bound_decoded_messages(max_bytes, bounded)
              bounded.compression_negotiated = true
            end

            connection
          end

          options = {handler: handler}
          # A decoded-byte limit cannot safely use the gem's whole-message inflate.
          # No byte limit keeps the gem's default compression negotiation unchanged.
          options[:extensions] = ::Protocol::WebSocket::Extensions::Client.new([]) if max_bytes && !max_wire_bytes
          options
        end
      end
    end
  end
end
