# typed: strong

module OpenAI
  module Type
    # @api private
    #
    # Array of items of a given type.
    class ArrayOf
      include OpenAI::Type::Converter

      abstract!
      final!

      sig(:final) do
        params(
          type_info: T.any(
            OpenAI::Util::AnyHash,
            T.proc.returns(OpenAI::Type::Converter::Input),
            OpenAI::Type::Converter::Input
          ),
          spec: OpenAI::Util::AnyHash
        )
          .returns(T.attached_class)
      end
      def self.[](type_info, spec = {})
      end

      sig(:final) { params(other: T.anything).returns(T::Boolean) }
      def ===(other)
      end

      sig(:final) { params(other: T.anything).returns(T::Boolean) }
      def ==(other)
      end

      # @api private
      sig(:final) do
        override
          .params(value: T.any(T::Enumerable[T.anything], T.anything), state: OpenAI::Type::Converter::State)
          .returns(T.any(T::Array[T.anything], T.anything))
      end
      def coerce(value, state:)
      end

      # @api private
      sig(:final) do
        override
          .params(value: T.any(T::Enumerable[T.anything], T.anything))
          .returns(T.any(T::Array[T.anything], T.anything))
      end
      def dump(value)
      end

      # @api private
      sig(:final) { returns(T.anything) }
      protected def item_type
      end

      # @api private
      sig(:final) { returns(T::Boolean) }
      protected def nilable?
      end

      # @api private
      sig(:final) do
        params(
          type_info: T.any(
            OpenAI::Util::AnyHash,
            T.proc.returns(OpenAI::Type::Converter::Input),
            OpenAI::Type::Converter::Input
          ),
          spec: OpenAI::Util::AnyHash
        )
          .void
      end
      def initialize(type_info, spec = {})
      end
    end
  end
end
