# typed: strong

module OpenAI
  module Models

    class DecisionQuestionInputImage < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionQuestionInputImage,
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
      sig { returns(T.nilable(OpenAI::DecisionQuestionInputImage::Detail::OrSymbol)) }
      attr_accessor :detail

      # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
      # File IDs are not supported.
      sig do
        params(

          image_url: String,

          detail: T.nilable(OpenAI::DecisionQuestionInputImage::Detail::OrSymbol),

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

        type: :input_image
      )
      end

      sig do
        override.returns(
          {image_url: String, type: Symbol, detail: T.nilable(OpenAI::DecisionQuestionInputImage::Detail::OrSymbol)}
        )
      end
      def to_hash
      end

      # The image detail level, using the selected model's image profile. Defaults to
      # auto.
      module Detail
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionQuestionInputImage::Detail) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW = T.let(:low, OpenAI::DecisionQuestionInputImage::Detail::TaggedSymbol)
        HIGH = T.let(:high, OpenAI::DecisionQuestionInputImage::Detail::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::DecisionQuestionInputImage::Detail::TaggedSymbol)
        ORIGINAL = T.let(:original, OpenAI::DecisionQuestionInputImage::Detail::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::DecisionQuestionInputImage::Detail::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end
