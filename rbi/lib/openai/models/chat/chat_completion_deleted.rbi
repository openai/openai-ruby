# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionDeleted < OpenAI::BaseModel
        # The ID of the chat completion that was deleted.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # Whether the chat completion was deleted.
        sig { returns(T::Boolean) }
        def deleted
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def deleted=(_)
        end

        # The type of object being deleted.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig { params(id: String, deleted: T::Boolean, object: Symbol).returns(T.attached_class) }
        def self.new(id:, deleted:, object: :"chat.completion.deleted")
        end

        sig { override.returns({id: String, deleted: T::Boolean, object: Symbol}) }
        def to_hash
        end
      end
    end

    ChatCompletionDeleted = Chat::ChatCompletionDeleted
  end
end
