# typed: strong

module OpenAI
  module Models
    ChatCompletionPredictionContent = T.type_alias { Chat::ChatCompletionPredictionContent }

    module Chat
      class ChatCompletionPredictionContent < OpenAI::BaseModel
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
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, type: :content)
        end

        sig do
          override
            .returns(
              {content: T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]), type: Symbol}
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
