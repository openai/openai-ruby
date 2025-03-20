# frozen_string_literal: true

module OpenAI
  module Models
    class ModerationCreateParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute input
      #   Input (or inputs) to classify. Can be a single string, an array of strings, or
      #     an array of multi-modal input objects similar to other models.
      #
      #   @return [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>]
      required :input, union: -> { OpenAI::Models::ModerationCreateParams::Input }

      # @!attribute [r] model
      #   The content moderation model you would like to use. Learn more in
      #     [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #     learn about available models
      #     [here](https://platform.openai.com/docs/models#moderation).
      #
      #   @return [String, Symbol, OpenAI::Models::ModerationModel, nil]
      optional :model, union: -> { OpenAI::Models::ModerationCreateParams::Model }

      # @!parse
      #   # @return [String, Symbol, OpenAI::Models::ModerationModel]
      #   attr_writer :model

      # @!parse
      #   # @param input [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>]
      #   # @param model [String, Symbol, OpenAI::Models::ModerationModel]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(input:, model: nil, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # Input (or inputs) to classify. Can be a single string, an array of strings, or
      #   an array of multi-modal input objects similar to other models.
      module Input
        extend OpenAI::Union

        StringArray = OpenAI::ArrayOf[String]

        ModerationMultiModalInputArray = OpenAI::ArrayOf[union: -> { OpenAI::Models::ModerationMultiModalInput }]

        # A string of text to classify for moderation.
        variant String

        # An array of strings to classify for moderation.
        variant OpenAI::Models::ModerationCreateParams::Input::StringArray

        # An array of multi-modal inputs to the moderation model.
        variant OpenAI::Models::ModerationCreateParams::Input::ModerationMultiModalInputArray

        # @!parse
        #   class << self
        #     # @return [Array(String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>)]
        #     def variants; end
        #   end
      end

      # The content moderation model you would like to use. Learn more in
      #   [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #   learn about available models
      #   [here](https://platform.openai.com/docs/models#moderation).
      module Model
        extend OpenAI::Union

        variant String

        # The content moderation model you would like to use. Learn more in
        # [the moderation guide](https://platform.openai.com/docs/guides/moderation), and learn about
        # available models [here](https://platform.openai.com/docs/models#moderation).
        variant enum: -> { OpenAI::Models::ModerationModel }

        # @!parse
        #   class << self
        #     # @return [Array(String, Symbol, OpenAI::Models::ModerationModel)]
        #     def variants; end
        #   end
      end
    end
  end
end
