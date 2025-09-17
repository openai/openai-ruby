# frozen_string_literal: true

module OpenAI
  module Internal
    # @api private
    module Util
      # @api private
      #
      # @return [Float]
      def self.monotonic_secs = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      # @api private
      #
      # @param ns [Module, Class]
      #
      # @return [Enumerable<Module, Class>]
      def self.walk_namespaces(ns)
        ns.constants(false).lazy.flat_map do
          case (c = ns.const_get(_1, false))
          in Module | Class
            walk_namespaces(c)
          else
            []
          end
        end
          .chain([ns])
      end

      class << self
        # @api private
        #
        # @return [String]
        def arch
          case (arch = RbConfig::CONFIG["arch"])&.downcase
          in nil
            "unknown"
          in /aarch64|arm64/
            "arm64"
          in /x86_64/
            "x64"
          in /arm/
            "arm"
          else
            "other:#{arch}"
          end
        end

        # @api private
        #
        # @return [String]
        def os
          case (host = RbConfig::CONFIG["host_os"])&.downcase
          in nil
            "Unknown"
          in /linux/
            "Linux"
          in /darwin/
            "MacOS"
          in /freebsd/
            "FreeBSD"
          in /openbsd/
            "OpenBSD"
          in /mswin|mingw|cygwin|ucrt/
            "Windows"
          else
            "Other:#{host}"
          end
        end
      end

      class << self
        # @api private
        #
        # @param input [Object]
        #
        # @return [Boolean]
        def primitive?(input)
          case input
          in true | false | Numeric | Symbol | String
            true
          else
            false
          end
        end

        # @api private
        #
        # @param input [String, Boolean]
        #
        # @return [Boolean, Object]
        def coerce_boolean(input)
          case input.is_a?(String) ? input.downcase : input
          in "true"
            true
          in "false"
            false
          else
            input
          end
        end

        # @api private
        #
        # @param input [String, Boolean]
        #
        # @raise [ArgumentError]
        # @return [Boolean, nil]
        def coerce_boolean!(input)
          case coerce_boolean(input)
          in true | false | nil => coerced
            coerced
          else
            raise ArgumentError.new("Unable to coerce #{input.inspect} into boolean value")
          end
        end

        # @api private
        #
        # @param input [String, Integer]
        #
        # @return [Integer, Object]
        def coerce_integer(input)
          Integer(input, exception: false) || input
        end

        # @api private
        #
        # @param input [String, Integer, Float]
        #
        # @return [Float, Object]
        def coerce_float(input)
          Float(input, exception: false) || input
        end

        # @api private
        #
        # @param input [Object]
        #
        # @return [Hash{Object=>Object}, Object]
        def coerce_hash(input)
          case input
          in NilClass | Array | Set | Enumerator | StringIO | IO
            input
          else
            input.respond_to?(:to_h) ? input.to_h : input
          end
        end

        # @api private
        #
        # @param input [Object]
        #
        # @raise [ArgumentError]
        # @return [Hash{Object=>Object}, nil]
        def coerce_hash!(input)
          case coerce_hash(input)
          in Hash | nil => coerced
            coerced
          else
            message = "Expected a #{Hash} or #{OpenAI::Internal::Type::BaseModel}, got #{data.inspect}"
            raise ArgumentError.new(message)
          end
        end
      end

      class << self
        # @api private
        #
        # @param lhs [Object]
        # @param rhs [Object]
        # @param concat [Boolean]
        #
        # @return [Object]
        private def deep_merge_lr(lhs, rhs, concat: false)
          case [lhs, rhs, concat]
          in [Hash, Hash, _]
            lhs.merge(rhs) { deep_merge_lr(_2, _3, concat: concat) }
          in [Array, Array, true]
            lhs.concat(rhs)
          else
            rhs
          end
        end

        # @api private
        #
        # Recursively merge one hash with another. If the values at a given key are not
        # both hashes, just take the new value.
        #
        # @param values [Array<Object>]
        #
        # @param sentinel [Object, nil] the value to return if no values are provided.
        #
        # @param concat [Boolean] whether to merge sequences by concatenation.
        #
        # @return [Object]
        def deep_merge(*values, sentinel: nil, concat: false)
          case values
          in [value, *values]
            values.reduce(value) do |acc, val|
              deep_merge_lr(acc, val, concat: concat)
            end
          else
            sentinel
          end
        end

        # @api private
        #
        # @param data [Hash{Symbol=>Object}, Array<Object>, Object]
        # @param pick [Symbol, Integer, Array<Symbol, Integer>, Proc, nil]
        # @param blk [Proc, nil]
        #
        # @return [Object, nil]
        def dig(data, pick, &blk)
          case [data, pick]
          in [_, nil]
            data
          in [Hash, Symbol] | [Array, Integer]
            data.fetch(pick) { blk&.call }
          in [Hash | Array, Array]
            pick.reduce(data) do |acc, key|
              case acc
              in Hash if acc.key?(key)
                acc.fetch(key)
              in Array if key.is_a?(Integer) && key < acc.length
                acc[key]
              else
                return blk&.call
              end
            end
          in [_, Proc]
            pick.call(data)
          else
            blk&.call
          end
        end
      end

      class << self
        # @api private
        #
        # @param uri [URI::Generic]
        #
        # @return [String]
        def uri_origin(uri)
          "#{uri.scheme}://#{uri.host}#{":#{uri.port}" unless uri.port == uri.default_port}"
        end

        # @api private
        #
        # @param path [String, Array<String>]
        #
        # @return [String]
        def interpolate_path(path)
          case path
          in String
            path
          in []
            ""
          in [String => p, *interpolations]
            encoded = interpolations.map { ERB::Util.url_encode(_1) }
            format(p, *encoded)
          end
        end
      end

      class << self
        # @api private
        #
        # @param query [String, nil]
        #
        # @return [Hash{String=>Array<String>}]
        def decode_query(query)
          CGI.parse(query.to_s)
        end

        # @api private
        #
        # @param query [Hash{String=>Array<String>, String, nil}, nil]
        #
        # @return [String, nil]
        def encode_query(query)
          query.to_h.empty? ? nil : URI.encode_www_form(query)
        end
      end

      class << self
        # @api private
        #
        # @param url [URI::Generic, String]
        #
        # @return [Hash{Symbol=>String, Integer, nil}]
        def parse_uri(url)
          parsed = URI::Generic.component.zip(URI.split(url)).to_h
          {**parsed, query: decode_query(parsed.fetch(:query))}
        end

        # @api private
        #
        # @param parsed [Hash{Symbol=>String, Integer, nil}] .
        #
        #   @option parsed [String, nil] :scheme
        #
        #   @option parsed [String, nil] :host
        #
        #   @option parsed [Integer, nil] :port
        #
        #   @option parsed [String, nil] :path
        #
        #   @option parsed [Hash{String=>Array<String>}] :query
        #
        # @return [URI::Generic]
        def unparse_uri(parsed)
          URI::Generic.build(**parsed, query: encode_query(parsed.fetch(:query)))
        end

        # @api private
        #
        # @param lhs [Hash{Symbol=>String, Integer, nil}] .
        #
        #   @option lhs [String, nil] :scheme
        #
        #   @option lhs [String, nil] :host
        #
        #   @option lhs [Integer, nil] :port
        #
        #   @option lhs [String, nil] :path
        #
        #   @option lhs [Hash{String=>Array<String>}] :query
        #
        # @param rhs [Hash{Symbol=>String, Integer, nil}] .
        #
        #   @option rhs [String, nil] :scheme
        #
        #   @option rhs [String, nil] :host
        #
        #   @option rhs [Integer, nil] :port
        #
        #   @option rhs [String, nil] :path
        #
        #   @option rhs [Hash{String=>Array<String>}] :query
        #
        # @return [URI::Generic]
        def join_parsed_uri(lhs, rhs)
          base_path, base_query = lhs.fetch_values(:path, :query)
          slashed = base_path.end_with?("/") ? base_path : "#{base_path}/"

          parsed_path, parsed_query = parse_uri(rhs.fetch(:path)).fetch_values(:path, :query)
          override = URI::Generic.build(**rhs.slice(:scheme, :host, :port), path: parsed_path)

          joined = URI.join(URI::Generic.build(lhs.except(:path, :query)), slashed, override)
          query = deep_merge(
            joined.path == base_path ? base_query : {},
            parsed_query,
            rhs[:query].to_h,
            concat: true
          )

          joined.query = encode_query(query)
          joined
        end
      end

      class << self
        # @api private
        #
        # @param headers [Hash{String=>String, Integer, Array<String, Integer, nil>, nil}]
        #
        # @return [Hash{String=>String}]
        def normalized_headers(*headers)
          {}.merge(*headers.compact).to_h do |key, val|
            value =
              case val
              in Array
                val.filter_map { _1&.to_s&.strip }.join(", ")
              else
                val&.to_s&.strip
              end
            [key.downcase, value]
          end
        end
      end

      # @api private
      #
      # An adapter that satisfies the IO interface required by `::IO.copy_stream`
      class ReadIOAdapter
        # @api private
        #
        # @return [Boolean, nil]
        def close? = @closing

        # @api private
        def close
          case @stream
          in Enumerator
            OpenAI::Internal::Util.close_fused!(@stream)
          in IO if close?
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
          in Enumerator
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
            else
              src
            end
          @buf = String.new
          @blk = blk
        end
      end

      class << self
        # @param blk [Proc]
        #
        # @yieldparam [Enumerator::Yielder]
        # @return [Enumerable<String>]
        def writable_enum(&blk)
          Enumerator.new do |y|
            buf = String.new
            y.define_singleton_method(:write) do
              self << buf.replace(_1)
              buf.bytesize
            end

            blk.call(y)
          end
        end
      end

      # @type [Regexp]
      JSON_CONTENT = %r{^application/(?:vnd(?:\.[^.]+)*\+)?json(?!l)}
      # @type [Regexp]
      JSONL_CONTENT = %r{^application/(:?x-(?:n|l)djson)|(:?(?:x-)?jsonl)}

      class << self
        # @api private
        #
        # @param y [Enumerator::Yielder]
        # @param val [Object]
        # @param closing [Array<Proc>]
        # @param content_type [String, nil]
        private def write_multipart_content(y, val:, closing:, content_type: nil)
          content_line = "Content-Type: %s\r\n\r\n"

          case val
          in OpenAI::FilePart
            return write_multipart_content(
              y,
              val: val.content,
              closing: closing,
              content_type: val.content_type
            )
          in Pathname
            y << format(content_line, content_type || "application/octet-stream")
            io = val.open(binmode: true)
            closing << io.method(:close)
            IO.copy_stream(io, y)
          in IO
            y << format(content_line, content_type || "application/octet-stream")
            IO.copy_stream(val, y)
          in StringIO
            y << format(content_line, content_type || "application/octet-stream")
            y << val.string
          in -> { primitive?(_1) }
            y << format(content_line, content_type || "text/plain")
            y << val.to_s
          else
            y << format(content_line, content_type || "application/json")
            y << JSON.generate(val)
          end
          y << "\r\n"
        end

        # @api private
        #
        # @param y [Enumerator::Yielder]
        # @param boundary [String]
        # @param key [Symbol, String]
        # @param val [Object]
        # @param closing [Array<Proc>]
        private def write_multipart_chunk(y, boundary:, key:, val:, closing:)
          y << "--#{boundary}\r\n"
          y << "Content-Disposition: form-data"

          unless key.nil?
            name = ERB::Util.url_encode(key.to_s)
            y << "; name=\"#{name}\""
          end

          case val
          in OpenAI::FilePart unless val.filename.nil?
            filename = ERB::Util.url_encode(val.filename)
            y << "; filename=\"#{filename}\""
          in Pathname | IO
            filename = ERB::Util.url_encode(::File.basename(val.to_path))
            y << "; filename=\"#{filename}\""
          else
          end
          y << "\r\n"

          write_multipart_content(y, val: val, closing: closing)
        end

        # @api private
        #
        # https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.1.md#special-considerations-for-multipart-content
        #
        # @param body [Object]
        #
        # @return [Array(String, Enumerable<String>)]
        private def encode_multipart_streaming(body)
          boundary = SecureRandom.urlsafe_base64(60)

          closing = []
          strio = writable_enum do |y|
            case body
            in Hash
              body.each do |key, val|
                case val
                in Array if val.all? { primitive?(_1) }
                  val.each do |v|
                    write_multipart_chunk(y, boundary: boundary, key: key, val: v, closing: closing)
                  end
                else
                  write_multipart_chunk(y, boundary: boundary, key: key, val: val, closing: closing)
                end
              end
            else
              write_multipart_chunk(y, boundary: boundary, key: nil, val: body, closing: closing)
            end
            y << "--#{boundary}--\r\n"
          end

          fused_io = fused_enum(strio) { closing.each(&:call) }
          [boundary, fused_io]
        end

        # @api private
        #
        # @param headers [Hash{String=>String}]
        # @param body [Object]
        #
        # @return [Object]
        def encode_content(headers, body)
          # rubocop:disable Style/CaseEquality
          # rubocop:disable Layout/LineLength
          content_type = headers["content-type"]
          case [content_type, body]
          in [OpenAI::Internal::Util::JSON_CONTENT, Hash | Array | -> { primitive?(_1) }]
            [headers, JSON.generate(body)]
          in [OpenAI::Internal::Util::JSONL_CONTENT, Enumerable] unless OpenAI::Internal::Type::FileInput === body
            [headers, body.lazy.map { JSON.generate(_1) }]
          in [%r{^multipart/form-data}, Hash | OpenAI::Internal::Type::FileInput]
            boundary, strio = encode_multipart_streaming(body)
            headers = {**headers, "content-type" => "#{content_type}; boundary=#{boundary}"}
            [headers, strio]
          in [_, Symbol | Numeric]
            [headers, body.to_s]
          in [_, StringIO]
            [headers, body.string]
          in [_, OpenAI::FilePart]
            [headers, body.content]
          else
            [headers, body]
          end
          # rubocop:enable Layout/LineLength
          # rubocop:enable Style/CaseEquality
        end

        # @api private
        #
        # https://www.iana.org/assignments/character-sets/character-sets.xhtml
        #
        # @param content_type [String]
        # @param text [String]
        def force_charset!(content_type, text:)
          charset = /charset=([^;\s]+)/.match(content_type)&.captures&.first

          return unless charset

          begin
            encoding = Encoding.find(charset)
            text.force_encoding(encoding)
          rescue ArgumentError
            nil
          end
        end

        # @api private
        #
        # Assumes each chunk in stream has `Encoding::BINARY`.
        #
        # @param headers [Hash{String=>String}]
        # @param stream [Enumerable<String>]
        # @param suppress_error [Boolean]
        #
        # @raise [JSON::ParserError]
        # @return [Object]
        def decode_content(headers, stream:, suppress_error: false)
          case (content_type = headers["content-type"])
          in OpenAI::Internal::Util::JSON_CONTENT
            json = stream.to_a.join
            begin
              JSON.parse(json, symbolize_names: true)
            rescue JSON::ParserError => e
              raise e unless suppress_error
              json
            end
          in OpenAI::Internal::Util::JSONL_CONTENT
            lines = decode_lines(stream)
            chain_fused(lines) do |y|
              lines.each { y << JSON.parse(_1, symbolize_names: true) }
            end
          in %r{^text/event-stream}
            lines = decode_lines(stream)
            decode_sse(lines)
          else
            text = stream.to_a.join
            force_charset!(content_type, text: text)
            StringIO.new(text)
          end
        end
      end

      class << self
        # @api private
        #
        # https://doc.rust-lang.org/std/iter/trait.FusedIterator.html
        #
        # @param enum [Enumerable<Object>]
        # @param external [Boolean]
        # @param close [Proc]
        #
        # @return [Enumerable<Object>]
        def fused_enum(enum, external: false, &close)
          fused = false
          iter = Enumerator.new do |y|
            next if fused

            fused = true
            if external
              loop { y << enum.next }
            else
              enum.each(&y)
            end
          ensure
            close&.call
            close = nil
          end

          iter.define_singleton_method(:rewind) do
            fused = true
            self
          end
          iter
        end

        # @api private
        #
        # @param enum [Enumerable<Object>, nil]
        def close_fused!(enum)
          return unless enum.is_a?(Enumerator)

          # rubocop:disable Lint/UnreachableLoop
          enum.rewind.each { break }
          # rubocop:enable Lint/UnreachableLoop
        end

        # @api private
        #
        # @param enum [Enumerable<Object>, nil]
        # @param blk [Proc]
        #
        # @yieldparam [Enumerator::Yielder]
        # @return [Enumerable<Object>]
        def chain_fused(enum, &blk)
          iter = Enumerator.new { blk.call(_1) }
          fused_enum(iter) { close_fused!(enum) }
        end
      end

      class << self
        # @api private
        #
        # Assumes Strings have been forced into having `Encoding::BINARY`.
        #
        # This decoder is responsible for reassembling lines split across multiple
        # fragments.
        #
        # @param enum [Enumerable<String>]
        #
        # @return [Enumerable<String>]
        def decode_lines(enum)
          re = /(\r\n|\r|\n)/
          buffer = String.new
          cr_seen = nil

          chain_fused(enum) do |y|
            enum.each do |row|
              offset = buffer.bytesize
              buffer << row
              while (match = re.match(buffer, cr_seen&.to_i || offset))
                case [match.captures.first, cr_seen]
                in ["\r", nil]
                  cr_seen = match.end(1)
                  next
                in ["\r" | "\r\n", Integer]
                  y << buffer.slice!(..(cr_seen.pred))
                else
                  y << buffer.slice!(..(match.end(1).pred))
                end
                offset = 0
                cr_seen = nil
              end
            end

            y << buffer.slice!(..(cr_seen.pred)) unless cr_seen.nil?
            y << buffer unless buffer.empty?
          end
        end

        # @api private
        #
        # https://html.spec.whatwg.org/multipage/server-sent-events.html#parsing-an-event-stream
        #
        # Assumes that `lines` has been decoded with `#decode_lines`.
        #
        # @param lines [Enumerable<String>]
        #
        # @return [Enumerable<Hash{Symbol=>Object}>]
        def decode_sse(lines)
          # rubocop:disable Metrics/BlockLength
          chain_fused(lines) do |y|
            blank = {event: nil, data: nil, id: nil, retry: nil}
            current = {}

            lines.each do |line|
              case line.sub(/\R$/, "")
              in ""
                next if current.empty?
                y << {**blank, **current}
                current = {}
              in /^:/
                next
              in /^([^:]+):\s?(.*)$/
                field, value = Regexp.last_match.captures
                case field
                in "event"
                  current.merge!(event: value)
                in "data"
                  (current[:data] ||= String.new) << (value << "\n")
                in "id" unless value.include?("\0")
                  current.merge!(id: value)
                in "retry" if /^\d+$/ =~ value
                  current.merge!(retry: Integer(value))
                else
                end
              else
              end
            end
            # rubocop:enable Metrics/BlockLength

            y << {**blank, **current} unless current.empty?
          end
        end
      end

      # @api private
      module SorbetRuntimeSupport
        class MissingSorbetRuntimeError < ::RuntimeError
        end

        # @api private
        #
        # @return [Hash{Symbol=>Object}]
        private def sorbet_runtime_constants = @sorbet_runtime_constants ||= {}

        # @api private
        #
        # @param name [Symbol]
        def const_missing(name)
          super unless sorbet_runtime_constants.key?(name)

          unless Object.const_defined?(:T)
            message = "Trying to access a Sorbet constant #{name.inspect} without `sorbet-runtime`."
            raise MissingSorbetRuntimeError.new(message)
          end

          sorbet_runtime_constants.fetch(name).call
        end

        # @api private
        #
        # @param name [Symbol]
        #
        # @return [Boolean]
        def sorbet_constant_defined?(name) = sorbet_runtime_constants.key?(name)

        # @api private
        #
        # @param name [Symbol]
        # @param blk [Proc]
        def define_sorbet_constant!(name, &blk) = sorbet_runtime_constants.store(name, blk)

        # @api private
        #
        # @return [Object]
        def to_sorbet_type = raise NotImplementedError

        class << self
          # @api private
          #
          # @param type [OpenAI::Internal::Util::SorbetRuntimeSupport, Object]
          #
          # @return [Object]
          def to_sorbet_type(type)
            case type
            in OpenAI::Internal::Util::SorbetRuntimeSupport
              type.to_sorbet_type
            in Class | Module
              type
            in true | false
              T::Boolean
            else
              type.class
            end
          end
        end
      end

      extend OpenAI::Internal::Util::SorbetRuntimeSupport

      define_sorbet_constant!(:ParsedUri) do
        T.type_alias do
          {
            scheme: T.nilable(String),
            host: T.nilable(String),
            port: T.nilable(Integer),
            path: T.nilable(String),
            query: T::Hash[String, T::Array[String]]
          }
        end
      end

      define_sorbet_constant!(:ServerSentEvent) do
        T.type_alias do
          {
            event: T.nilable(String),
            data: T.nilable(String),
            id: T.nilable(String),
            retry: T.nilable(Integer)
          }
        end
      end
    end
  end
end
