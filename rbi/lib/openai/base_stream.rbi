# typed: strong

module OpenAI
  class BaseStream
    Elem = type_member(:out)

    sig do
      params(
        model: T.any(T::Class[T.anything], OpenAI::Converter),
        url: URI::Generic,
        status: Integer,
        response: Net::HTTPResponse,
        messages: T::Enumerable[OpenAI::Util::SSEMessage]
      )
        .returns(T.attached_class)
    end
    def self.new(model:, url:, status:, response:, messages:)
    end

    sig { overridable.returns(T::Enumerable[Elem]) }
    private def iterator
    end

    sig { void }
    def close
    end

    sig { params(blk: T.proc.params(arg0: Elem).void).void }
    def for_each(&blk)
    end

    sig { returns(T::Enumerable[Elem]) }
    def to_enum
    end

    alias_method :enum_for, :to_enum
  end
end
