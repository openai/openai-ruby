# typed: strong

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # This module provides a base implementation for streaming responses in the SDK.
      module BaseStream
        include Enumerable

        Message = type_member(:in)
        Elem = type_member(:out)

        sig { returns(Integer) }
        attr_reader :status

        sig { returns(T::Hash[String, String]) }
        attr_reader :headers

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
            model:
              T.any(T::Class[T.anything], OpenAI::Internal::Type::Converter),
            url: URI::Generic,
            status: Integer,
            headers: T::Hash[String, String],
            response: Net::HTTPResponse,
            unwrap:
              T.any(
                Symbol,
                Integer,
                T::Array[T.any(Symbol, Integer)],
                T.proc.params(arg0: T.anything).returns(T.anything)
              ),
            stream: T::Enumerable[Message]
          ).void
        end
        def initialize(
          model:,
          url:,
          status:,
          headers:,
          response:,
          unwrap:,
          stream:
        )
        end

        # @api private
        sig { returns(String) }
        def inspect
        end
      end
    end
  end
end
