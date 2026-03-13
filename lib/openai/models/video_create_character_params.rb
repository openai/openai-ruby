# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#create_character
    class VideoCreateCharacterParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute name
      #   Display name for this API character.
      #
      #   @return [String]
      required :name, String

      # @!attribute video
      #   Video file used to create a character.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
      required :video, OpenAI::Internal::Type::FileInput

      # @!method initialize(name:, video:, request_options: {})
      #   @param name [String] Display name for this API character.
      #
      #   @param video [Pathname, StringIO, IO, String, OpenAI::FilePart] Video file used to create a character.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
