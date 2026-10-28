# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class VoiceConsents
        # Upload a voice consent recording.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        #
        # @overload create(language:, name:, recording:, request_options: {})
        #
        # @param language [String]
        #   The BCP 47 language tag for the consent phrase (for example, `en-US`).
        #
        # @param name [String]
        #   The label to use for this consent recording.
        #
        # @param recording [Pathname, StringIO, IO, String, OpenAI::FilePart]
        #   The consent audio recording file. Maximum size is 10 MiB.
        #
        #   Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
        #   `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
        #
        #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
        #   content type.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::VoiceConsent]
        #
        # @see OpenAI::Models::Audio::VoiceConsentCreateParams
        def create(params)
          parsed, options = OpenAI::Audio::VoiceConsentCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "audio/voice_consents",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Audio::VoiceConsent,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Retrieves a voice consent recording.
        #
        # @overload retrieve(consent_id, request_options: {})
        #
        # @param consent_id [String]
        #   The ID of the consent recording to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::VoiceConsent]
        #
        # @see OpenAI::Models::Audio::VoiceConsentRetrieveParams
        def retrieve(consent_id, params = {})
          @client.request(
            method: :get,
            path: ["audio/voice_consents/%1$s", consent_id],
            model: OpenAI::Audio::VoiceConsent,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # Updates a voice consent recording (metadata only).
        #
        # @overload update(consent_id, name:, request_options: {})
        #
        # @param consent_id [String]
        #   The ID of the consent recording to update.
        #
        # @param name [String]
        #   The updated label for this consent recording.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::VoiceConsent]
        #
        # @see OpenAI::Models::Audio::VoiceConsentUpdateParams
        def update(consent_id, params)
          parsed, options = OpenAI::Audio::VoiceConsentUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["audio/voice_consents/%1$s", consent_id],
            body: parsed,
            model: OpenAI::Audio::VoiceConsent,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Returns a list of voice consent recordings.
        #
        # @overload list(after: nil, limit: nil, request_options: {})
        #
        # @param after [String]
        #   A cursor for use in pagination. `after` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
        #   fetch the next page of the list.
        #
        # @param limit [Integer]
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Audio::VoiceConsent>]
        #
        # @see OpenAI::Models::Audio::VoiceConsentListParams
        def list(params = {})
          parsed, options = OpenAI::Audio::VoiceConsentListParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: "audio/voice_consents",
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Audio::VoiceConsent,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Deletes a voice consent recording.
        #
        # @overload delete(consent_id, request_options: {})
        #
        # @param consent_id [String]
        #   The ID of the consent recording to delete.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::VoiceConsentDeleted]
        #
        # @see OpenAI::Models::Audio::VoiceConsentDeleteParams
        def delete(consent_id, params = {})
          @client.request(
            method: :delete,
            path: ["audio/voice_consents/%1$s", consent_id],
            model: OpenAI::Audio::VoiceConsentDeleted,
            security: {bearer_auth: true},
            options: params[:request_options]
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
