# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::VoiceConsents#create
      class VoiceConsent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The consent recording identifier.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) for when the consent recording was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute language
        #   The BCP 47 language tag for the consent phrase (for example, `en-US`).
        #
        #   @return [String]
        required :language, String

        # @!attribute name
        #   The label provided when the consent recording was uploaded.
        #
        #   @return [String]
        required :name, String

        # @!attribute object
        #   The object type, which is always `audio.voice_consent`.
        #
        #   @return [Symbol, :"audio.voice_consent"]
        required :object, const: :"audio.voice_consent"

        # @!method initialize(id:, created_at:, language:, name:, object: :"audio.voice_consent")
        #   A consent recording used to authorize creation of a custom voice.
        #
        #   @param id [String]
        #     The consent recording identifier.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp (in seconds) for when the consent recording was created.
        #
        #   @param language [String]
        #     The BCP 47 language tag for the consent phrase (for example, `en-US`).
        #
        #   @param name [String]
        #     The label provided when the consent recording was uploaded.
        #
        #   @param object [Symbol, :"audio.voice_consent"]
        #     The object type, which is always `audio.voice_consent`.
      end
    end
  end
end
