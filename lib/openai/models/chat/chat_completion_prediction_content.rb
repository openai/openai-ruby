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
        #   @return [String, Array<OpenAI::Chat::ChatCompletionContentPartText>]
        required :content, union: -> { OpenAI::Chat::ChatCompletionPredictionContent::Content }

        # @!attribute type
        #   The type of the predicted content you want to provide. This type is currently
        #   always `content`.
        #
        #   @return [Symbol, :content]
        required :type, const: :content

        # @!method initialize(content:, type: :content)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Chat::ChatCompletionPredictionContent} for more details.
        #
        #   Static predicted output content, such as the content of a text file that is
        #   being regenerated.
        #
        #   @param content [String, Array<OpenAI::Chat::ChatCompletionContentPartText>] The content that should be matched when generating a model response.
        #
        #   @param type [Symbol, :content] The type of the predicted content you want to provide. This type is

        # The content that should be matched when generating a model response. If
        # generated tokens would match this content, the entire model response can be
        # returned much more quickly.
        #
        # @see OpenAI::Chat::ChatCompletionPredictionContent#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The content used for a Predicted Output. This is often the
          # text of a file you are regenerating with minor changes.
          variant String

          # An array of content parts with a defined type. Supported options differ based on the [model](https://platform.openai.com/docs/models) being used to generate the response. Can contain text inputs.
          variant -> {
            OpenAI::Chat::ChatCompletionPredictionContent::Content::ChatCompletionContentPartTextArray
          }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Chat::ChatCompletionContentPartText>)]

          # @type [OpenAI::Internal::Type::Converter]
          ChatCompletionContentPartTextArray =
            OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Chat::ChatCompletionContentPartText }]
        end
      end
    end

    ChatCompletionPredictionContent = Chat::ChatCompletionPredictionContent
  end
end
