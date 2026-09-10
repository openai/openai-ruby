# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class CustomVoice < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!method initialize(id:)
        #   @param id [String]
      end
    end
  end
end
