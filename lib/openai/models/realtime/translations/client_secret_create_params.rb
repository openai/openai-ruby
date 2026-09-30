# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      module Translations
        # @see OpenAI::Resources::Realtime::Translations::ClientSecrets#create
        class ClientSecretCreateParams < OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!method initialize(session:, expires_after: nil, request_options: {})
          #   @param session [OpenAI::Models::Realtime::RealtimeTranslationSessionCreateRequest]
          #     Realtime translation session configuration. Translation sessions stream source
          #     audio in and translated audio plus transcript deltas out continuously.
          #
          #   @param expires_after [OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter]
          #     Configuration for the client secret expiration. Expiration refers to the time
          #     after which a client secret will no longer be valid for creating sessions. The
          #     session itself may continue after that time once started. A secret can be used
          #     to create multiple sessions until it expires.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
