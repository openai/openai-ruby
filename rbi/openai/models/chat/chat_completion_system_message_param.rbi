# typed: strong

module OpenAI
  module Models
    ChatCompletionSystemMessageParam = Chat::ChatCompletionSystemMessageParam

    module Chat
      class ChatCompletionSystemMessageParam < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The contents of the system message.
        sig do
          returns(
            T.any(String, T::Array[OpenAI::Chat::ChatCompletionContentPartText])
          )
        end
        attr_accessor :content

        # The role of the messages author, in this case `system`.
        sig { returns(Symbol) }
        attr_accessor :role

        # An optional name for the participant. Provides the model information to
        # differentiate between participants of the same role.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        # Developer-provided instructions that the model should follow, regardless of
        # messages sent by the user. With o1 models and newer, use `developer` messages
        # for this purpose instead.
        sig do
          params(
            content:
              T.any(
                String,
                T::Array[OpenAI::Chat::ChatCompletionContentPartText::OrHash]
              ),
            name: String,
            role: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The contents of the system message.
          content:,
          # An optional name for the participant. Provides the model information to
          # differentiate between participants of the same role.
          name: nil,
          # The role of the messages author, in this case `system`.
          role: :system
        )
        end

        sig do
          override.returns(
            {
              content:
                T.any(
                  String,
                  T::Array[OpenAI::Chat::ChatCompletionContentPartText]
                ),
              role: Symbol,
              name: String
            }
          )
        end
        def to_hash
        end

        # The contents of the system message.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                T::Array[OpenAI::Chat::ChatCompletionContentPartText]
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Chat::ChatCompletionSystemMessageParam::Content::Variants
              ]
            )
          end
          def self.variants
          end

          ChatCompletionContentPartTextArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[
                OpenAI::Chat::ChatCompletionContentPartText
              ],
              OpenAI::Internal::Type::Converter
            )
        end
      end
    end
  end
end
