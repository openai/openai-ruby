# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionUpdateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Translation session fields to update. The session `type` and `model` are set at
        #   creation and cannot be changed with `session.update`.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest]
        required :session, -> { OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest }

        # @!attribute type
        #   The event type, must be `session.update`.
        #
        #   @return [Symbol, :"session.update"]
        required :type, const: :"session.update"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(session:, event_id: nil, type: :"session.update")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateEvent} for more
        #   details.
        #
        #   Send this event to update the translation session configuration. Translation
        #   sessions support updates to `audio.output.language`,
        #   `audio.input.transcription`, and `audio.input.noise_reduction`.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest] Translation session fields to update. The session `type` and `model` are set
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"session.update"] The event type, must be `session.update`.
      end
    end
  end
end
