# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class Voices
        # Create a custom voice you can use for audio output (for example, in
        # Text-to-Speech and the Realtime API). This requires an audio sample and a
        # previously uploaded consent recording.
        #
        # Send `name`, `audio_sample`, and the `consent` recording ID as multipart form
        # data. The optional `type` defaults to `audio_sample`.
        #
        # Returns the saved voice's metadata. See the
        # [custom voices guide](https://developers.openai.com/api/docs/guides/text-to-speech#custom-voices)
        # for requirements and best practices. Custom voices are limited to eligible
        # customers.
        #
        # @overload create(body:, request_options: {})
        #
        # @param body [OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample]
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
