# typed: strong

module OpenAI
  class Stream
    include OpenAI::BaseStream

    Message = type_member(:in) { {fixed: OpenAI::Util::SSEMessage} }
    Elem = type_member(:out)

    sig { override.returns(T::Enumerable[Elem]) }
    private def iterator
    end

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
  end
end
