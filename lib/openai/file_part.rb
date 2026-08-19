# frozen_string_literal: true

module OpenAI
  class FilePart
    # HTTP media types contain ASCII tokens and optional token or quoted-string parameters.
    # Quoted values may contain horizontal whitespace and non-ASCII header bytes, but
    # never CR, LF, NUL, other forbidden control bytes, or an unescaped quote.
    #
    # @api private
    # @type [Regexp]
    MEDIA_TYPE = %r{
      \A
      [!#$%&'*+\-.^_`|~0-9A-Za-z]+
      /
      [!#$%&'*+\-.^_`|~0-9A-Za-z]+
      (?:
        [\x20\t]*;[\x20\t]*
        [!#$%&'*+\-.^_`|~0-9A-Za-z]+
        [\x20\t]*=[\x20\t]*
        (?:
          [!#$%&'*+\-.^_`|~0-9A-Za-z]+
          |
          "(?:[\x20\t\x21\x23-\x5B\x5D-\x7E\x80-\xFF]|\\[\x20\t\x21-\x7E\x80-\xFF])*"
        )
      )*
      [\x20\t]*
      \z
    }nx
    private_constant :MEDIA_TYPE

    # @return [Pathname, StringIO, IO, String]
    attr_reader :content

    # @return [String, nil]
    # @raise [ArgumentError] if the content type is not a valid MIME media type
    def content_type
      return if @content_type.nil?
      return @content_type if @content_type.is_a?(String) && MEDIA_TYPE.match?(@content_type.b)

      raise ArgumentError, "`content_type` must be a valid MIME media type"
    end

    # @return [String, nil]
    attr_reader :filename

    # Return a copy with different content while preserving multipart behavior.
    #
    # @api private
    #
    # @param content [Pathname, StringIO, IO, String]
    # @return [OpenAI::FilePart]
    def with_content(content)
      dup.tap do |copy|
        copy.content = content
        copy.content_type = content_type || default_content_type
      end
    end

    protected(attr_writer(:content, :content_type))

    # @api private
    #
    # @return [String]
    private def default_content_type
      content.is_a?(String) ? "text/plain" : "application/octet-stream"
    end

    # @api private
    #
    # @return [String]
    private def read
      case content
      in Pathname
        content.read(binmode: true)
      in StringIO
        content.string
      in IO
        content.read
      in String
        content
      end
    end

    # @param a [Object]
    #
    # @return [String]
    def to_json(*a) = read.to_json(*a)

    # @param a [Object]
    #
    # @return [String]
    def to_yaml(*a) = read.to_yaml(*a)

    # @param content [Pathname, StringIO, IO, String]
    # @param filename [Pathname, String, nil]
    # @param content_type [String, nil]
    # @raise [ArgumentError] if the content type is not a valid MIME media type
    def initialize(content, filename: nil, content_type: nil)
      unless content_type.nil? || (content_type.is_a?(String) && MEDIA_TYPE.match?(content_type.b))
        raise ArgumentError, "`content_type` must be a valid MIME media type"
      end

      @content_type = content_type
      @filename = case [filename, (@content = content)]
      in [String | Pathname, _]
        ::File.basename(filename)
      in [nil, Pathname]
        content.basename.to_path
      in [nil, IO]
        content.to_path&.then { ::File.basename(_1) }
      else
        filename
      end
    end
  end
end
