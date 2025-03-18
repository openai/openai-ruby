# typed: strong

module OpenAI
  # @api private
  module Util
    # @api private
    sig { returns(Float) }
    def self.monotonic_secs
    end

    class << self
      # @api private
      sig { returns(String) }
      def arch
      end

      # @api private
      sig { returns(String) }
      def os
      end
    end

    class << self
      # @api private
      sig { params(input: T.anything).returns(T::Boolean) }
      def primitive?(input)
      end

      # @api private
      sig { params(input: T.anything).returns(T.any(T::Boolean, T.anything)) }
      def coerce_boolean(input)
      end

      # @api private
      sig { params(input: T.anything).returns(T.nilable(T::Boolean)) }
      def coerce_boolean!(input)
      end

      # @api private
      sig { params(input: T.anything).returns(T.any(Integer, T.anything)) }
      def coerce_integer(input)
      end

      # @api private
      sig { params(input: T.anything).returns(T.any(Float, T.anything)) }
      def coerce_float(input)
      end

      # @api private
      sig { params(input: T.anything).returns(T.any(T::Hash[T.anything, T.anything], T.anything)) }
      def coerce_hash(input)
      end
    end

    # Use this to indicate that a value should be explicitly removed from a data
    #   structure when using `OpenAI::Util.deep_merge`.
    #
    #   e.g. merging `{a: 1}` and `{a: OMIT}` should produce `{}`, where merging
    #   `{a: 1}` and `{}` would produce `{a: 1}`.
    OMIT = T.let(T.anything, T.anything)

    class << self
      # @api private
      sig { params(lhs: T.anything, rhs: T.anything, concat: T::Boolean).returns(T.anything) }
      private def deep_merge_lr(lhs, rhs, concat: false)
      end

      # @api private
      #
      # Recursively merge one hash with another. If the values at a given key are not
      #   both hashes, just take the new value.
      sig do
        params(values: T::Array[T.anything], sentinel: T.nilable(T.anything), concat: T::Boolean)
          .returns(T.anything)
      end
      def deep_merge(
        *values,
        # the value to return if no values are provided.
        sentinel: nil,
        # whether to merge sequences by concatenation.
        concat: false
      )
      end

      # @api private
      sig do
        params(
          data: T.any(T::Hash[Symbol, T.anything], T::Array[T.anything], T.anything),
          pick: T.nilable(T.any(Symbol, Integer, T::Array[T.any(Symbol, Integer)])),
          sentinel: T.nilable(T.anything),
          blk: T.nilable(T.proc.returns(T.anything))
        )
          .returns(T.nilable(T.anything))
      end
      def dig(data, pick, sentinel = nil, &blk)
      end
    end

    class << self
      # @api private
      sig { params(uri: URI::Generic).returns(String) }
      def uri_origin(uri)
      end

      # @api private
      sig { params(path: T.any(String, T::Array[String])).returns(String) }
      def interpolate_path(path)
      end
    end

    class << self
      # @api private
      sig { params(query: T.nilable(String)).returns(T::Hash[String, T::Array[String]]) }
      def decode_query(query)
      end

      # @api private
      sig do
        params(query: T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]))
          .returns(T.nilable(String))
      end
      def encode_query(query)
      end
    end

    ParsedUriShape = T.type_alias do
      {
        scheme: T.nilable(String),
        host: T.nilable(String),
        port: T.nilable(Integer),
        path: T.nilable(String),
        query: T::Hash[String, T::Array[String]]
      }
    end

    class << self
      # @api private
      sig { params(url: T.any(URI::Generic, String)).returns(OpenAI::Util::ParsedUriShape) }
      def parse_uri(url)
      end

      # @api private
      sig { params(parsed: OpenAI::Util::ParsedUriShape).returns(URI::Generic) }
      def unparse_uri(parsed)
      end

      # @api private
      sig do
        params(lhs: OpenAI::Util::ParsedUriShape, rhs: OpenAI::Util::ParsedUriShape).returns(URI::Generic)
      end
      def join_parsed_uri(lhs, rhs)
      end
    end

    class << self
      # @api private
      sig do
        params(
          headers: T::Hash[String,
                           T.nilable(T.any(String, Integer, T::Array[T.nilable(T.any(String, Integer))]))]
        )
          .returns(T::Hash[String, String])
      end
      def normalized_headers(*headers)
      end
    end

    # @api private
    #
    # An adapter that satisfies the IO interface required by `::IO.copy_stream`
    class ReadIOAdapter
      # @api private
      sig { params(max_len: T.nilable(Integer)).returns(String) }
      private def read_enum(max_len)
      end

      # @api private
      sig { params(max_len: T.nilable(Integer), out_string: T.nilable(String)).returns(T.nilable(String)) }
      def read(max_len = nil, out_string = nil)
      end

      # @api private
      sig do
        params(
          stream: T.any(String, IO, StringIO, T::Enumerable[String]),
          blk: T.proc.params(arg0: String).void
        )
          .returns(T.attached_class)
      end
      def self.new(stream, &blk)
      end
    end

    class << self
      sig { params(blk: T.proc.params(y: Enumerator::Yielder).void).returns(T::Enumerable[String]) }
      def string_io(&blk)
      end
    end

    class << self
      # @api private
      sig do
        params(y: Enumerator::Yielder, boundary: String, key: T.any(Symbol, String), val: T.anything).void
      end
      private def encode_multipart_formdata(y, boundary:, key:, val:)
      end

      # @api private
      sig { params(body: T.anything).returns([String, T::Enumerable[String]]) }
      private def encode_multipart_streaming(body)
      end

      # @api private
      sig { params(headers: T::Hash[String, String], body: T.anything).returns(T.anything) }
      def encode_content(headers, body)
      end

      # @api private
      sig do
        params(
          headers: T.any(T::Hash[String, String], Net::HTTPHeader),
          stream: T::Enumerable[String],
          suppress_error: T::Boolean
        )
          .returns(T.anything)
      end
      def decode_content(headers, stream:, suppress_error: false)
      end
    end

    class << self
      # @api private
      #
      # https://doc.rust-lang.org/std/iter/trait.FusedIterator.html
      sig do
        params(enum: T::Enumerable[T.anything], external: T::Boolean, close: T.proc.void)
          .returns(T::Enumerable[T.anything])
      end
      def fused_enum(enum, external: false, &close)
      end

      # @api private
      sig { params(enum: T.nilable(T::Enumerable[T.anything])).void }
      def close_fused!(enum)
      end

      # @api private
      sig do
        params(enum: T.nilable(T::Enumerable[T.anything]), blk: T.proc.params(arg0: Enumerator::Yielder).void)
          .returns(T::Enumerable[T.anything])
      end
      def chain_fused(enum, &blk)
      end
    end

    ServerSentEvent = T.type_alias do
      {event: T.nilable(String), data: T.nilable(String), id: T.nilable(String), retry: T.nilable(Integer)}
    end

    class << self
      # @api private
      sig { params(enum: T::Enumerable[String]).returns(T::Enumerable[String]) }
      def decode_lines(enum)
      end

      # @api private
      #
      # https://html.spec.whatwg.org/multipage/server-sent-events.html#parsing-an-event-stream
      sig { params(lines: T::Enumerable[String]).returns(OpenAI::Util::ServerSentEvent) }
      def decode_sse(lines)
      end
    end
  end
end
