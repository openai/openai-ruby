# typed: strong

module OpenAI
  module Models
    ChatCompletionUserMessageParam = T.type_alias { Chat::ChatCompletionUserMessageParam }

    module Chat
      class ChatCompletionUserMessageParam < OpenAI::BaseModel
        # The contents of the user message.
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

        # The role of the messages author, in this case `user`.
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

        # Messages sent by an end user, containing prompts or additional context
        #   information.
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

        # The contents of the user message.
        class Content < OpenAI::Union
          abstract!

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
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
              }
            end

          ChatCompletionContentPartArray =
            T.type_alias do
              T::Array[
              T.any(
                OpenAI::Models::Chat::ChatCompletionContentPartText,
                OpenAI::Models::Chat::ChatCompletionContentPartImage,
                OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                OpenAI::Models::Chat::ChatCompletionContentPart::File
              )
              ]
            end
        end
      end
    end
  end
end
