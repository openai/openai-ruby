# typed: strong

module OpenAI
  module Resources

    class Audio

      # Turn audio into text or text into audio.
      class VoiceConsents

        # Upload a voice consent recording.
        sig {
          params(
            language: String,
            name: String,
            recording: OpenAI::Internal::FileInput,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Audio::VoiceConsent)
        }
        def create(
          # The BCP 47 language tag for the consent phrase (for example, `en-US`).
          language:,
          # The label to use for this consent recording.
          name:,
          # The consent audio recording file. Maximum size is 10 MiB.
          #
          # Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
          # `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
          #
          # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
          # metadata. Use `OpenAI::FilePart` when you need to override the filename or
          # content type.
          recording:,
          request_options: {}
        )
        end

        # Retrieves a voice consent recording.
        sig {
          params(consent_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
            OpenAI::Audio::VoiceConsent
          )
        }
        def retrieve(
          # The ID of the consent recording to retrieve.
          consent_id,
          request_options: {}
        )
        end

        # Updates a voice consent recording (metadata only).
        sig {
          params(consent_id: String, name: String, request_options: OpenAI::RequestOptions::OrHash).returns(
            OpenAI::Audio::VoiceConsent
          )
        }
        def update(
          # The ID of the consent recording to update.
          consent_id,
          # The updated label for this consent recording.
          name:,
          request_options: {}
        )
        end

        # Returns a list of voice consent recordings.
        sig {
          params(after: String, limit: Integer, request_options: OpenAI::RequestOptions::OrHash).returns(
            OpenAI::Internal::CursorPage[OpenAI::Audio::VoiceConsent]
          )
        }
        def list(
          # A cursor for use in pagination. `after` is an object ID that defines your place
          # in the list. For instance, if you make a list request and receive 100 objects,
          # ending with obj_foo, your subsequent call can include after=obj_foo in order to
          # fetch the next page of the list.
          after: nil,
          # A limit on the number of objects to be returned. Limit can range between 1 and
          # 100, and the default is 20.
          limit: nil,
          request_options: {}
        )
        end

        # Deletes a voice consent recording.
        sig {
          params(consent_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
            OpenAI::Audio::VoiceConsentDeleted
          )
        }
        def delete(
          # The ID of the consent recording to delete.
          consent_id,
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
