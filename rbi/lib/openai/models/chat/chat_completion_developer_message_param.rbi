# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionDeveloperMessageParam < OpenAI::BaseModel
        # The contents of the developer message.
        sig { returns(T.any(String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText])) }
        attr_accessor :content

        # The role of the messages author, in this case `developer`.
        sig { returns(Symbol) }
        attr_accessor :role

        # An optional name for the participant. Provides the model information to
        #   differentiate between participants of the same role.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        # Developer-provided instructions that the model should follow, regardless of
        #   messages sent by the user. With o1 models and newer, `developer` messages
        #   replace the previous `system` messages.
        sig do
          params(
            content: T.any(String, T::Array[T.any(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Util::AnyHash)]),
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
        module Content
          extend OpenAI::Union

          ChatCompletionContentPartTextArray =
            T.let(OpenAI::ArrayOf[OpenAI::Models::Chat::ChatCompletionContentPartText], OpenAI::Converter)

          sig { override.returns([String, T::Array[OpenAI::Models::Chat::ChatCompletionContentPartText]]) }
          def self.variants
          end
        end
      end
    end

    ChatCompletionDeveloperMessageParam = Chat::ChatCompletionDeveloperMessageParam
  end
end
