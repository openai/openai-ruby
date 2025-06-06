# typed: strong

module OpenAI
  module Resources
    class Moderations
      # Classifies if text and/or image inputs are potentially harmful. Learn more in
      # the [moderation guide](https://platform.openai.com/docs/guides/moderation).
      sig do
        params(
          input: OpenAI::ModerationCreateParams::Input::Variants,
          model: T.any(String, OpenAI::ModerationModel::OrSymbol),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Models::ModerationCreateResponse)
      end
      def create(
        # Input (or inputs) to classify. Can be a single string, an array of strings, or
        # an array of multi-modal input objects similar to other models.
        input:,
        # The content moderation model you would like to use. Learn more in
        # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
        # learn about available models
        # [here](https://platform.openai.com/docs/models#moderation).
        model: nil,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
