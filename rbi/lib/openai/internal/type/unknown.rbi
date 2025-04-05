# typed: strong

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # When we don't know what to expect for the value.
      class Unknown
        extend OpenAI::Internal::Type::Converter

        abstract!
        final!

        sig(:final) { params(other: T.anything).returns(T::Boolean) }
        def self.===(other); end

        sig(:final) { params(other: T.anything).returns(T::Boolean) }
        def self.==(other); end

        class << self
          # @api private
          sig(:final) do
            override.params(
              value: T.anything,
              state: OpenAI::Internal::Type::Converter::State
            ).returns(T.anything)
          end
          def coerce(value, state:); end

          # @api private
          sig(:final) { override.params(value: T.anything).returns(T.anything) }
          def dump(value); end
        end
      end
    end
  end
end
