# typed: strong

module OpenAI
  module Models

    # A user message containing input text, images, or JSON.
    module DecisionInputMessage
      extend OpenAI::Internal::Type::Union

      Variants = T.type_alias do
        T.any(
          OpenAI::DecisionInputMessage::User,
          OpenAI::DecisionInputMessage::Developer,
          OpenAI::DecisionInputMessage::System,
          OpenAI::DecisionInputMessage::Assistant
        )
      end

      class User < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionInputMessage::User,
            OpenAI::Internal::AnyHash
          )
        end

        # A text string or an ordered list of text, image, and JSON parts.
        sig { returns(OpenAI::DecisionInputMessage::User::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        sig { returns(T.nilable(OpenAI::DecisionInputMessage::User::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::DecisionInputMessage::User::Type::OrSymbol).void }
        attr_writer :type

        # A user message containing input text, images, or JSON.
        sig do
          params(

            content: OpenAI::DecisionInputMessage::User::Content::Variants,

            type: OpenAI::DecisionInputMessage::User::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A text string or an ordered list of text, image, and JSON parts.
          content:,

          type: nil,

          role: :user
        )
        end

        sig do
          override.returns(
            {
              content: OpenAI::DecisionInputMessage::User::Content::Variants,
              role: Symbol,
              type: OpenAI::DecisionInputMessage::User::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A text string or an ordered list of text, image, and JSON parts.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputPart::Variants]) }

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::User::Content::Variants]) }
          def self.variants
          end

          DecisionInputPartArray = T.let(
            OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionInputPart],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessage::User::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::DecisionInputMessage::User::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::User::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end

      class Developer < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionInputMessage::Developer,
            OpenAI::Internal::AnyHash
          )
        end

        # A text string or an ordered list of input text parts.
        sig { returns(OpenAI::DecisionInputMessage::Developer::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        sig { returns(T.nilable(OpenAI::DecisionInputMessage::Developer::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::DecisionInputMessage::Developer::Type::OrSymbol).void }
        attr_writer :type

        # A developer message containing input text.
        sig do
          params(

            content: OpenAI::DecisionInputMessage::Developer::Content::Variants,

            type: OpenAI::DecisionInputMessage::Developer::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A text string or an ordered list of input text parts.
          content:,

          type: nil,

          role: :developer
        )
        end

        sig do
          override.returns(
            {
              content: OpenAI::DecisionInputMessage::Developer::Content::Variants,
              role: Symbol,
              type: OpenAI::DecisionInputMessage::Developer::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A text string or an ordered list of input text parts.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputText]) }

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Developer::Content::Variants]) }
          def self.variants
          end

          DecisionInputTextArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputText],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessage::Developer::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::DecisionInputMessage::Developer::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Developer::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end

      class System < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionInputMessage::System,
            OpenAI::Internal::AnyHash
          )
        end

        # A text string or an ordered list of input text parts.
        sig { returns(OpenAI::DecisionInputMessage::System::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        sig { returns(T.nilable(OpenAI::DecisionInputMessage::System::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::DecisionInputMessage::System::Type::OrSymbol).void }
        attr_writer :type

        # A system message containing input text.
        sig do
          params(

            content: OpenAI::DecisionInputMessage::System::Content::Variants,

            type: OpenAI::DecisionInputMessage::System::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A text string or an ordered list of input text parts.
          content:,

          type: nil,

          role: :system
        )
        end

        sig do
          override.returns(
            {
              content: OpenAI::DecisionInputMessage::System::Content::Variants,
              role: Symbol,
              type: OpenAI::DecisionInputMessage::System::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A text string or an ordered list of input text parts.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputText]) }

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::System::Content::Variants]) }
          def self.variants
          end

          DecisionInputTextArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputText],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessage::System::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::DecisionInputMessage::System::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::System::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end

      class Assistant < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionInputMessage::Assistant,
            OpenAI::Internal::AnyHash
          )
        end

        # A text string or an ordered list of output text and refusal parts.
        sig { returns(OpenAI::DecisionInputMessage::Assistant::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        # The phase of an assistant message.
        sig { returns(T.nilable(OpenAI::DecisionInputMessage::Assistant::Phase::OrSymbol)) }
        attr_accessor :phase

        sig { returns(T.nilable(OpenAI::DecisionInputMessage::Assistant::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::DecisionInputMessage::Assistant::Type::OrSymbol).void }
        attr_writer :type

        # An assistant message containing output text or refusals.
        sig do
          params(

            content: OpenAI::DecisionInputMessage::Assistant::Content::Variants,

            phase: T.nilable(OpenAI::DecisionInputMessage::Assistant::Phase::OrSymbol),

            type: OpenAI::DecisionInputMessage::Assistant::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A text string or an ordered list of output text and refusal parts.
          content:,

          # The phase of an assistant message.
          phase: nil,

          type: nil,

          role: :assistant
        )
        end

        sig do
          override.returns(
            {
              content: OpenAI::DecisionInputMessage::Assistant::Content::Variants,
              role: Symbol,
              phase: T.nilable(OpenAI::DecisionInputMessage::Assistant::Phase::OrSymbol),
              type: OpenAI::DecisionInputMessage::Assistant::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A text string or an ordered list of output text and refusal parts.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(String, T::Array[OpenAI::DecisionInputMessage::Assistant::Content::Part::Variants])
          }

          module Part
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::DecisionInputMessage::Assistant::Content::Part::OutputText,
                OpenAI::DecisionInputMessage::Assistant::Content::Part::Refusal
              )
            }

            class OutputText < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::DecisionInputMessage::Assistant::Content::Part::OutputText,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(String) }
              attr_accessor :text

              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  text: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                text:,

                type: :output_text
              )
              end

              sig do
                override.returns(
                  {text: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            class Refusal < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::DecisionInputMessage::Assistant::Content::Part::Refusal,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(String) }
              attr_accessor :refusal

              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  refusal: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                refusal:,

                type: :refusal
              )
              end

              sig do
                override.returns(
                  {refusal: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Assistant::Content::Part::Variants]) }
            def self.variants
            end

          end

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Assistant::Content::Variants]) }
          def self.variants
          end

          PartsArray = T.let(
            OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionInputMessage::Assistant::Content::Part],
            OpenAI::Internal::Type::Converter
          )

        end

        # The phase of an assistant message.
        module Phase
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessage::Assistant::Phase) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMMENTARY = T.let(:commentary, OpenAI::DecisionInputMessage::Assistant::Phase::TaggedSymbol)
          FINAL_ANSWER = T.let(:final_answer, OpenAI::DecisionInputMessage::Assistant::Phase::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Assistant::Phase::TaggedSymbol]) }
          def self.values
          end
        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessage::Assistant::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::DecisionInputMessage::Assistant::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Assistant::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end

      sig { override.returns(T::Array[OpenAI::DecisionInputMessage::Variants]) }
      def self.variants
      end

    end

  end
end
