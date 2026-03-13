# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#get_character
    class VideoGetCharacterResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   Identifier for the character creation cameo.
      #
      #   @return [String, nil]
      required :id, String, nil?: true

      # @!attribute created_at
      #   Unix timestamp (in seconds) when the character was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute name
      #   Display name for the character.
      #
      #   @return [String, nil]
      required :name, String, nil?: true

      # @!method initialize(id:, created_at:, name:)
      #   @param id [String, nil] Identifier for the character creation cameo.
      #
      #   @param created_at [Integer] Unix timestamp (in seconds) when the character was created.
      #
      #   @param name [String, nil] Display name for the character.
    end
  end
end
