# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class MediaSessionForkConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute client
        #   Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        #   session. Trusted sideband connections are unaffected.
        #
        #   @return [OpenAI::Models::Live::ClientConfig, nil]
        optional :client, -> { OpenAI::Live::ClientConfig }

        # @!attribute delegation
        #   Update the Responses backend for an existing Live session without changing
        #   delegation ownership.
        #
        #   @return [OpenAI::Models::Live::MediaSessionForkConfig::Delegation, nil]
        optional :delegation, -> { OpenAI::Live::MediaSessionForkConfig::Delegation }

        # @!attribute store
        #   Whether to store the forked session. Omission inherits the stored session's
        #   setting.
        #
        #   @return [Boolean, nil]
        optional :store, OpenAI::Internal::Type::Boolean

        # @!method initialize(client: nil, delegation: nil, store: nil)
        #   Optional overrides for a stored Live session. Omitted settings are inherited.
        #   The model, voice, frontend instructions, and prior conversation come from the
        #   stored session. WebRTC negotiates its audio format; audio.format is only
        #   supported on WebSocket forks.
        #
        #   @param client [OpenAI::Models::Live::ClientConfig]
        #     Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        #     session. Trusted sideband connections are unaffected.
        #
        #   @param delegation [OpenAI::Models::Live::MediaSessionForkConfig::Delegation]
        #     Update the Responses backend for an existing Live session without changing
        #     delegation ownership.
        #
        #   @param store [Boolean]
        #     Whether to store the forked session. Omission inherits the stored session's
        #     setting.

        # @see OpenAI::Models::Live::MediaSessionForkConfig#delegation
        class Delegation < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The delegation owner. Always `responses` for tasks handled by the Responses API.
          #
          #   @return [Symbol, :responses]
          required :type, const: :responses

          # @!attribute responses
          #   Responses backend settings to update. Omitted settings keep their existing
          #   values.
          #
          #   @return [OpenAI::Models::Live::ResponsesDelegationUpdateConfig, nil]
          optional :responses, -> { OpenAI::Live::ResponsesDelegationUpdateConfig }

          # @!method initialize(responses: nil, type: :responses)
          #   Update the Responses backend for an existing Live session without changing
          #   delegation ownership.
          #
          #   @param responses [OpenAI::Models::Live::ResponsesDelegationUpdateConfig]
          #     Responses backend settings to update. Omitted settings keep their existing
          #     values.
          #
          #   @param type [Symbol, :responses]
          #     The delegation owner. Always `responses` for tasks handled by the Responses API.
        end
      end
    end
  end
end
