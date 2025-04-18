# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionPredictionContent < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The content that should be matched when generating a model response. If
        #   generated tokens would match this content, the entire model response can be
        #   returned much more quickly.
        #
        #   @return [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>]
        required :content, union: -> { OpenAI::Models::Chat::ChatCompletionPredictionContent::Content }

        # @!attribute type
        #   The type of the predicted content you want to provide. This type is currently
        #   always `content`.
        #
        #   @return [Symbol, :content]
        required :type, const: :content

        # @!method initialize(content:, type: :content)
        #   Static predicted output content, such as the content of a text file that is
        #   being regenerated.
        #
        #   @param content [String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>]
        #   @param type [Symbol, :content]

        # The content that should be matched when generating a model response. If
        # generated tokens would match this content, the entire model response can be
        # returned much more quickly.
        #
        # @see OpenAI::Models::Chat::ChatCompletionPredictionContent#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The content used for a Predicted Output. This is often the
          # text of a file you are regenerating with minor changes.
          variant String

          # An array of content parts with a defined type. Supported options differ based on the [model](https://platform.openai.com/docs/models) being used to generate the response. Can contain text inputs.
          variant -> { OpenAI::Models::Chat::ChatCompletionPredictionContent::Content::ChatCompletionContentPartTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Chat::ChatCompletionContentPartText>)]

          ChatCompletionContentPartTextArray =
            OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Models::Chat::ChatCompletionContentPartText }]
        end
      end
    end

    ChatCompletionPredictionContent = Chat::ChatCompletionPredictionContent
  end
end
