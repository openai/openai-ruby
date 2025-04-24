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
      case contents
      in Pathname
        contents.read(binmode: true)
      in StringIO
        contents.string
      in IO
        contents.read
      in String
        contents
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
          filename.nil? ? content.basename.to_path : File.basename(filename)
        else
          filename.nil? ? nil : File.basename(filename)
        end
      @content_type = content_type
    end
  end
end
