# typed: strong

module OpenAI
  module Models

    # A user message containing input text, images, or JSON.
    module DecisionInputMessageUnion
      extend OpenAI::Internal::Type::Union

      Variants = T.type_alias do
        T.any(
          OpenAI::DecisionInputMessage,
          OpenAI::DecisionInputMessageUnion::Developer,
          OpenAI::DecisionInputMessageUnion::System,
          OpenAI::DecisionInputMessageUnion::Assistant
        )
      end

      class Developer < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionInputMessageUnion::Developer,
            OpenAI::Internal::AnyHash
          )
        end

        # A text string or an ordered list of input text parts.
        sig { returns(OpenAI::DecisionInputMessageUnion::Developer::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        sig { returns(T.nilable(OpenAI::DecisionInputMessageUnion::Developer::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::DecisionInputMessageUnion::Developer::Type::OrSymbol).void }
        attr_writer :type

        # A developer message containing input text.
        sig do
          params(

            content: OpenAI::DecisionInputMessageUnion::Developer::Content::Variants,

            type: OpenAI::DecisionInputMessageUnion::Developer::Type::OrSymbol,

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
              content: OpenAI::DecisionInputMessageUnion::Developer::Content::Variants,
              role: Symbol,
              type: OpenAI::DecisionInputMessageUnion::Developer::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A text string or an ordered list of input text parts.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputText]) }

          sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::Developer::Content::Variants]) }
          def self.variants
          end

          DecisionInputTextArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputText],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessageUnion::Developer::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::DecisionInputMessageUnion::Developer::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::Developer::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end

      class System < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionInputMessageUnion::System,
            OpenAI::Internal::AnyHash
          )
        end

        # A text string or an ordered list of input text parts.
        sig { returns(OpenAI::DecisionInputMessageUnion::System::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        sig { returns(T.nilable(OpenAI::DecisionInputMessageUnion::System::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::DecisionInputMessageUnion::System::Type::OrSymbol).void }
        attr_writer :type

        # A system message containing input text.
        sig do
          params(

            content: OpenAI::DecisionInputMessageUnion::System::Content::Variants,

            type: OpenAI::DecisionInputMessageUnion::System::Type::OrSymbol,

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
              content: OpenAI::DecisionInputMessageUnion::System::Content::Variants,
              role: Symbol,
              type: OpenAI::DecisionInputMessageUnion::System::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A text string or an ordered list of input text parts.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputText]) }

          sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::System::Content::Variants]) }
          def self.variants
          end

          DecisionInputTextArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputText],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessageUnion::System::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::DecisionInputMessageUnion::System::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::System::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end

      class Assistant < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionInputMessageUnion::Assistant,
            OpenAI::Internal::AnyHash
          )
        end

        # A text string or an ordered list of output text and refusal parts.
        sig { returns(OpenAI::DecisionInputMessageUnion::Assistant::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        # The phase of an assistant message.
        sig { returns(T.nilable(OpenAI::DecisionInputMessageUnion::Assistant::Phase::OrSymbol)) }
        attr_accessor :phase

        sig { returns(T.nilable(OpenAI::DecisionInputMessageUnion::Assistant::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::DecisionInputMessageUnion::Assistant::Type::OrSymbol).void }
        attr_writer :type

        # An assistant message containing output text or refusals.
        sig do
          params(

            content: OpenAI::DecisionInputMessageUnion::Assistant::Content::Variants,

            phase: T.nilable(OpenAI::DecisionInputMessageUnion::Assistant::Phase::OrSymbol),

            type: OpenAI::DecisionInputMessageUnion::Assistant::Type::OrSymbol,

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
              content: OpenAI::DecisionInputMessageUnion::Assistant::Content::Variants,
              role: Symbol,
              phase: T.nilable(OpenAI::DecisionInputMessageUnion::Assistant::Phase::OrSymbol),
              type: OpenAI::DecisionInputMessageUnion::Assistant::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A text string or an ordered list of output text and refusal parts.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(String, T::Array[OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::Variants])
          }

          module Part
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::OutputText,
                OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::Refusal
              )
            }

            class OutputText < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::OutputText,
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
                  OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::Refusal,
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

            sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::Variants]) }
            def self.variants
            end

          end

          sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::Assistant::Content::Variants]) }
          def self.variants
          end

          PartsArray = T.let(
            OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionInputMessageUnion::Assistant::Content::Part],
            OpenAI::Internal::Type::Converter
          )

        end

        # The phase of an assistant message.
        module Phase
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessageUnion::Assistant::Phase) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMMENTARY = T.let(:commentary, OpenAI::DecisionInputMessageUnion::Assistant::Phase::TaggedSymbol)
          FINAL_ANSWER = T.let(:final_answer, OpenAI::DecisionInputMessageUnion::Assistant::Phase::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::Assistant::Phase::TaggedSymbol]) }
          def self.values
          end
        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionInputMessageUnion::Assistant::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::DecisionInputMessageUnion::Assistant::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::Assistant::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end

      sig { override.returns(T::Array[OpenAI::DecisionInputMessageUnion::Variants]) }
      def self.variants
      end

    end

  end
end
