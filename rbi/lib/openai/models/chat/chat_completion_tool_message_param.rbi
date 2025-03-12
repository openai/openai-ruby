# typed: strong

module OpenAI
  module Models
    ChatCompletionToolMessageParam = T.type_alias { Chat::ChatCompletionToolMessageParam }

    module Chat
      class ChatCompletionToolMessageParam < OpenAI::BaseModel
        sig { returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])) }
        def content
        end

        sig do
          params(_: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]))
            .returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]))
        end
        def content=(_)
        end

        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        sig { returns(String) }
        def tool_call_id
        end

        sig { params(_: String).returns(String) }
        def tool_call_id=(_)
        end

        sig do
          params(
            content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]),
            tool_call_id: String,
            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, tool_call_id:, role: :tool)
        end

        sig do
          override
            .returns(
              {
                content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]),
                role: Symbol,
                tool_call_id: String
              }
            )
        end
        def to_hash
        end

        class Content < OpenAI::Union
          abstract!

          ChatCompletionContentPartTextArray = T.type_alias { T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText] }

          class << self
            sig do
              override
                .returns([[NilClass, String], [NilClass, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]]])
            end
            private def variants
            end
          end
        end
      end
    end
  end
end
