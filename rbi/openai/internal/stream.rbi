# typed: strong

module OpenAI
  module Internal
    class Stream
      Message =
        type_member(:in) { { fixed: OpenAI::Internal::Util::ServerSentEvent } }
      Elem = type_member(:out)

      include OpenAI::Internal::Type::BaseStream

      # @api private
      sig { override.returns(T::Enumerable[Elem]) }
      private def iterator
      end
    end
  end
end
