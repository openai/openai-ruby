# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::VoiceConsents#update
      class VoiceConsentUpdateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute consent_id
        #
        #   @return [String]
        required :consent_id, String

        # @!attribute name
        #   The updated label for this consent recording.
        #
        #   @return [String]
        required :name, String

        # @!method initialize(consent_id:, name:, request_options: {})
        #   @param consent_id [String]
        #
        #   @param name [String]
        #     The updated label for this consent recording.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
