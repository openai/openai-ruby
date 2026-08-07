# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Moderations#create
    class ModerationCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute input
      #   Input (or inputs) to classify. Can be a single string, an array of strings, or
      #   an array of multi-modal input objects similar to other models.
      #
      #   @return [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>]
      required :input, union: -> { OpenAI::ModerationCreateParams::Input }

      # @!attribute model
      #   The content moderation model you would like to use. Learn more in
      #   [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #   learn about available models
      #   [here](https://platform.openai.com/docs/models#moderation).
      #
      #   @return [String, Symbol, OpenAI::Models::ModerationModel, nil]
      optional :model, union: -> { OpenAI::ModerationCreateParams::Model }

      # @!method initialize(input:, model: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ModerationCreateParams} for more details.
      #
      #   @param input [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>] Input (or inputs) to classify. Can be a single string, an array of strings, or
      #
      #   @param model [String, Symbol, OpenAI::Models::ModerationModel] The content moderation model you would like to use. Learn more in
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      # an array of multi-modal input objects similar to other models.
      module Input
        extend OpenAI::Internal::Type::Union

        # A string of text to classify for moderation.
        variant String

        # An array of strings to classify for moderation.
        variant -> { OpenAI::Models::ModerationCreateParams::Input::StringArray }

        # An array of multi-modal inputs to the moderation model.
        variant -> { OpenAI::Models::ModerationCreateParams::Input::ModerationMultiModalInputArray }

        # @!method self.variants
        #   @return [Array(String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>)]

        # @type [OpenAI::Internal::Type::Converter]
        StringArray = OpenAI::Internal::Type::ArrayOf[String]

        # @type [OpenAI::Internal::Type::Converter]
        ModerationMultiModalInputArray =
          OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::ModerationMultiModalInput }]
      end

      # The content moderation model you would like to use. Learn more in
      # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      # learn about available models
      # [here](https://platform.openai.com/docs/models#moderation).
      module Model
        extend OpenAI::Internal::Type::Union

        variant String

        # The content moderation model you would like to use. Learn more in
        # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and learn about
        # available models [here](https://platform.openai.com/docs/models#moderation).
        variant enum: -> { OpenAI::ModerationModel }

        # @!method self.variants
        #   @return [Array(String, Symbol, OpenAI::Models::ModerationModel)]
      end
    end
  end
end
