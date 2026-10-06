# typed: strong

module OpenAI
  module Models

    class DecisionInputMessage < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionInputMessage,
          OpenAI::Internal::AnyHash
        )
      end

      # Text evidence or an ordered list of text and inline image parts.
      sig { returns(OpenAI::DecisionInputMessage::Content::Variants) }
      attr_accessor :content

      sig { returns(Symbol) }
      attr_accessor :role

      sig { returns(T.nilable(OpenAI::DecisionInputMessage::Type::OrSymbol)) }
      attr_reader :type

      sig { params(type: OpenAI::DecisionInputMessage::Type::OrSymbol).void }
      attr_writer :type

      # A user message containing text or inline images.
      sig do
        params(

          content: OpenAI::DecisionInputMessage::Content::Variants,

          type: OpenAI::DecisionInputMessage::Type::OrSymbol,

          role: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        # Text evidence or an ordered list of text and inline image parts.
        content:,

        type: nil,

        role: :user
      )
      end

      sig do
        override.returns(
          {
            content: OpenAI::DecisionInputMessage::Content::Variants,
            role: Symbol,
            type: OpenAI::DecisionInputMessage::Type::OrSymbol
          }
        )
      end
      def to_hash
      end

      # Text evidence or an ordered list of text and inline image parts.
      module Content
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputPart::Variants]) }

        sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Content::Variants]) }
        def self.variants
        end

        DecisionInputPartArray = T.let(
          OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionInputPart],
          OpenAI::Internal::Type::Converter
        )

      end

      module Type
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessage::Type) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        MESSAGE = T.let(:message, OpenAI::DecisionInputMessage::Type::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Type::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end
