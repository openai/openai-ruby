# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class SummaryTextContent < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #
        #   @return [Symbol, :summary_text]
        required :type, const: :summary_text

        # @!method initialize(text:, type: :summary_text)
        #   A summary text from the model.
        #
        #   @param text [String]
        #   @param type [Symbol, :summary_text]
      end
    end
  end
end
