# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class SummaryText < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The reasoning summary text.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The content type. Always `summary_text`.
        #
        #   @return [Symbol, :summary_text]
        required :type, const: :summary_text

        # @!method initialize(text:, type: :summary_text)
        #   A reasoning summary content part.
        #
        #   @param text [String]
        #     The reasoning summary text.
        #
        #   @param type [Symbol, :summary_text]
        #     The content type. Always `summary_text`.
      end
    end
  end
end
