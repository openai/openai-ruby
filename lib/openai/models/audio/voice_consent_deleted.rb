# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::VoiceConsents#delete
      class VoiceConsentDeleted < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The consent recording identifier.
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #
        #   @return [Boolean]
        required :deleted, OpenAI::Internal::Type::Boolean

        # @!attribute object
        #
        #   @return [Symbol, :"audio.voice_consent"]
        required :object, const: :"audio.voice_consent"

        # @!method initialize(id:, deleted:, object: :"audio.voice_consent")
        #   @param id [String]
        #     The consent recording identifier.
        #
        #   @param deleted [Boolean]
        #
        #   @param object [Symbol, :"audio.voice_consent"]
      end
    end
  end
end
