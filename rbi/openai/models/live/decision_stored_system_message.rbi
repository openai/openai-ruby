# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionStoredSystemMessage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionStoredSystemMessage,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :id

        # The text input to the model.
        sig { returns(OpenAI::Live::DecisionStoredSystemMessage::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        sig { returns(T.nilable(OpenAI::Live::DecisionStoredSystemMessage::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Live::DecisionStoredSystemMessage::Type::OrSymbol).void }
        attr_writer :type

        sig do
          params(

            id: String,

            content: OpenAI::Live::DecisionStoredSystemMessage::Content::Variants,

            type: OpenAI::Live::DecisionStoredSystemMessage::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          id:,

          # The text input to the model.
          content:,

          type: nil,

          role: :system
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content: OpenAI::Live::DecisionStoredSystemMessage::Content::Variants,
              role: Symbol,
              type: OpenAI::Live::DecisionStoredSystemMessage::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # The text input to the model.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::Live::DecisionInputText]) }

          sig { override.returns(T::Array[OpenAI::Live::DecisionStoredSystemMessage::Content::Variants]) }
          def self.variants
          end

          DecisionInputTextArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionInputText],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionStoredSystemMessage::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::Live::DecisionStoredSystemMessage::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::DecisionStoredSystemMessage::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
