# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Voices#delete
      class VoiceDeleted < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The voice identifier.
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #   Whether the voice was deleted.
        #
        #   @return [Boolean]
        required :deleted, OpenAI::Internal::Type::Boolean

        # @!attribute object
        #   The object type, which is always `audio.voice.deleted`.
        #
        #   @return [Symbol, :"audio.voice.deleted"]
        required :object, const: :"audio.voice.deleted"

        # @!method initialize(id:, deleted:, object: :"audio.voice.deleted")
        #   @param id [String]
        #     The voice identifier.
        #
        #   @param deleted [Boolean]
        #     Whether the voice was deleted.
        #
        #   @param object [Symbol, :"audio.voice.deleted"]
        #     The object type, which is always `audio.voice.deleted`.
      end
    end
  end
end
