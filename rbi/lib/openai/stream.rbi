# typed: strong

module OpenAI
  class Stream
    include OpenAI::BaseStream

    Message = type_member(:in) { {fixed: OpenAI::Util::ServerSentEvent} }
    Elem = type_member(:out)

    # @api private
    sig { override.returns(T::Enumerable[Elem]) }
    private def iterator
    end
  end
end
