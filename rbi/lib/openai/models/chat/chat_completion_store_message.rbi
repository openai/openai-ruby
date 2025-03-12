# typed: strong

module OpenAI
  module Models
    ChatCompletionStoreMessage = T.type_alias { Chat::ChatCompletionStoreMessage }

    module Chat
      class ChatCompletionStoreMessage < OpenAI::Models::Chat::ChatCompletionMessage
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { params(id: String).returns(T.attached_class) }
        def self.new(id:)
        end

        sig { override.returns({id: String}) }
        def to_hash
        end
      end
    end
  end
end
