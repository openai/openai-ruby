# typed: strong

module OpenAI
  module Models
    ChatCompletionDeleted = Chat::ChatCompletionDeleted

    module Chat
      class ChatCompletionDeleted < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionDeleted,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the chat completion that was deleted.
        sig { returns(String) }
        attr_accessor :id

        # Whether the chat completion was deleted.
        sig { returns(T::Boolean) }
        attr_accessor :deleted

        # The type of object being deleted.
        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(id: String, deleted: T::Boolean, object: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The ID of the chat completion that was deleted.
          id:,
          # Whether the chat completion was deleted.
          deleted:,
          # The type of object being deleted.
          object: :"chat.completion.deleted"
        )
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
