# typed: strong

module OpenAI
  module Models
    BetaResponseContent = Beta::BetaResponseContent

    module Beta
      # Multi-modal input and output contents.
      module BetaResponseContent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInputText,
              OpenAI::Beta::BetaResponseInputImage,
              OpenAI::Beta::BetaResponseInputFile,
              OpenAI::Beta::BetaResponseOutputText,
              OpenAI::Beta::BetaResponseOutputRefusal,
              OpenAI::Beta::BetaResponseContent::ReasoningText
            )
          end

        class ReasoningText < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseContent::ReasoningText,
                OpenAI::Internal::AnyHash
              )
            end

          # The reasoning text from the model.
          sig { returns(String) }
          attr_accessor :text

          # The type of the reasoning text. Always `reasoning_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Reasoning text from the model.
          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(
            # The reasoning text from the model.
            text:,
            # The type of the reasoning text. Always `reasoning_text`.
            type: :reasoning_text
          )
          end

          sig { override.returns({ text: String, type: Symbol }) }
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Beta::BetaResponseContent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
