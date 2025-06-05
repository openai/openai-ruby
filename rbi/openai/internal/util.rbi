# typed: strong

module OpenAI
  module Internal
    # @api private
    module Util
      extend OpenAI::Internal::Util::SorbetRuntimeSupport

      # @api private
      sig { returns(Float) }
      def self.monotonic_secs
      end

      # @api private
      sig do
        params(ns: T.any(Module, T::Class[T.anything])).returns(
          T::Enumerable[T.any(Module, T::Class[T.anything])]
        )
      end
      def self.walk_namespaces(ns)
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
        sig do
          params(input: T.any(String, T::Boolean)).returns(
            T.any(T::Boolean, T.anything)
          )
        end
        def coerce_boolean(input)
        end

        # @api private
        sig do
          params(input: T.any(String, T::Boolean)).returns(
            T.nilable(T::Boolean)
          )
        end
        def coerce_boolean!(input)
        end

        # @api private
        sig do
          params(input: T.any(String, Integer)).returns(
            T.any(Integer, T.anything)
          )
        end
        def coerce_integer(input)
        end

        # @api private
        sig do
          params(input: T.any(String, Integer, Float)).returns(
            T.any(Float, T.anything)
          )
        end
        def coerce_float(input)
        end

        # @api private
        sig do
          params(input: T.anything).returns(
            T.any(T::Hash[T.anything, T.anything], T.anything)
          )
        end
        def coerce_hash(input)
        end

        # @api private
        sig do
          params(input: T.anything).returns(
            T.nilable(T::Hash[T.anything, T.anything])
          )
        end
        def coerce_hash!(input)
        end
      end

      class << self
        # @api private
        sig do
          params(lhs: T.anything, rhs: T.anything, concat: T::Boolean).returns(
            T.anything
          )
        end
        private def deep_merge_lr(lhs, rhs, concat: false)
        end

        # @api private
        #
        # Recursively merge one hash with another. If the values at a given key are not
        # both hashes, just take the new value.
        sig do
          params(
            values: T::Array[T.anything],
            sentinel: T.nilable(T.anything),
            concat: T::Boolean
          ).returns(T.anything)
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
            data:
              T.any(
                OpenAI::Internal::AnyHash,
                T::Array[T.anything],
                T.anything
              ),
            pick:
              T.nilable(
                T.any(
                  Symbol,
                  Integer,
                  T::Array[T.any(Symbol, Integer)],
                  T.proc.params(arg0: T.anything).returns(T.anything)
                )
              ),
            blk: T.nilable(T.proc.returns(T.anything))
          ).returns(T.nilable(T.anything))
        end
        def dig(data, pick, &blk)
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
        sig do
          params(query: T.nilable(String)).returns(
            T::Hash[String, T::Array[String]]
          )
        end
        def decode_query(query)
        end

        # @api private
        sig do
          params(
            query:
              T.nilable(
                T::Hash[String, T.nilable(T.any(T::Array[String], String))]
              )
          ).returns(T.nilable(String))
        end
        def encode_query(query)
        end
      end

      ParsedUri =
        T.type_alias do
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
        sig do
          params(url: T.any(URI::Generic, String)).returns(
            OpenAI::Internal::Util::ParsedUri
          )
        end
        def parse_uri(url)
        end

        # @api private
        sig do
          params(parsed: OpenAI::Internal::Util::ParsedUri).returns(
            URI::Generic
          )
        end
        def unparse_uri(parsed)
        end

        # @api private
        sig do
          params(
            lhs: OpenAI::Internal::Util::ParsedUri,
            rhs: OpenAI::Internal::Util::ParsedUri
          ).returns(URI::Generic)
        end
        def join_parsed_uri(lhs, rhs)
        end
      end

      class << self
        # @api private
        sig do
          params(
            headers:
              T::Hash[
                String,
                T.nilable(
                  T.any(
                    String,
                    Integer,
                    T::Array[T.nilable(T.any(String, Integer))]
                  )
                )
              ]
          ).returns(T::Hash[String, String])
        end
        def normalized_headers(*headers)
        end
      end

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
        sig { params(max_len: T.nilable(Integer)).returns(String) }
        private def read_enum(max_len)
        end

        # @api private
        sig do
          params(
            max_len: T.nilable(Integer),
            out_string: T.nilable(String)
          ).returns(T.nilable(String))
        end
        def read(max_len = nil, out_string = nil)
        end

        # @api private
        sig do
          params(
            src: T.any(String, Pathname, StringIO, T::Enumerable[String]),
            blk: T.proc.params(arg0: String).void
          ).returns(T.attached_class)
        end
        def self.new(src, &blk)
        end
      end

      class << self
        sig do
          params(blk: T.proc.params(y: Enumerator::Yielder).void).returns(
            T::Enumerable[String]
          )
        end
        def writable_enum(&blk)
        end
      end

      JSON_CONTENT =
        T.let(%r{^application/(?:vnd(?:\.[^.]+)*\+)?json(?!l)}, Regexp)
      JSONL_CONTENT =
        T.let(%r{^application/(:?x-(?:n|l)djson)|(:?(?:x-)?jsonl)}, Regexp)

      class << self
        # @api private
        sig do
          params(
            y: Enumerator::Yielder,
            val: T.anything,
            closing: T::Array[T.proc.void],
            content_type: T.nilable(String)
          ).void
        end
        private def write_multipart_content(
          y,
          val:,
          closing:,
          content_type: nil
        )
        end

        # @api private
        sig do
          params(
            y: Enumerator::Yielder,
            boundary: String,
            key: T.any(Symbol, String),
            val: T.anything,
            closing: T::Array[T.proc.void]
          ).void
        end
        private def write_multipart_chunk(y, boundary:, key:, val:, closing:)
        end

        # @api private
        #
        # https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.1.md#special-considerations-for-multipart-content
        sig do
          params(body: T.anything).returns([String, T::Enumerable[String]])
        end
        private def encode_multipart_streaming(body)
        end

        # @api private
        sig do
          params(headers: T::Hash[String, String], body: T.anything).returns(
            T.anything
          )
        end
        def encode_content(headers, body)
        end

        # @api private
        #
        # https://www.iana.org/assignments/character-sets/character-sets.xhtml
        sig { params(content_type: String, text: String).void }
        def force_charset!(content_type, text:)
        end

        # @api private
        #
        # Assumes each chunk in stream has `Encoding::BINARY`.
        sig do
          params(
            headers: T.any(T::Hash[String, String], Net::HTTPHeader),
            stream: T::Enumerable[String],
            suppress_error: T::Boolean
          ).returns(T.anything)
        end
        def decode_content(headers, stream:, suppress_error: false)
        end
      end

      class << self
        # @api private
        #
        # https://doc.rust-lang.org/std/iter/trait.FusedIterator.html
        sig do
          params(
            enum: T::Enumerable[T.anything],
            external: T::Boolean,
            close: T.proc.void
          ).returns(T::Enumerable[T.anything])
        end
        def fused_enum(enum, external: false, &close)
        end

        # @api private
        sig { params(enum: T.nilable(T::Enumerable[T.anything])).void }
        def close_fused!(enum)
        end

        # @api private
        sig do
          params(
            enum: T.nilable(T::Enumerable[T.anything]),
            blk: T.proc.params(arg0: Enumerator::Yielder).void
          ).returns(T::Enumerable[T.anything])
        end
        def chain_fused(enum, &blk)
        end
      end

      ServerSentEvent =
        T.type_alias do
          {
            event: T.nilable(String),
            data: T.nilable(String),
            id: T.nilable(String),
            retry: T.nilable(Integer)
          }
        end

      class << self
        # @api private
        #
        # Assumes Strings have been forced into having `Encoding::BINARY`.
        #
        # This decoder is responsible for reassembling lines split across multiple
        # fragments.
        sig do
          params(enum: T::Enumerable[String]).returns(T::Enumerable[String])
        end
        def decode_lines(enum)
        end

        # @api private
        #
        # https://html.spec.whatwg.org/multipage/server-sent-events.html#parsing-an-event-stream
        #
        # Assumes that `lines` has been decoded with `#decode_lines`.
        sig do
          params(lines: T::Enumerable[String]).returns(
            T::Enumerable[OpenAI::Internal::Util::ServerSentEvent]
          )
        end
        def decode_sse(lines)
        end
      end

      # @api private
      module SorbetRuntimeSupport
        class MissingSorbetRuntimeError < ::RuntimeError
        end

        # @api private
        sig { returns(T::Hash[Symbol, T.anything]) }
        private def sorbet_runtime_constants
        end

        # @api private
        sig { params(name: Symbol).void }
        def const_missing(name)
        end

        # @api private
        sig { params(name: Symbol).returns(T::Boolean) }
        def sorbet_constant_defined?(name)
        end

        # @api private
        sig { params(name: Symbol, blk: T.proc.returns(T.anything)).void }
        def define_sorbet_constant!(name, &blk)
        end

        # @api private
        sig { returns(T.anything) }
        def to_sorbet_type
        end

        class << self
          # @api private
          sig do
            params(
              type:
                T.any(OpenAI::Internal::Util::SorbetRuntimeSupport, T.anything)
            ).returns(T.anything)
          end
          def to_sorbet_type(type)
          end
        end
      end
    end
  end
end
