# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionToolMessageParam < OpenAI::BaseModel
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

        # @!parse
        #   # @param content [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>]
        #   # @param tool_call_id [String]
        #   # @param role [Symbol, :tool]
        #   #
        #   def initialize(content:, tool_call_id:, role: :tool, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # The contents of the tool message.
        class Content < OpenAI::Union
          ChatCompletionContentPartTextArray =
            OpenAI::ArrayOf[-> { OpenAI::Models::Chat::ChatCompletionContentPartText }]

          # The contents of the tool message.
          variant String

          # An array of content parts with a defined type. For tool messages, only type `text` is supported.
          variant OpenAI::Models::Chat::ChatCompletionToolMessageParam::Content::ChatCompletionContentPartTextArray

          # @!parse
          #   class << self
          #     # @return [Array(String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>)]
          #     def variants; end
          #   end
        end
      end
    end

    ChatCompletionToolMessageParam = Chat::ChatCompletionToolMessageParam
  end
end
