# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class Translation < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #
        #   @return [String]
        required :text, String

        # @!method initialize(text:)
        #   @param text [String]
      end
    end
  end
end
