# typed: strong

module OpenAI
  class FilePart
    # @api private
    sig { params(content_type: T.nilable(String)).returns(T.nilable(String)) }
    def self.validate_content_type(content_type)
    end

    sig { returns(T.any(Pathname, StringIO, IO, String)) }
    attr_reader :content

    sig { returns(T.nilable(String)) }
    attr_reader :content_type

    sig { returns(T.nilable(String)) }
    attr_reader :filename

    # @api private
    sig do
      params(content: T.any(Pathname, StringIO, IO, String)).returns(
        OpenAI::FilePart
      )
    end
    def with_content(content)
    end

    sig do
      params(content: T.any(Pathname, StringIO, IO, String)).returns(
        T.any(Pathname, StringIO, IO, String)
      )
    end
    protected def content=(content)
    end

    sig { params(content_type: T.nilable(String)).returns(T.nilable(String)) }
    protected def content_type=(content_type)
    end

    # @api private
    sig { returns(String) }
    private def default_content_type
    end

    # @api private
    sig { returns(String) }
    private def read
    end

    sig { params(a: T.anything).returns(String) }
    def to_json(*a)
    end

    sig { params(a: T.anything).returns(String) }
    def to_yaml(*a)
    end

    sig do
      params(
        content: T.any(Pathname, StringIO, IO, String),
        filename: T.nilable(T.any(Pathname, String)),
        content_type: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.new(content, filename: nil, content_type: nil)
    end

    # @api private
    sig { params(filename: T.any(Pathname, String)).returns(String) }
    private def strip_directories(filename)
    end
  end
end
