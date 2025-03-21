# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionDeleted < OpenAI::BaseModel
        # The ID of the chat completion that was deleted.
        sig { returns(String) }
        attr_accessor :id

        # Whether the chat completion was deleted.
        sig { returns(T::Boolean) }
        attr_accessor :deleted

        # The type of object being deleted.
        sig { returns(Symbol) }
        attr_accessor :object

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
