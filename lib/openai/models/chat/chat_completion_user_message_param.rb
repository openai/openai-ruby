# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionUserMessageParam < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The contents of the user message.
        #
        #   @return [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio, OpenAI::Models::Chat::ChatCompletionContentPart::File>]
        required :content, union: -> { OpenAI::Models::Chat::ChatCompletionUserMessageParam::Content }

        # @!attribute role
        #   The role of the messages author, in this case `user`.
        #
        #   @return [Symbol, :user]
        required :role, const: :user

        # @!attribute [r] name
        #   An optional name for the participant. Provides the model information to
        #     differentiate between participants of the same role.
        #
        #   @return [String, nil]
        optional :name, String

        # @!parse
        #   # @return [String]
        #   attr_writer :name

        # @!parse
        #   # Messages sent by an end user, containing prompts or additional context
        #   #   information.
        #   #
        #   # @param content [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio, OpenAI::Models::Chat::ChatCompletionContentPart::File>]
        #   # @param name [String]
        #   # @param role [Symbol, :user]
        #   #
        #   def initialize(content:, name: nil, role: :user, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # The contents of the user message.
        #
        # @see OpenAI::Models::Chat::ChatCompletionUserMessageParam#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text contents of the message.
          variant String

          # An array of content parts with a defined type. Supported options differ based on the [model](https://platform.openai.com/docs/models) being used to generate the response. Can contain text, image, or audio inputs.
          variant -> { OpenAI::Models::Chat::ChatCompletionUserMessageParam::Content::ChatCompletionContentPartArray }

          # @!parse
          #   # @return [Array(String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio, OpenAI::Models::Chat::ChatCompletionContentPart::File>)]
          #   def self.variants; end

          ChatCompletionContentPartArray =
            OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Models::Chat::ChatCompletionContentPart }]
        end
      end
    end

    ChatCompletionUserMessageParam = Chat::ChatCompletionUserMessageParam
  end
end
