# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionDeveloperMessage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionDeveloperMessage,
            OpenAI::Internal::AnyHash
          )
        end

        # The text input to the model.
        sig { returns(OpenAI::Live::DecisionDeveloperMessage::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        # The unique ID of this message item.
        sig { returns(T.nilable(String)) }
        attr_accessor :id

        sig { returns(T.nilable(OpenAI::Live::DecisionDeveloperMessage::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Live::DecisionDeveloperMessage::Type::OrSymbol).void }
        attr_writer :type

        sig do
          params(

            content: OpenAI::Live::DecisionDeveloperMessage::Content::Variants,

            id: T.nilable(String),

            type: OpenAI::Live::DecisionDeveloperMessage::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The text input to the model.
          content:,

          # The unique ID of this message item.
          id: nil,

          type: nil,

          role: :developer
        )
        end

        sig do
          override.returns(
            {
              content: OpenAI::Live::DecisionDeveloperMessage::Content::Variants,
              role: Symbol,
              id: T.nilable(String),
              type: OpenAI::Live::DecisionDeveloperMessage::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # The text input to the model.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::Live::DecisionInputText]) }

          sig { override.returns(T::Array[OpenAI::Live::DecisionDeveloperMessage::Content::Variants]) }
          def self.variants
          end

          DecisionInputTextArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionInputText],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionDeveloperMessage::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::Live::DecisionDeveloperMessage::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::DecisionDeveloperMessage::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
