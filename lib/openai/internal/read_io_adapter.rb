# frozen_string_literal: true

module OpenAI
  module Internal
    module Util
      # @api private
      #
      # An adapter that satisfies the IO interface required by `::IO.copy_stream`
      class ReadIOAdapter
        class InterruptibleEnumerator
          # Cancellation must bypass application rescues so a suspended source cannot
          # swallow it and keep the request teardown blocked.
          # rubocop:disable Lint/InheritException
          class Interrupt < Exception
          end
          # rubocop:enable Lint/InheritException

          private_constant :Interrupt

          def initialize(source)
            @started = false
            @fiber = Fiber.new do
              source.each { Fiber.yield(_1) }
            rescue Interrupt
              nil
            end
          end

          def next
            raise StopIteration unless @fiber&.alive?

            @started = true
            value = @fiber.resume
            raise StopIteration unless @fiber.alive?

            value
          end

          def to_a
            values = []
            loop { values << self.next }
            values
          end

          def close
            @fiber&.raise Interrupt if @started && @fiber&.alive?
          rescue Interrupt
            nil
          ensure
            @fiber = nil
          end
        end

        private_constant :InterruptibleEnumerator

        # @api private
        #
        # @return [Boolean, nil]
        def close? = @closing

        # @api private
        def close
          case @stream
          in Enumerator
            OpenAI::Internal::Util.close_fused!(@stream)
          in InterruptibleEnumerator | IO if close?
            @stream.close
          else
          end
        end

        # @api private
        #
        # @param max_len [Integer, nil]
        #
        # @return [String, nil]
        private def read_enum(max_len)
          case max_len
          in nil
            # `loop` rescues StopIteration, but this method handles it below.
            # rubocop:disable Style/InfiniteLoop
            @buf << @stream.next.b while true
            # rubocop:enable Style/InfiniteLoop
          in Integer
            @buf << @stream.next.b while @buf.bytesize < max_len
            read_buffer(max_len)
          end

        rescue StopIteration
          return @buf.slice!(0..) if max_len.nil?

          @stream = nil
          return nil if @buf.bytesize.zero?

          read_buffer(max_len)
        end

        # @api private
        #
        # @param max_len [Integer]
        #
        # @return [String]
        private def read_buffer(max_len)
          read = @buf.byteslice(0, max_len)
          @buf = @buf.byteslice(max_len..) || String.new.b
          read
        end

        # @api private
        #
        # @param max_len [Integer, nil]
        # @param out_string [String, nil]
        #
        # @return [String, nil]
        def read(max_len = nil, out_string = nil)
          if max_len.is_a?(Integer) && max_len.negative?
            raise ArgumentError, "negative length #{max_len} given"
          end

          read = case @stream
          in nil
            max_len.nil? || max_len.zero? ? +"" : nil
          in IO | StringIO
            return @stream.read(max_len, out_string).tap(&@blk)
          in Enumerator | InterruptibleEnumerator
            read_enum(max_len)
          end

          case out_string
          in String
            out_string.replace(read || +"")
            read.nil? ? nil : out_string
          in nil
            read
          end
            .tap(&@blk)
        end

        # @api private
        #
        # @param src [String, Pathname, StringIO, Enumerable<String>]
        # @param blk [Proc]
        #
        # @yieldparam [String]
        def initialize(src, &blk)
          @stream = case src
          in String
            StringIO.new(src)
          in Pathname
            @closing = true
            src.open(binmode: true)
          in Enumerator
            @closing = true
            InterruptibleEnumerator.new(src)
          else
            src
          end

          @buf = String.new.b
          @blk = blk
        end
      end
    end
  end
end
