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

        class << self
          # Attempt to close the underlying transport when the stream itself is garbage
          # collected.
          #
          # This should not be relied upon for resource clean up, as the garbage collector
          # is not guaranteed to run.
          sig { params(stream: T::Enumerable[T.anything]).returns(T.proc.params(arg0: Integer).void) }
          def defer_closing(stream); end
        end

        sig { void }
        def close; end

        # @api private
        sig { overridable.returns(T::Enumerable[Elem]) }
        private def iterator; end

        sig { params(blk: T.proc.params(arg0: Elem).void).void }
        def each(&blk); end

        sig { returns(T::Enumerator[Elem]) }
        def to_enum; end

        # @api private
        sig do
          params(
            model: T.any(T::Class[T.anything], OpenAI::Internal::Type::Converter),
            url: URI::Generic,
            status: Integer,
            response: Net::HTTPResponse,
            stream: T::Enumerable[Message]
          )
            .void
        end
        def initialize(model:, url:, status:, response:, stream:); end

        # @api private
        sig { returns(String) }
        def inspect; end
      end
    end
  end
end
