# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionUserMessageParam < OpenAI::Internal::Type::BaseModel
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
        attr_accessor :content

        # The role of the messages author, in this case `user`.
        sig { returns(Symbol) }
        attr_accessor :role

        # An optional name for the participant. Provides the model information to
        #   differentiate between participants of the same role.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        # Messages sent by an end user, containing prompts or additional context
        #   information.
        sig do
          params(
            content: T.any(
              String,
              T::Array[
              T.any(
                OpenAI::Models::Chat::ChatCompletionContentPartText,
                OpenAI::Internal::AnyHash,
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
        module Content
          extend OpenAI::Internal::Type::Union

          sig do
            override
              .returns(
                [
                  String,
                  T::Array[
                                  T.any(
                                    OpenAI::Models::Chat::ChatCompletionContentPartText,
                                    OpenAI::Models::Chat::ChatCompletionContentPartImage,
                                    OpenAI::Models::Chat::ChatCompletionContentPartInputAudio,
                                    OpenAI::Models::Chat::ChatCompletionContentPart::File
                                  )
                                  ]
                ]
              )
          end
          def self.variants
          end

          ChatCompletionContentPartArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Chat::ChatCompletionContentPart],
              OpenAI::Internal::Type::Converter
            )
        end
      end
    end

    ChatCompletionUserMessageParam = Chat::ChatCompletionUserMessageParam
  end
end
