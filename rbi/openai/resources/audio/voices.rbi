# typed: strong

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
        sig {
          params(
            body: OpenAI::Audio::VoiceCreateParams::Body::AudioSample::OrHash,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Audio::Voice)
        }
        def create(
          # Creates a voice from a consent recording and an audio sample. Requires
          # multipart/form-data.
          body:,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end
