# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionStreamOptions < OpenAI::Internal::Type::BaseModel
        # @!attribute [r] include_usage
        #   If set, an additional chunk will be streamed before the `data: [DONE]` message.
        #     The `usage` field on this chunk shows the token usage statistics for the entire
        #     request, and the `choices` field will always be an empty array.
        #
        #     All other chunks will also include a `usage` field, but with a null value.
        #     **NOTE:** If the stream is interrupted, you may not receive the final usage
        #     chunk which contains the total token usage for the request.
        #
        #   @return [Boolean, nil]
        optional :include_usage, OpenAI::Internal::Type::Boolean

        # @!parse
        #   # @return [Boolean]
        #   attr_writer :include_usage

        # @!parse
        #   # Options for streaming response. Only set this when you set `stream: true`.
        #   #
        #   # @param include_usage [Boolean]
        #   #
        #   def initialize(include_usage: nil, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    ChatCompletionStreamOptions = Chat::ChatCompletionStreamOptions
  end
end
