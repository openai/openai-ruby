# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Moderations#create
    class ModerationCreateParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute input
      #   Input (or inputs) to classify. Can be a single string, an array of strings, or
      #   an array of multi-modal input objects similar to other models.
      #
      #   @return [String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>]
      required :input, union: -> { OpenAI::Models::ModerationCreateParams::Input }

      # @!attribute [r] model
      #   The content moderation model you would like to use. Learn more in
      #   [the moderation guide](https://platform.openai.com/docs/guides/moderation), and
      #   learn about available models
      #   [here](https://platform.openai.com/docs/models#moderation).
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

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

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

        # @!parse
        #   # @return [Array(String, Array<String>, Array<OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput>)]
        #   def self.variants; end

        StringArray = OpenAI::Internal::Type::ArrayOf[String]

        ModerationMultiModalInputArray =
          OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Models::ModerationMultiModalInput }]
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
        variant enum: -> { OpenAI::Models::ModerationModel }

        # @!parse
        #   # @return [Array(String, Symbol, OpenAI::Models::ModerationModel)]
        #   def self.variants; end
      end
    end
  end
end
