# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class Translation < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #
        #   @return [String]
        required :text, String

        # @!parse
        #   # @param text [String]
        #   #
        #   def initialize(text:, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
