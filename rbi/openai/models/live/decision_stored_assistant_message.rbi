# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionStoredAssistantMessage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionStoredAssistantMessage,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :id

        # The text input to the model.
        sig { returns(OpenAI::Live::DecisionStoredAssistantMessage::Content::Variants) }
        attr_accessor :content

        sig { returns(Symbol) }
        attr_accessor :role

        # Labels an `assistant` message as intermediate commentary (`commentary`) or the
        # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        # sending follow-up requests, preserve and resend phase on all assistant messages
        # — dropping it can degrade performance. Not used for user messages.
        sig { returns(T.nilable(OpenAI::Live::DecisionStoredAssistantMessage::Phase::OrSymbol)) }
        attr_accessor :phase

        sig { returns(T.nilable(OpenAI::Live::DecisionStoredAssistantMessage::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Live::DecisionStoredAssistantMessage::Type::OrSymbol).void }
        attr_writer :type

        sig do
          params(

            id: String,

            content: OpenAI::Live::DecisionStoredAssistantMessage::Content::Variants,

            phase: T.nilable(OpenAI::Live::DecisionStoredAssistantMessage::Phase::OrSymbol),

            type: OpenAI::Live::DecisionStoredAssistantMessage::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          id:,

          # The text input to the model.
          content:,

          # Labels an `assistant` message as intermediate commentary (`commentary`) or the
          # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
          # sending follow-up requests, preserve and resend phase on all assistant messages
          # — dropping it can degrade performance. Not used for user messages.
          phase: nil,

          type: nil,

          role: :assistant
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content: OpenAI::Live::DecisionStoredAssistantMessage::Content::Variants,
              role: Symbol,
              phase: T.nilable(OpenAI::Live::DecisionStoredAssistantMessage::Phase::OrSymbol),
              type: OpenAI::Live::DecisionStoredAssistantMessage::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # The text input to the model.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(String, T::Array[OpenAI::Live::DecisionStoredAssistantMessage::Content::Part::Variants])
          }

          module Part
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Live::DecisionStoredAssistantMessage::Content::Part::OutputText,
                OpenAI::Live::DecisionStoredAssistantMessage::Content::Part::Refusal
              )
            }

            class OutputText < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionStoredAssistantMessage::Content::Part::OutputText,
                  OpenAI::Internal::AnyHash
                )
              end

              # The text content.
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

                # The text content.
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
                  OpenAI::Live::DecisionStoredAssistantMessage::Content::Part::Refusal,
                  OpenAI::Internal::AnyHash
                )
              end

              # The refusal text.
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

                # The refusal text.
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

            sig { override.returns(T::Array[OpenAI::Live::DecisionStoredAssistantMessage::Content::Part::Variants]) }
            def self.variants
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::DecisionStoredAssistantMessage::Content::Variants]) }
          def self.variants
          end

          PartsArray = T.let(
            OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionStoredAssistantMessage::Content::Part],
            OpenAI::Internal::Type::Converter
          )

        end

        # Labels an `assistant` message as intermediate commentary (`commentary`) or the
        # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        # sending follow-up requests, preserve and resend phase on all assistant messages
        # — dropping it can degrade performance. Not used for user messages.
        module Phase
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionStoredAssistantMessage::Phase) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMMENTARY = T.let(:commentary, OpenAI::Live::DecisionStoredAssistantMessage::Phase::TaggedSymbol)
          FINAL_ANSWER = T.let(:final_answer, OpenAI::Live::DecisionStoredAssistantMessage::Phase::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::DecisionStoredAssistantMessage::Phase::TaggedSymbol]) }
          def self.values
          end
        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionStoredAssistantMessage::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::Live::DecisionStoredAssistantMessage::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::DecisionStoredAssistantMessage::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
