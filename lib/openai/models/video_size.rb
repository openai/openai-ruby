# frozen_string_literal: true

module OpenAI
  module Models
    module VideoSize
      extend OpenAI::Internal::Type::Enum

      VIDEO_SIZE_720X1280 = :"720x1280"
      VIDEO_SIZE_1280X720 = :"1280x720"
      VIDEO_SIZE_1024X1792 = :"1024x1792"
      VIDEO_SIZE_1792X1024 = :"1792x1024"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
