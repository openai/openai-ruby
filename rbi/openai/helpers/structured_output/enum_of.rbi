# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      # @example
      #   example = OpenAI::EnumOf[:foo, :bar, :zoo]
      #
      # @example
      #   example = OpenAI::EnumOf[1, 2, 3]
      class EnumOf
        include OpenAI::Internal::Type::Enum
        include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        sig do
          params(
            values: T.any(NilClass, T::Boolean, Integer, Float, Symbol)
          ).returns(T.attached_class)
        end
        def self.[](*values)
        end

        sig do
          returns(T::Array[T.any(NilClass, T::Boolean, Integer, Float, Symbol)])
        end
        attr_reader :values
      end
    end
  end
end
