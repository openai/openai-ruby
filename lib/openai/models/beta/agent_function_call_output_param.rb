# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A function result represented as text or supported model-input content.
      module AgentFunctionCallOutputParam
        extend OpenAI::Internal::Type::Union

        variant String

        variant -> { OpenAI::Models::Beta::AgentFunctionCallOutputParam::InputContentParamArray }

        # @!method self.variants
        #   @return [Array(String, Array<OpenAI::Models::Beta::InputContentParam::InputText, OpenAI::Models::Beta::InputContentParam::InputImage>)]

        # @type [OpenAI::Internal::Type::Converter]
        InputContentParamArray = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::InputContentParam }]
      end
    end
  end
end
