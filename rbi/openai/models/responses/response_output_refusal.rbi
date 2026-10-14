# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseOutputRefusal < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseOutputRefusal,
            OpenAI::Internal::AnyHash
          )
        end

        # The refusal explanation from the model.
        sig { returns(String) }
        attr_accessor :refusal

        # The type of the refusal. Always `refusal`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A refusal from the model.
        sig do
          params(

            refusal: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The refusal explanation from the model.
          refusal:,

          # The type of the refusal. Always `refusal`.

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

    end

  end
end
