# typed: strong

module OpenAI
  module Models
    module Responses
      # Multi-modal input and output contents.
      module ResponseContent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputText,
              OpenAI::Responses::ResponseInputImage,
              OpenAI::Responses::ResponseInputFile,
              OpenAI::Responses::ResponseOutputText,
              OpenAI::Responses::ResponseOutputRefusal,
              OpenAI::Responses::ResponseContent::ReasoningTextContent
            )
          end

        class ReasoningTextContent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseContent::ReasoningTextContent,
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
            T::Array[OpenAI::Responses::ResponseContent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
