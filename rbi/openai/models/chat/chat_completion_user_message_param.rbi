# typed: strong

module OpenAI
  module Models
    ChatCompletionUserMessageParam = Chat::ChatCompletionUserMessageParam

    module Chat
      class ChatCompletionUserMessageParam < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The contents of the user message.
        sig do
          returns(
            T.any(
              String,
              T::Array[
                T.any(
                  OpenAI::Chat::ChatCompletionContentPartText,
                  OpenAI::Chat::ChatCompletionContentPartImage,
                  OpenAI::Chat::ChatCompletionContentPartInputAudio,
                  OpenAI::Chat::ChatCompletionContentPart::File
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
        # differentiate between participants of the same role.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        # Messages sent by an end user, containing prompts or additional context
        # information.
        sig do
          params(
            content:
              T.any(
                String,
                T::Array[
                  T.any(
                    OpenAI::Chat::ChatCompletionContentPartText::OrHash,
                    OpenAI::Chat::ChatCompletionContentPartImage::OrHash,
                    OpenAI::Chat::ChatCompletionContentPartInputAudio::OrHash,
                    OpenAI::Chat::ChatCompletionContentPart::File::OrHash
                  )
                ]
              ),
            name: String,
            role: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The contents of the user message.
          content:,
          # An optional name for the participant. Provides the model information to
          # differentiate between participants of the same role.
          name: nil,
          # The role of the messages author, in this case `user`.
          role: :user
        )
        end

        sig do
          override.returns(
            {
              content:
                T.any(
                  String,
                  T::Array[
                    T.any(
                      OpenAI::Chat::ChatCompletionContentPartText,
                      OpenAI::Chat::ChatCompletionContentPartImage,
                      OpenAI::Chat::ChatCompletionContentPartInputAudio,
                      OpenAI::Chat::ChatCompletionContentPart::File
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

          Variants =
            T.type_alias do
              T.any(
                String,
                T::Array[
                  T.any(
                    OpenAI::Chat::ChatCompletionContentPartText,
                    OpenAI::Chat::ChatCompletionContentPartImage,
                    OpenAI::Chat::ChatCompletionContentPartInputAudio,
                    OpenAI::Chat::ChatCompletionContentPart::File
                  )
                ]
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Chat::ChatCompletionUserMessageParam::Content::Variants
              ]
            )
          end
          def self.variants
          end

          ChatCompletionContentPartArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[
                union: OpenAI::Chat::ChatCompletionContentPart
              ],
              OpenAI::Internal::Type::Converter
            )
        end
      end
    end
  end
end
