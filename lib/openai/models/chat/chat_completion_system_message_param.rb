# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionSystemMessageParam < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The contents of the system message.
        #
        #   @return [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>]
        required :content, union: -> { OpenAI::Models::Chat::ChatCompletionSystemMessageParam::Content }

        # @!attribute role
        #   The role of the messages author, in this case `system`.
        #
        #   @return [Symbol, :system]
        required :role, const: :system

        # @!attribute name
        #   An optional name for the participant. Provides the model information to
        #   differentiate between participants of the same role.
        #
        #   @return [String, nil]
        optional :name, String

        # @!method initialize(content:, name: nil, role: :system)
        #   Developer-provided instructions that the model should follow, regardless of
        #   messages sent by the user. With o1 models and newer, use `developer` messages
        #   for this purpose instead.
        #
        #   @param content [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>]
        #   @param name [String]
        #   @param role [Symbol, :system]

        # The contents of the system message.
        #
        # @see OpenAI::Models::Chat::ChatCompletionSystemMessageParam#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The contents of the system message.
          variant String

          # An array of content parts with a defined type. For system messages, only type `text` is supported.
          variant -> { OpenAI::Models::Chat::ChatCompletionSystemMessageParam::Content::ChatCompletionContentPartTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>)]

          ChatCompletionContentPartTextArray =
            OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Models::Chat::ChatCompletionContentPartText }]
        end
      end
    end

    ChatCompletionSystemMessageParam = Chat::ChatCompletionSystemMessageParam
  end
end
