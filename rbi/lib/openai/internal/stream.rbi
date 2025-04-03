# typed: strong

module OpenAI
  module Internal
    class Stream
      include OpenAI::Internal::Type::BaseStream

      Message = type_member(:in) { {fixed: OpenAI::Internal::Util::ServerSentEvent} }
      Elem = type_member(:out)

      # @api private
      sig { override.returns(T::Enumerable[Elem]) }
      private def iterator
      end
    end
  end
end
