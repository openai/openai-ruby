# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # Type of noise reduction. `near_field` is for close-talking microphones such as
      # headphones, `far_field` is for far-field microphones such as laptop or
      # conference room microphones.
      module NoiseReductionType
        extend OpenAI::Internal::Type::Enum

        NEAR_FIELD = :near_field
        FAR_FIELD = :far_field

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
