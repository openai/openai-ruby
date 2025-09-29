# frozen_string_literal: true

module OpenAI
  class FilePart
    # @return [Pathname, StringIO, IO, String]
    attr_reader :content

    # @return [String, nil]
    attr_reader :content_type

    # @return [String, nil]
    attr_reader :filename

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
