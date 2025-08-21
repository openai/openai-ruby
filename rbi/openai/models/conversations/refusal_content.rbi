# typed: strong

module OpenAI
  module Models
    module Conversations
      class RefusalContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::RefusalContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The refusal explanation from the model.
        sig { returns(String) }
        attr_accessor :refusal

        # The type of the refusal. Always `refusal`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig { params(refusal: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The refusal explanation from the model.
          refusal:,
          # The type of the refusal. Always `refusal`.
          type: :refusal
        )
        end

        sig { override.returns({ refusal: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
