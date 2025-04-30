# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionDeveloperMessageParam < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The contents of the developer message.
        #
        #   @return [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>]
        required :content, union: -> { OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam::Content }

        # @!attribute role
        #   The role of the messages author, in this case `developer`.
        #
        #   @return [Symbol, :developer]
        required :role, const: :developer

        # @!attribute name
        #   An optional name for the participant. Provides the model information to
        #   differentiate between participants of the same role.
        #
        #   @return [String, nil]
        optional :name, String

        # @!method initialize(content:, name: nil, role: :developer)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam} for more details.
        #
        #   Developer-provided instructions that the model should follow, regardless of
        #   messages sent by the user. With o1 models and newer, `developer` messages
        #   replace the previous `system` messages.
        #
        #   @param content [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>] The contents of the developer message.
        #
        #   @param name [String] An optional name for the participant. Provides the model information to differen
        #   ...
        #
        #   @param role [Symbol, :developer] The role of the messages author, in this case `developer`.

        # The contents of the developer message.
        #
        # @see OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The contents of the developer message.
          variant String

          # An array of content parts with a defined type. For developer messages, only type `text` is supported.
          variant -> { OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam::Content::ChatCompletionContentPartTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>)]

          # @type [OpenAI::Internal::Type::Converter]
          ChatCompletionContentPartTextArray =
            OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Models::Chat::ChatCompletionContentPartText }]
        end
      end
    end

    ChatCompletionDeveloperMessageParam = Chat::ChatCompletionDeveloperMessageParam
  end
end
