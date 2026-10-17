# typed: strong

module OpenAI
  module Models

    class DecisionInputImage < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionInputImage,
          OpenAI::Internal::AnyHash
        )
      end

      # A base64-encoded image in a data URL or a publicly accessible HTTP(S) image URL.
      sig { returns(String) }
      attr_accessor :image_url

      sig { returns(Symbol) }
      attr_accessor :type

      # The image detail level, using the selected model's image profile. Defaults to
      # auto.
      sig { returns(T.nilable(OpenAI::DecisionInputImage::Detail::OrSymbol)) }
      attr_accessor :detail

      # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
      # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
      # token block.
      sig { returns(T.nilable(OpenAI::DecisionPromptCacheBreakpoint::OrHash)) }
      attr_reader :prompt_cache_breakpoint

      sig { params(prompt_cache_breakpoint: T.nilable(OpenAI::DecisionPromptCacheBreakpoint::OrHash)).void }
      attr_writer :prompt_cache_breakpoint

      # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
      # File IDs are not supported.
      sig do
        params(

          image_url: String,

          detail: T.nilable(OpenAI::DecisionInputImage::Detail::OrSymbol),

          prompt_cache_breakpoint: T.nilable(OpenAI::DecisionPromptCacheBreakpoint::OrHash),

          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        # A base64-encoded image in a data URL or a publicly accessible HTTP(S) image URL.
        image_url:,

        # The image detail level, using the selected model's image profile. Defaults to
        # auto.
        detail: nil,

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        prompt_cache_breakpoint: nil,

        type: :input_image
      )
      end

      sig do
        override.returns(
          {
            image_url: String,
            type: Symbol,
            detail: T.nilable(OpenAI::DecisionInputImage::Detail::OrSymbol),
            prompt_cache_breakpoint: T.nilable(OpenAI::DecisionPromptCacheBreakpoint::OrHash)
          }
        )
      end
      def to_hash
      end

      # The image detail level, using the selected model's image profile. Defaults to
      # auto.
      module Detail
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputImage::Detail) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW = T.let(:low, OpenAI::DecisionInputImage::Detail::TaggedSymbol)
        HIGH = T.let(:high, OpenAI::DecisionInputImage::Detail::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::DecisionInputImage::Detail::TaggedSymbol)
        ORIGINAL = T.let(:original, OpenAI::DecisionInputImage::Detail::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::DecisionInputImage::Detail::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end
