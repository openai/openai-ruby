# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionToolMessageParam < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The contents of the tool message.
        #
        #   @return [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>]
        required :content, union: -> { OpenAI::Models::Chat::ChatCompletionToolMessageParam::Content }

        # @!attribute role
        #   The role of the messages author, in this case `tool`.
        #
        #   @return [Symbol, :tool]
        required :role, const: :tool

        # @!attribute tool_call_id
        #   Tool call that this message is responding to.
        #
        #   @return [String]
        required :tool_call_id, String

        # @!method initialize(content:, tool_call_id:, role: :tool)
        #   @param content [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>] The contents of the tool message.
        #
        #   @param tool_call_id [String] Tool call that this message is responding to.
        #
        #   @param role [Symbol, :tool] The role of the messages author, in this case `tool`.

        # The contents of the tool message.
        #
        # @see OpenAI::Models::Chat::ChatCompletionToolMessageParam#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The contents of the tool message.
          variant String

          # An array of content parts with a defined type. For tool messages, only type `text` is supported.
          variant -> { OpenAI::Models::Chat::ChatCompletionToolMessageParam::Content::ChatCompletionContentPartTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>)]

          ChatCompletionContentPartTextArray =
            OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Models::Chat::ChatCompletionContentPartText }]
        end
      end
    end

    ChatCompletionToolMessageParam = Chat::ChatCompletionToolMessageParam
  end
end
