# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionInputText < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionInputText,
            OpenAI::Internal::AnyHash
          )
        end

        # The text input to the model.
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

          # The text input to the model.
          text:,

          type: :input_text
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

    end

  end
end
