# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class SummaryTextContent < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   A summary of the reasoning output from the model so far.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the object. Always `summary_text`.
        #
        #   @return [Symbol, :summary_text]
        required :type, const: :summary_text

        # @!method initialize(text:, type: :summary_text)
        #   A summary text from the model.
        #
        #   @param text [String] A summary of the reasoning output from the model so far.
        #
        #   @param type [Symbol, :summary_text] The type of the object. Always `summary_text`.
      end
    end
  end
end
