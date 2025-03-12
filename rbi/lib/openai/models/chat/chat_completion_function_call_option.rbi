# typed: strong

module OpenAI
  module Models
    ChatCompletionFunctionCallOption = T.type_alias { Chat::ChatCompletionFunctionCallOption }

    module Chat
      class ChatCompletionFunctionCallOption < OpenAI::BaseModel
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        sig { params(name: String).returns(T.attached_class) }
        def self.new(name:)
        end

        sig { override.returns({name: String}) }
        def to_hash
        end
      end
    end
  end
end
