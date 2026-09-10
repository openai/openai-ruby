# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # The text or model-input content supplied as a function result.
      module AgentFunctionCallOutput
        extend OpenAI::Internal::Type::Union

        variant String

        variant -> { OpenAI::Models::Beta::AgentFunctionCallOutput::InputContentArray }

        # @!method self.variants
        #   @return [Array(String, Array<OpenAI::Models::Beta::InputContent::InputText, OpenAI::Models::Beta::InputContent::InputImage>)]

        # @type [OpenAI::Internal::Type::Converter]
        InputContentArray = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::InputContent }]
      end
    end
  end
end
