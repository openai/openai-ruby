# typed: strong

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
        sig {
          params(
            body: T.any(
              OpenAI::Audio::VoiceCreateParams::Body::AudioSample::OrHash,
              OpenAI::Audio::VoiceCreateParams::Body::Prompt::OrHash
            ),
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

        # Deletes a voice created from a text prompt or an audio sample.
        #
        # Requires voice write permission and access to the voice's project. Access to
        # voices created from recordings is limited to eligible customers. See the
        # [custom voices guide](https://developers.openai.com/api/docs/guides/custom-voices).
        #
        # Deleting a voice does not delete its consent recording. Deleting an already
        # deleted voice returns a 404 error.
        sig {
          params(voice_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::Audio::VoiceDeleted)
        }
        def delete(
          # The ID of the voice to delete.
          voice_id,
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
