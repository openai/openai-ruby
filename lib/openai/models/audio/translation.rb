# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
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
