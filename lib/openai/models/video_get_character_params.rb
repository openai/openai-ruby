# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#get_character
    class VideoGetCharacterParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute character_id
      #
      #   @return [String]
      required :character_id, String

      # @!method initialize(character_id:, request_options: {})
      #   @param character_id [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
