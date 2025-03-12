# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartText = T.type_alias { Chat::ChatCompletionContentPartText }

    module Chat
      class ChatCompletionContentPartText < OpenAI::BaseModel
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(text:, type: :text)
        end

        sig { override.returns({text: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
