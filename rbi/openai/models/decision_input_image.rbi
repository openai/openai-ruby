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

      # A base64-encoded image in a data URL.
      sig { returns(String) }
      attr_accessor :image_url

      sig { returns(Symbol) }
      attr_accessor :type

      # The image detail level, using the selected model's image profile. Defaults to
      # auto.
      sig { returns(T.nilable(OpenAI::DecisionInputImage::Detail::OrSymbol)) }
      attr_accessor :detail

      # An inline image. External URLs and file IDs are not supported.
      sig do
        params(

          image_url: String,

          detail: T.nilable(OpenAI::DecisionInputImage::Detail::OrSymbol),

          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        # A base64-encoded image in a data URL.
        image_url:,

        # The image detail level, using the selected model's image profile. Defaults to
        # auto.
        detail: nil,

        type: :input_image
      )
      end

      sig do
        override.returns(
          {image_url: String, type: Symbol, detail: T.nilable(OpenAI::DecisionInputImage::Detail::OrSymbol)}
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
