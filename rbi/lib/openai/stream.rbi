# typed: strong

module OpenAI
  class Stream < OpenAI::BaseStream
    Elem = type_member(:out)

    sig { override.returns(T::Enumerable[Elem]) }
    private def iterator
    end
  end
end
