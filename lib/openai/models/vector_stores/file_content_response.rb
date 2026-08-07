# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#content
      class FileContentResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text content
        #
        #   @return [String, nil]
        optional :text, String

        # @!attribute type
        #   The content type (currently only `"text"`)
        #
        #   @return [String, nil]
        optional :type, String

        # @!method initialize(text: nil, type: nil)
        #   @param text [String] The text content
        #
        #   @param type [String] The content type (currently only `"text"`)
      end
    end
  end
end
