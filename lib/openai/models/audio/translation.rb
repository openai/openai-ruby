# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class Translation < OpenAI::BaseModel
        # @!attribute text
        #
        #   @return [String]
        required :text, String

        # @!parse
        #   # @param text [String]
        #   #
        #   def initialize(text:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
