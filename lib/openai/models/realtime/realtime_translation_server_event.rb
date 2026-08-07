# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # A Realtime translation server event.
      module RealtimeTranslationServerEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Returned when an error occurs, which could be a client problem or a server
        # problem. Most errors are recoverable and the session will stay open, we
        # recommend to implementors to monitor and log error messages by default.
        variant :error, -> { OpenAI::Realtime::RealtimeErrorEvent }

        # Returned when a translation session is created. Emitted automatically when a
        # new connection is established as the first server event. This event contains
        # the default translation session configuration.
        variant :"session.created", -> { OpenAI::Realtime::RealtimeTranslationSessionCreatedEvent }

        # Returned when a translation session is updated with a `session.update` event,
        # unless there is an error.
        variant :"session.updated", -> { OpenAI::Realtime::RealtimeTranslationSessionUpdatedEvent }

        # Returned when a realtime translation session is closed.
        variant :"session.closed", -> { OpenAI::Realtime::RealtimeTranslationSessionClosedEvent }

        # Returned when optional source-language transcript text is available. This event
        # is emitted only when `audio.input.transcription` is configured.
        #
        # Transcript deltas are append-only text fragments. Clients should not insert
        # unconditional spaces between deltas.
        variant :"session.input_transcript.delta",
                -> { OpenAI::Realtime::RealtimeTranslationInputTranscriptDeltaEvent }

        # Returned when translated transcript text is available.
        #
        # Transcript deltas are append-only text fragments. Clients should not insert
        # unconditional spaces between deltas.
        variant :"session.output_transcript.delta",
                -> { OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent }

        # Returned when translated output audio is available. Output audio deltas are
        # 200 ms frames of PCM16 audio.
        variant :"session.output_audio.delta", -> { OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::RealtimeErrorEvent, OpenAI::Models::Realtime::RealtimeTranslationSessionCreatedEvent, OpenAI::Models::Realtime::RealtimeTranslationSessionUpdatedEvent, OpenAI::Models::Realtime::RealtimeTranslationSessionClosedEvent, OpenAI::Models::Realtime::RealtimeTranslationInputTranscriptDeltaEvent, OpenAI::Models::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent, OpenAI::Models::Realtime::RealtimeTranslationOutputAudioDeltaEvent)]
      end
    end
  end
end
