# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionToolMessageParam < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The contents of the tool message.
        #
        #   @return [String, Array<OpenAI::Chat::ChatCompletionContentPartText>]
        required :content, union: -> { OpenAI::Chat::ChatCompletionToolMessageParam::Content }

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
        #   @param content [String, Array<OpenAI::Chat::ChatCompletionContentPartText>] The contents of the tool message.
        #
        #   @param tool_call_id [String] Tool call that this message is responding to.
        #
        #   @param role [Symbol, :tool] The role of the messages author, in this case `tool`.

        # The contents of the tool message.
        #
        # @see OpenAI::Chat::ChatCompletionToolMessageParam#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The contents of the tool message.
          variant String

          # An array of content parts with a defined type. For tool messages, only type `text` is supported.
          variant -> {
            OpenAI::Chat::ChatCompletionToolMessageParam::Content::ChatCompletionContentPartTextArray
          }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Chat::ChatCompletionContentPartText>)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, T::Array[OpenAI::Chat::ChatCompletionContentPartText]) }
          end

          # @type [OpenAI::Internal::Type::Converter]
          ChatCompletionContentPartTextArray =
            OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Chat::ChatCompletionContentPartText }]
        end
      end
    end

    ChatCompletionToolMessageParam = Chat::ChatCompletionToolMessageParam
  end
end
