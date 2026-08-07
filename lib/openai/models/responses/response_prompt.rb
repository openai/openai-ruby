# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponsePrompt < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique identifier of the prompt template to use.
        #
        #   @return [String]
        required :id, String

        # @!attribute variables
        #   Optional map of values to substitute in for variables in your prompt. The
        #   substitution values can either be strings, or other Response input types like
        #   images or files.
        #
        #   @return [Hash{Symbol=>String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile}, nil]
        optional :variables,
                 -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Responses::ResponsePrompt::Variable] },
                 nil?: true

        # @!attribute version
        #   Optional version of the prompt template.
        #
        #   @return [String, nil]
        optional :version, String, nil?: true

        # @!method initialize(id:, variables: nil, version: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponsePrompt} for more details.
        #
        #   Reference to a prompt template and its variables.
        #   [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        #
        #   @param id [String] The unique identifier of the prompt template to use.
        #
        #   @param variables [Hash{Symbol=>String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile}, nil] Optional map of values to substitute in for variables in your
        #
        #   @param version [String, nil] Optional version of the prompt template.

        # A text input to the model.
        module Variable
          extend OpenAI::Internal::Type::Union

          variant String

          # A text input to the model.
          variant -> { OpenAI::Responses::ResponseInputText }

          # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
          variant -> { OpenAI::Responses::ResponseInputImage }

          # A file input to the model.
          variant -> { OpenAI::Responses::ResponseInputFile }

          # @!method self.variants
          #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile)]
        end
      end
    end
  end
end
