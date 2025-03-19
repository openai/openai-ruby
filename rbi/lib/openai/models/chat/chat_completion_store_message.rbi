# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionStoreMessage < OpenAI::Models::Chat::ChatCompletionMessage
        # The identifier of the chat message.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # A chat completion message generated by the model.
        sig { params(id: String).returns(T.attached_class) }
        def self.new(id:)
        end

        sig { override.returns({id: String}) }
        def to_hash
        end
      end
    end

    ChatCompletionStoreMessage = Chat::ChatCompletionStoreMessage
  end
end
