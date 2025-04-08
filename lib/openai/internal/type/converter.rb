# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      module Converter
        # rubocop:disable Lint/UnusedMethodArgument

        # @api private
        #
        # @param value [Object]
        #
        # @param state [Hash{Symbol=>Object}] .
        #
        #   @option state [Boolean, :strong] :strictness
        #
        #   @option state [Hash{Symbol=>Object}] :exactness
        #
        #   @option state [Integer] :branched
        #
        # @return [Object]
        def coerce(value, state:) = (raise NotImplementedError)

        # @api private
        #
        # @param value [Object]
        #
        # @param state [Hash{Symbol=>Object}] .
        #
        #   @option state [Boolean] :can_retry
        #
        # @return [Object]
        def dump(value, state:)
          case value
          in Array
            value.map { OpenAI::Internal::Type::Unknown.dump(_1, state: state) }
          in Hash
            value.transform_values { OpenAI::Internal::Type::Unknown.dump(_1, state: state) }
          in OpenAI::Internal::Type::BaseModel
            value.class.dump(value, state: state)
          in StringIO
            value.string
          in Pathname | IO
            state[:can_retry] = false if value.is_a?(IO)
            OpenAI::Internal::Util::SerializationAdapter.new(value)
          else
            value
          end
        end

        # rubocop:enable Lint/UnusedMethodArgument

        class << self
          # @api private
          #
          # @param spec [Hash{Symbol=>Object}, Proc, OpenAI::Internal::Type::Converter, Class] .
          #
          #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
          #
          #   @option spec [Proc] :enum
          #
          #   @option spec [Proc] :union
          #
          #   @option spec [Boolean] :"nil?"
          #
          # @return [Proc]
          def type_info(spec)
            case spec
            in Proc
              spec
            in Hash
              type_info(spec.slice(:const, :enum, :union).first&.last)
            in true | false
              -> { OpenAI::Internal::Type::Boolean }
            in OpenAI::Internal::Type::Converter | Class | Symbol
              -> { spec }
            in NilClass | Integer | Float
              -> { spec.class }
            end
          end

          # @api private
          #
          # Based on `target`, transform `value` into `target`, to the extent possible:
          #
          # 1. if the given `value` conforms to `target` already, return the given `value`
          # 2. if it's possible and safe to convert the given `value` to `target`, then the
          #    converted value
          # 3. otherwise, the given `value` unaltered
          #
          # The coercion process is subject to improvement between minor release versions.
          # See https://docs.pydantic.dev/latest/concepts/unions/#smart-mode
          #
          # @param target [OpenAI::Internal::Type::Converter, Class]
          #
          # @param value [Object]
          #
          # @param state [Hash{Symbol=>Object}] The `strictness` is one of `true`, `false`, or `:strong`. This informs the
          # coercion strategy when we have to decide between multiple possible conversion
          # targets:
          #
          # - `true`: the conversion must be exact, with minimum coercion.
          # - `false`: the conversion can be approximate, with some coercion.
          # - `:strong`: the conversion must be exact, with no coercion, and raise an error
          #   if not possible.
          #
          # The `exactness` is `Hash` with keys being one of `yes`, `no`, or `maybe`. For
          # any given conversion attempt, the exactness will be updated based on how closely
          # the value recursively matches the target type:
          #
          # - `yes`: the value can be converted to the target type with minimum coercion.
          # - `maybe`: the value can be converted to the target type with some reasonable
          #   coercion.
          # - `no`: the value cannot be converted to the target type.
          #
          # See implementation below for more details.
          #
          #   @option state [Boolean, :strong] :strictness
          #
          #   @option state [Hash{Symbol=>Object}] :exactness
          #
          #   @option state [Integer] :branched
          #
          # @return [Object]
          def coerce(
            target,
            value,
            state: {strictness: true, exactness: {yes: 0, no: 0, maybe: 0}, branched: 0}
          )
            # rubocop:disable Lint/SuppressedException
            # rubocop:disable Metrics/BlockNesting
            strictness, exactness = state.fetch_values(:strictness, :exactness)

            case target
            in OpenAI::Internal::Type::Converter
              return target.coerce(value, state: state)
            in Class
              if value.is_a?(target)
                exactness[:yes] += 1
                return value
              end

              case target
              in -> { _1 <= NilClass }
                exactness[value.nil? ? :yes : :maybe] += 1
                return nil
              in -> { _1 <= Integer }
                if value.is_a?(Integer)
                  exactness[:yes] += 1
                  return value
                elsif strictness == :strong && Integer(value, exception: false) != value
                  message = "no implicit conversion of #{value.class} into #{target.inspect}"
                  raise value.is_a?(Numeric) ? ArgumentError.new(message) : TypeError.new(message)
                else
                  Kernel.then do
                    return Integer(value).tap { exactness[:maybe] += 1 }
                  rescue ArgumentError, TypeError
                  end
                end
              in -> { _1 <= Float }
                if value.is_a?(Numeric)
                  exactness[:yes] += 1
                  return Float(value)
                elsif strictness == :strong
                  message = "no implicit conversion of #{value.class} into #{target.inspect}"
                  raise TypeError.new(message)
                else
                  Kernel.then do
                    return Float(value).tap { exactness[:maybe] += 1 }
                  rescue ArgumentError, TypeError
                  end
                end
              in -> { _1 <= String }
                case value
                in String | Symbol | Numeric
                  exactness[value.is_a?(Numeric) ? :maybe : :yes] += 1
                  return value.to_s
                in StringIO
                  exactness[:yes] += 1
                  return value.string
                else
                  if strictness == :strong
                    message = "no implicit conversion of #{value.class} into #{target.inspect}"
                    raise TypeError.new(message)
                  end
                end
              in -> { _1 <= Date || _1 <= Time }
                Kernel.then do
                  return target.parse(value).tap { exactness[:yes] += 1 }
                rescue ArgumentError, TypeError => e
                  raise e if strictness == :strong
                end
              in -> { _1 <= StringIO } if value.is_a?(String)
                exactness[:yes] += 1
                return StringIO.new(value.b)
              else
              end
            in Symbol
              case value
              in Symbol | String
                if value.to_sym == target
                  exactness[:yes] += 1
                  return target
                else
                  exactness[:maybe] += 1
                  return value
                end
              else
                if strictness == :strong
                  message = "cannot convert non-matching #{value.class} into #{target.inspect}"
                  raise ArgumentError.new(message)
                end
              end
            else
            end

            exactness[:no] += 1
            value
            # rubocop:enable Metrics/BlockNesting
            # rubocop:enable Lint/SuppressedException
          end

          # @api private
          #
          # @param target [OpenAI::Internal::Type::Converter, Class]
          #
          # @param value [Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean] :can_retry
          #
          # @return [Object]
          def dump(target, value, state: {can_retry: true})
            case target
            in OpenAI::Internal::Type::Converter
              target.dump(value, state: state)
            else
              OpenAI::Internal::Type::Unknown.dump(value, state: state)
            end
          end
        end
      end
    end
  end
end
