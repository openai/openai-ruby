# typed: strong

module OpenAI
  module Models

    class DecisionInputText < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionInputText,
          OpenAI::Internal::AnyHash
        )
      end

      sig { returns(String) }
      attr_accessor :text

      sig { returns(Symbol) }
      attr_accessor :type

      # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      # token block.
      sig { returns(T.nilable(OpenAI::DecisionPromptCacheBreakpoint)) }
      attr_reader :prompt_cache_breakpoint

      sig { params(prompt_cache_breakpoint: T.nilable(OpenAI::DecisionPromptCacheBreakpoint::OrHash)).void }
      attr_writer :prompt_cache_breakpoint

      sig do
        params(

          text: String,

          prompt_cache_breakpoint: T.nilable(OpenAI::DecisionPromptCacheBreakpoint::OrHash),

          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        text:,

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        prompt_cache_breakpoint: nil,

        type: :input_text
      )
      end

      sig do
        override.returns(
          {text: String, type: Symbol, prompt_cache_breakpoint: T.nilable(OpenAI::DecisionPromptCacheBreakpoint)}
        )
      end
      def to_hash
      end

    end

  end
end
