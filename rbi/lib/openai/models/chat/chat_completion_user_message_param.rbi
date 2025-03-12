# typed: strong

module OpenAI
  module Models
    ChatCompletionUserMessageParam = T.type_alias { Chat::ChatCompletionUserMessageParam }

    module Chat
      class ChatCompletionUserMessageParam < OpenAI::BaseModel
        sig do
          returns(
            T.any(
              String,
              T::Array[
              T.any(
                OpenAI::Models::Chat::ChatCompletionContentPartText,
                OpenAI::Models::Chat::ChatCompletionContentPartImage,
                OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                OpenAI::Models::Chat::ChatCompletionContentPart::File
              )
              ]
            )
          )
        end
        def content
        end

        sig do
          params(
            _: T.any(
              String,
              T::Array[
              T.any(
                OpenAI::Models::Chat::ChatCompletionContentPartText,
                OpenAI::Models::Chat::ChatCompletionContentPartImage,
                OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                OpenAI::Models::Chat::ChatCompletionContentPart::File
              )
              ]
            )
          )
            .returns(
              T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Chat::ChatCompletionContentPartText,
                  OpenAI::Models::Chat::ChatCompletionContentPartImage,
                  OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                  OpenAI::Models::Chat::ChatCompletionContentPart::File
                )
                ]
              )
            )
        end
        def content=(_)
        end

        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        sig do
          params(
            content: T.any(
              String,
              T::Array[
              T.any(
                OpenAI::Models::Chat::ChatCompletionContentPartText,
                OpenAI::Models::Chat::ChatCompletionContentPartImage,
                OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                OpenAI::Models::Chat::ChatCompletionContentPart::File
              )
              ]
            ),
            name: String,
            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, name: nil, role: :user)
        end

        sig do
          override
            .returns(
              {
                content: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Chat::ChatCompletionContentPartText,
                    OpenAI::Models::Chat::ChatCompletionContentPartImage,
                    OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                    OpenAI::Models::Chat::ChatCompletionContentPart::File
                  )
                  ]
                ),
                role: Symbol,
                name: String
              }
            )
        end
        def to_hash
        end

        class Content < OpenAI::Union
          abstract!

          ChatCompletionContentPartArray = T.type_alias do
            T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionContentPartText,
              OpenAI::Models::Chat::ChatCompletionContentPartImage,
              OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
              OpenAI::Models::Chat::ChatCompletionContentPart::File
            )
            ]
          end

          class << self
            sig do
              override
                .returns(
                  [
                    [NilClass, String],
                    [
                      NilClass,
                      T::Array[
                                        T.any(
                                          OpenAI::Models::Chat::ChatCompletionContentPartText,
                                          OpenAI::Models::Chat::ChatCompletionContentPartImage,
                                          OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                                          OpenAI::Models::Chat::ChatCompletionContentPart::File
                                        )
                                        ]
                    ]
                  ]
                )
            end
            private def variants
            end
          end
        end
      end
    end
  end
end
