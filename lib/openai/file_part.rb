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
    # @param filename [String, nil]
    # @param content_type [String, nil]
    def initialize(content, filename: nil, content_type: nil)
      @content = content
      @filename =
        case content
        in Pathname
          filename.nil? ? content.basename.to_path : ::File.basename(filename)
        else
          filename.nil? ? nil : ::File.basename(filename)
        end
      @content_type = content_type
    end
  end
end
