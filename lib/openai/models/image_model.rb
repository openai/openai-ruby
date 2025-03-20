# frozen_string_literal: true

module OpenAI
  module Models
    module ImageModel
      extend OpenAI::Enum

      DALL_E_2 = :"dall-e-2"
      DALL_E_3 = :"dall-e-3"

      finalize!

      class << self
        # @!parse
        #   # @return [Array<Symbol>]
        #   def values; end
      end
    end
  end
end
