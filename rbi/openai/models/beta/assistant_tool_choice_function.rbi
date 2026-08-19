# typed: strong

module OpenAI
  module Models

    module Beta

      class AssistantToolChoiceFunction < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AssistantToolChoiceFunction,
            OpenAI::Internal::AnyHash
          )
        end

        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        sig do
          params(

            name: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The name of the function to call.

          name:
        )
        end

        sig do
          override.returns(
            {name: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
