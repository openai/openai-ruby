# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionStoredDeveloperMessage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionStoredDeveloperMessage,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :id

        # The text input to the model.
        sig { returns(OpenAI::Live::DecisionStoredDeveloperMessage::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        sig { returns(T.nilable(OpenAI::Live::DecisionStoredDeveloperMessage::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Live::DecisionStoredDeveloperMessage::Type::OrSymbol).void }
        attr_writer :type

        sig do
          params(

            id: String,

            content: OpenAI::Live::DecisionStoredDeveloperMessage::Content::Variants,

            type: OpenAI::Live::DecisionStoredDeveloperMessage::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          id:,

          # The text input to the model.
          content:,

          type: nil,

          role: :developer
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content: OpenAI::Live::DecisionStoredDeveloperMessage::Content::Variants,
              role: Symbol,
              type: OpenAI::Live::DecisionStoredDeveloperMessage::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # The text input to the model.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::Live::DecisionInputText]) }

          sig { override.returns(T::Array[OpenAI::Live::DecisionStoredDeveloperMessage::Content::Variants]) }
          def self.variants
          end

          DecisionInputTextArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionInputText],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionStoredDeveloperMessage::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::Live::DecisionStoredDeveloperMessage::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::DecisionStoredDeveloperMessage::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
