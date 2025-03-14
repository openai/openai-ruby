# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      class FileContentResponse < OpenAI::BaseModel
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

        # @!parse
        #   # @param text [String]
        #   # @param type [String]
        #   #
        #   def initialize(text: nil, type: nil, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
