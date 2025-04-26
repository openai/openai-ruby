# typed: strong

module OpenAI
  class FilePart
    sig { returns(T.any(Pathname, StringIO, IO, String)) }
    attr_reader :content

    sig { returns(T.nilable(String)) }
    attr_reader :content_type

    sig { returns(T.nilable(String)) }
    attr_reader :filename

    # @api private
    sig { returns(String) }
    private def read; end

    sig { params(a: T.anything).returns(String) }
    def to_json(*a); end

    sig { params(a: T.anything).returns(String) }
    def to_yaml(*a); end

    sig do
      params(
        content: T.any(Pathname, StringIO, IO, String),
        filename: T.nilable(String),
        content_type: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.new(content, filename: nil, content_type: nil); end
  end
end
