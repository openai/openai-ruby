# frozen_string_literal: true

module OpenAI
  class FilePart
    # @return [Pathname, StringIO, IO, String]
    attr_reader :content

    # @return [String, nil]
    attr_reader :content_type

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
    def initialize(content, filename: nil, content_type: nil)
      @content_type = content_type
      @filename =
        case [filename, (@content = content)]
        in [String | Pathname, _]
          ::File.basename(filename)
        in [nil, Pathname]
          content.basename.to_path
        in [nil, IO]
          content.to_path
        else
          filename
        end
    end
  end
end
