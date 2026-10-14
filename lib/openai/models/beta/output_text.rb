# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class OutputText < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text produced by the agent.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The content type. Always `output_text`.
        #
        #   @return [Symbol, :output_text]
        required :type, const: :output_text

        # @!method initialize(text:, type: :output_text)
        #   A text content part produced by the agent.
        #
        #   @param text [String]
        #     The text produced by the agent.
        #
        #   @param type [Symbol, :output_text]
        #     The content type. Always `output_text`.
      end
    end
  end
end
