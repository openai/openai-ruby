# typed: strong

module OpenAI
  module Models
    module Conversations
      class InputTextContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::InputTextContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The text input to the model.
        sig { returns(String) }
        attr_accessor :text

        # The type of the input item. Always `input_text`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The text input to the model.
          text:,
          # The type of the input item. Always `input_text`.
          type: :input_text
        )
        end

        sig { override.returns({ text: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
