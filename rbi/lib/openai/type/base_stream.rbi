# typed: strong

module OpenAI
  module Type
    module BaseStream
      include Enumerable

      Message = type_member(:in)
      Elem = type_member(:out)

      sig { void }
      def close
      end

      # @api private
      sig { overridable.returns(T::Enumerable[Elem]) }
      private def iterator
      end

      sig { params(blk: T.proc.params(arg0: Elem).void).void }
      def each(&blk)
      end

      sig { returns(T::Enumerator[Elem]) }
      def to_enum
      end

      # @api private
      sig do
        params(
          model: T.any(T::Class[T.anything], OpenAI::Type::Converter),
          url: URI::Generic,
          status: Integer,
          response: Net::HTTPResponse,
          stream: T::Enumerable[Message]
        )
          .void
      end
      def initialize(model:, url:, status:, response:, stream:)
      end
    end
  end
end
