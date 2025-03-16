# typed: strong

module OpenAI
  module Models
    ChatCompletionDeveloperMessageParam = T.type_alias { Chat::ChatCompletionDeveloperMessageParam }

    module Chat
      class ChatCompletionDeveloperMessageParam < OpenAI::BaseModel
        # The contents of the developer message.
        sig { returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])) }
        def content
        end

        sig do
          params(_: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]))
            .returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]))
        end
        def content=(_)
        end

        # The role of the messages author, in this case `developer`.
        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        # An optional name for the participant. Provides the model information to
        #   differentiate between participants of the same role.
        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        # Developer-provided instructions that the model should follow, regardless of
        #   messages sent by the user. With o1 models and newer, `developer` messages
        #   replace the previous `system` messages.
        sig do
          params(
            content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]),
            name: String,
            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, name: nil, role: :developer)
        end

        sig do
          override
            .returns(
              {
                content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]),
                role: Symbol,
                name: String
              }
            )
        end
        def to_hash
        end

        # The contents of the developer message.
        class Content < OpenAI::Union
          abstract!

          Variants = type_template(:out) { {fixed: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])} }

          ChatCompletionContentPartTextArray = T.type_alias { T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText] }
        end
      end
    end
  end
end
