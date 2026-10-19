# typed: strong

module OpenAI
  module Models

    class DecisionPromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionPromptCacheBreakpoint,
          OpenAI::Internal::AnyHash
        )
      end

      # The breakpoint mode. Always `explicit`.
      sig { returns(Symbol) }
      attr_accessor :mode

      # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      # token block.
      sig do
        params(

          mode: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        # The breakpoint mode. Always `explicit`.

        mode: :explicit
      )
      end

      sig do
        override.returns(
          {mode: Symbol}
        )
      end
      def to_hash
      end

    end

  end
end
