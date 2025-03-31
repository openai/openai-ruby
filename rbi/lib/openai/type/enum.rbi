# typed: strong

module OpenAI
  module Type
    # @api private
    #
    # A value from among a specified list of options. OpenAPI enum values map to Ruby
    #   values in the SDK as follows:
    #
    #   1. boolean => true | false
    #   2. integer => Integer
    #   3. float => Float
    #   4. string => Symbol
    #
    #   We can therefore convert string values to Symbols, but can't convert other
    #   values safely.
    module Enum
      include OpenAI::Type::Converter

      # All of the valid Symbol values for this enum.
      sig { overridable.returns(T::Array[T.any(NilClass, T::Boolean, Integer, Float, Symbol)]) }
      def values
      end

      # @api private
      #
      # Guard against thread safety issues by instantiating `@values`.
      sig { void }
      private def finalize!
      end

      sig { params(other: T.anything).returns(T::Boolean) }
      def ===(other)
      end

      sig { params(other: T.anything).returns(T::Boolean) }
      def ==(other)
      end

      # @api private
      #
      # Unlike with primitives, `Enum` additionally validates that the value is a member
      #   of the enum.
      sig do
        override
          .params(value: T.any(String, Symbol, T.anything), state: OpenAI::Type::Converter::State)
          .returns(T.any(Symbol, T.anything))
      end
      def coerce(value, state:)
      end

      # @api private
      sig { override.params(value: T.any(Symbol, T.anything)).returns(T.any(Symbol, T.anything)) }
      def dump(value)
      end
    end
  end
end
