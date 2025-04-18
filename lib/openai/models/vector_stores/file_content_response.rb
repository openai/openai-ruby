# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#content
      class FileContentResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute [r] text
        #   The text content
        #
        #   @return [String, nil]
        optional :text, String

        # @!parse
        #   # @return [String]
        #   attr_writer :text

        # @!attribute [r] type
        #   The content type (currently only `"text"`)
        #
        #   @return [String, nil]
        optional :type, String

        # @!parse
        #   # @return [String]
        #   attr_writer :type

        # @!method initialize(text: nil, type: nil)
        #   @param text [String]
        #   @param type [String]
      end
    end
  end
end
