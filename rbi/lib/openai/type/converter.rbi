# typed: strong

module OpenAI
  module Type
    # @api private
    module Converter
      Input = T.type_alias { T.any(OpenAI::Type::Converter, T::Class[T.anything]) }

      State =
        T.type_alias do
          {
            strictness: T.any(T::Boolean, Symbol),
            exactness: {yes: Integer, no: Integer, maybe: Integer},
            branched: Integer
          }
        end

      # @api private
      sig { overridable.params(value: T.anything, state: OpenAI::Type::Converter::State).returns(T.anything) }
      def coerce(value, state:)
      end

      # @api private
      sig { overridable.params(value: T.anything).returns(T.anything) }
      def dump(value)
      end

      class << self
        # @api private
        sig do
          params(
            spec: T.any(
              {
                const: T.nilable(T.any(NilClass, T::Boolean, Integer, Float, Symbol)),
                enum: T.nilable(T.proc.returns(OpenAI::Type::Converter::Input)),
                union: T.nilable(T.proc.returns(OpenAI::Type::Converter::Input))
              },
              T.proc.returns(OpenAI::Type::Converter::Input),
              OpenAI::Type::Converter::Input
            )
          )
            .returns(T.proc.returns(T.anything))
        end
        def self.type_info(spec)
        end

        # @api private
        #
        # Based on `target`, transform `value` into `target`, to the extent possible:
        #
        #   1. if the given `value` conforms to `target` already, return the given `value`
        #   2. if it's possible and safe to convert the given `value` to `target`, then the
        #      converted value
        #   3. otherwise, the given `value` unaltered
        #
        #   The coercion process is subject to improvement between minor release versions.
        #   See https://docs.pydantic.dev/latest/concepts/unions/#smart-mode
        sig do
          params(
            target: OpenAI::Type::Converter::Input,
            value: T.anything,
            state: OpenAI::Type::Converter::State
          )
            .returns(T.anything)
        end
        def self.coerce(
          target,
          value,
          # The `strictness` is one of `true`, `false`, or `:strong`. This informs the
          #   coercion strategy when we have to decide between multiple possible conversion
          #   targets:
          #
          #   - `true`: the conversion must be exact, with minimum coercion.
          #   - `false`: the conversion can be approximate, with some coercion.
          #   - `:strong`: the conversion must be exact, with no coercion, and raise an error
          #     if not possible.
          #
          #   The `exactness` is `Hash` with keys being one of `yes`, `no`, or `maybe`. For
          #   any given conversion attempt, the exactness will be updated based on how closely
          #   the value recursively matches the target type:
          #
          #   - `yes`: the value can be converted to the target type with minimum coercion.
          #   - `maybe`: the value can be converted to the target type with some reasonable
          #     coercion.
          #   - `no`: the value cannot be converted to the target type.
          #
          #   See implementation below for more details.
          state: {strictness: true, exactness: {yes: 0, no: 0, maybe: 0}, branched: 0}
        )
        end

        # @api private
        sig { params(target: OpenAI::Type::Converter::Input, value: T.anything).returns(T.anything) }
        def self.dump(target, value)
        end
      end
    end
  end
end
