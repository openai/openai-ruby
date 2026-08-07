# frozen_string_literal: true

module OpenAI
  module Models
    module VideoSeconds
      extend OpenAI::Internal::Type::Enum

      VIDEO_SECONDS_4 = :"4"
      VIDEO_SECONDS_8 = :"8"
      VIDEO_SECONDS_12 = :"12"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
