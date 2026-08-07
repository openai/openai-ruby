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
          class Interrupt < Exception # rubocop:disable Lint/InheritException
          end
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
          rescue StopIteration
            values
          end

          def close
            @fiber&.raise(Interrupt) if @started && @fiber&.alive?
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
        # @return [String]
        private def read_enum(max_len)
          case max_len
          in nil
            @stream.to_a.join
          in Integer
            @buf << @stream.next while @buf.length < max_len
            @buf.slice!(..max_len)
          end
        rescue StopIteration
          @stream = nil
          @buf.slice!(0..)
        end

        # @api private
        #
        # @param max_len [Integer, nil]
        # @param out_string [String, nil]
        #
        # @return [String, nil]
        def read(max_len = nil, out_string = nil)
          case @stream
          in nil
            nil
          in IO | StringIO
            @stream.read(max_len, out_string)
          in Enumerator | InterruptibleEnumerator
            read = read_enum(max_len)
            case out_string
            in String
              out_string.replace(read)
            in nil
              read
            end
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
          @stream =
            case src
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
          @buf = String.new
          @blk = blk
        end
      end
    end
  end
end
