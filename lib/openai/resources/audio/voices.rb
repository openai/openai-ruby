# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class Voices
        # Creates a voice from a text prompt or from a consent recording and an audio
        # sample.
        #
        # For prompt-based creation, send `type: "prompt"` with a `name` and `prompt` as
        # JSON or multipart form data. For creation from an audio sample, send
        # `type: "audio_sample"` with a `name`, `audio_sample`, and `consent` recording ID
        # as multipart form data. The type defaults to `audio_sample` when omitted.
        #
        # Returns the saved voice's metadata. Voices created from text prompts are
        # supported only in Live, not in Realtime or the speech endpoint. The response
        # does not include preview audio.
        #
        # @overload create(body:, request_options: {})
        #
        # @param body [OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt]
        #   Creates a voice from a consent recording and an audio sample. Requires
        #   multipart/form-data.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::Voice]
        #
        # @see OpenAI::Models::Audio::VoiceCreateParams
        def create(params)
          parsed, options = OpenAI::Audio::VoiceCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "audio/voices",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed[:body],
            model: OpenAI::Audio::Voice,
            security: {bearer_auth: true},
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
