# typed: strong

module OpenAI
  module Models
    BetaResponseConversationParam = Beta::BetaResponseConversationParam

    module Beta
      class BetaResponseConversationParam < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseConversationParam,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the conversation.
        sig { returns(String) }
        attr_accessor :id

        # The conversation that this response belongs to.
        sig { params(id: String).returns(T.attached_class) }
        def self.new(
          # The unique ID of the conversation.
          id:
        )
        end

        sig { override.returns({ id: String }) }
        def to_hash
        end
      end
    end
  end
end
