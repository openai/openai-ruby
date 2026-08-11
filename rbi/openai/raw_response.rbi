# typed: strong

module OpenAI
  class RawResponse
    Elem = type_member(:out)

    sig { returns(Integer) }
    attr_reader :status

    sig { returns(T::Hash[String, String]) }
    attr_reader :headers

    sig { returns(String) }
    attr_reader :body

    sig { returns(T.nilable(String)) }
    def request_id
    end

    sig { returns(String) }
    def read
    end

    sig { returns(Elem) }
    def parse
    end

    sig { returns(String) }
    def inspect
    end

    # @api private
    sig do
      params(
        status: Integer,
        headers: T::Hash[String, String],
        body: String,
        parser: T.proc.returns(Elem)
      ).void
    end
    def initialize(status:, headers:, body:, parser:)
    end
  end
end
