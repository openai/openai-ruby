# typed: strong

module OpenAI
  module Internal
    # @api private
    module ClientOptions
      # @api private
      class ResolvedHeaders < Hash
        K = type_member { { fixed: String } }
        V = type_member { { fixed: T.nilable(String) } }
        Elem = type_member { { fixed: [String, T.nilable(String)] } }
      end

      class << self
        # @api private
        sig { params(options: T.untyped).returns(T::Hash[Symbol, T.untyped]) }
        def capture(**options)
        end

        # @api private
        sig do
          params(
            defaults: T::Hash[Symbol, T.untyped],
            overrides: T::Hash[Symbol, T.untyped]
          ).returns(T::Hash[Symbol, T.untyped])
        end
        def copy(defaults, overrides)
        end
      end
    end
  end
end
