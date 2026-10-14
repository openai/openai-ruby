# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionInputMessageParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionInputMessageParam,
            OpenAI::Internal::AnyHash
          )
        end

        # The content of the message.
        sig {
          returns(
            T::Array[T.any(OpenAI::Beta::InputContentParam::InputText, OpenAI::Beta::InputContentParam::InputImage)]
          )
        }
        attr_accessor :content

        # The role of the message author. Always `user`.
        sig { returns(Symbol) }
        attr_accessor :role

        # The type of the input item. Always `message`.
        sig { returns(T.nilable(OpenAI::Beta::AgentSessionInputMessageParam::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Beta::AgentSessionInputMessageParam::Type::OrSymbol).void }
        attr_writer :type

        # A user message submitted to a session.
        sig do
          params(

            content: T::Array[
              T.any(
                OpenAI::Beta::InputContentParam::InputText::OrHash,
                OpenAI::Beta::InputContentParam::InputImage::OrHash
              )
            ],

            type: OpenAI::Beta::AgentSessionInputMessageParam::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The content of the message.
          content:,

          # The type of the input item. Always `message`.
          type: nil,

          # The role of the message author. Always `user`.

          role: :user
        )
        end

        sig do
          override.returns(
            {
              content: T::Array[
                T.any(OpenAI::Beta::InputContentParam::InputText, OpenAI::Beta::InputContentParam::InputImage)
              ],
              role: Symbol,
              type: OpenAI::Beta::AgentSessionInputMessageParam::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # The type of the input item. Always `message`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentSessionInputMessageParam::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::Beta::AgentSessionInputMessageParam::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentSessionInputMessageParam::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
