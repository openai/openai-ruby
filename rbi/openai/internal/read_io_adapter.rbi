# typed: strong

module OpenAI
  module Internal
    module Util
      # @api private
      #
      # An adapter that satisfies the IO interface required by `::IO.copy_stream`
      class ReadIOAdapter
        # @api private
        sig { returns(T.nilable(T::Boolean)) }
        def close?
        end

        # @api private
        sig { void }
        def close
        end

        # @api private
        sig { params(max_len: T.nilable(Integer)).returns(T.nilable(String)) }
        private def read_enum(max_len)
        end

        # @api private
        sig { params(max_len: Integer).returns(String) }
        private def read_buffer(max_len)
        end

        # @api private
        sig do
          params(
            max_len: T.nilable(Integer),
            out_string: T.nilable(String)
          )
            .returns(T.nilable(String))
        end
        def read(max_len = nil, out_string = nil)
        end

        # @api private
        sig do
          params(
            src: T.any(String, Pathname, StringIO, T::Enumerable[String]),
            blk: T.proc.params(arg0: String).void
          )
            .returns(T.attached_class)
        end
        def self.new(src, &blk)
        end
      end
    end
  end
end
