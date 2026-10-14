# typed: strong

module OpenAI
  module Models
    module Conversations
      class ConversationDeletedResource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ConversationDeletedResource,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :id

        sig { returns(T::Boolean) }
        attr_accessor :deleted

        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(id: String, deleted: T::Boolean, object: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(id:, deleted:, object: :"conversation.deleted")
        end

        sig do
          override.returns({ id: String, deleted: T::Boolean, object: Symbol })
        end
        def to_hash
        end
      end
    end
  end
end
