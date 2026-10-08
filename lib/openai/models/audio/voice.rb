# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Voices#create
      class Voice < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The voice identifier, which can be referenced in API endpoints.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) for when the voice was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute name
        #   The name of the voice.
        #
        #   @return [String]
        required :name, String

        # @!attribute object
        #   The object type, which is always `audio.voice`.
        #
        #   @return [Symbol, :"audio.voice"]
        required :object, const: :"audio.voice"

        # @!attribute type
        #   How the voice was created.
        #
        #   @return [Symbol, OpenAI::Models::Audio::Voice::Type]
        required :type, enum: -> { OpenAI::Audio::Voice::Type }

        # @!method initialize(id:, created_at:, name:, type:, object: :"audio.voice")
        #   A custom voice that can be used for audio output.
        #
        #   @param id [String]
        #     The voice identifier, which can be referenced in API endpoints.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp (in seconds) for when the voice was created.
        #
        #   @param name [String]
        #     The name of the voice.
        #
        #   @param type [Symbol, OpenAI::Models::Audio::Voice::Type]
        #     How the voice was created.
        #
        #   @param object [Symbol, :"audio.voice"]
        #     The object type, which is always `audio.voice`.

        # How the voice was created.
        #
        # @see OpenAI::Models::Audio::Voice#type
        module Type
          extend OpenAI::Internal::Type::Enum

          AUDIO_SAMPLE = :audio_sample

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
