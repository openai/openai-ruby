# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionUserMessageParam < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The contents of the user message.
        #
        #   @return [String, Array<OpenAI::Chat::ChatCompletionContentPartText, OpenAI::Chat::ChatCompletionContentPartImage, OpenAI::Chat::ChatCompletionContentPartInputAudio, OpenAI::Chat::ChatCompletionContentPart::File>]
        required :content, union: -> { OpenAI::Chat::ChatCompletionUserMessageParam::Content }

        # @!attribute role
        #   The role of the messages author, in this case `user`.
        #
        #   @return [Symbol, :user]
        required :role, const: :user

        # @!attribute name
        #   An optional name for the participant. Provides the model information to
        #   differentiate between participants of the same role.
        #
        #   @return [String, nil]
        optional :name, String

        # @!method initialize(content:, name: nil, role: :user)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Chat::ChatCompletionUserMessageParam} for more details.
        #
        #   Messages sent by an end user, containing prompts or additional context
        #   information.
        #
        #   @param content [String, Array<OpenAI::Chat::ChatCompletionContentPartText, OpenAI::Chat::ChatCompletionContentPartImage, OpenAI::Chat::ChatCompletionContentPartInputAudio, OpenAI::Chat::ChatCompletionContentPart::File>] The contents of the user message.
        #
        #   @param name [String] An optional name for the participant. Provides the model information to differen
        #
        #   @param role [Symbol, :user] The role of the messages author, in this case `user`.

        # The contents of the user message.
        #
        # @see OpenAI::Chat::ChatCompletionUserMessageParam#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text contents of the message.
          variant String

          # An array of content parts with a defined type. Supported options differ based on the [model](https://platform.openai.com/docs/models) being used to generate the response. Can contain text, image, or audio inputs.
          variant -> { OpenAI::Chat::ChatCompletionUserMessageParam::Content::ChatCompletionContentPartArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Chat::ChatCompletionContentPartText, OpenAI::Chat::ChatCompletionContentPartImage, OpenAI::Chat::ChatCompletionContentPartInputAudio, OpenAI::Chat::ChatCompletionContentPart::File>)]

          define_sorbet_constant!(:Variants) do
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
          end

          # @type [OpenAI::Internal::Type::Converter]
          ChatCompletionContentPartArray =
            OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Chat::ChatCompletionContentPart }]
        end
      end
    end

    ChatCompletionUserMessageParam = Chat::ChatCompletionUserMessageParam
  end
end
