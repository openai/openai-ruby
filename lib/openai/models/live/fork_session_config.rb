# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ForkSessionConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute audio
        #   Audio format for a WebSocket fork. WebRTC forks negotiate their audio format and
        #   must omit this field.
        #
        #   @return [OpenAI::Models::Live::ForkSessionConfig::Audio, nil]
        optional :audio, -> { OpenAI::Live::ForkSessionConfig::Audio }

        # @!attribute client
        #   Frontend data-channel permissions for a WebRTC fork. Omitted permissions inherit
        #   the stored values. Not supported for WebSocket forks.
        #
        #   @return [OpenAI::Models::Live::ClientConfig, nil]
        optional :client, -> { OpenAI::Live::ClientConfig }

        # @!attribute delegation
        #   Overrides for the stored session’s Responses backend. Only supported when the
        #   stored session already uses Responses delegation; the delegation type cannot
        #   change.
        #
        #   @return [OpenAI::Models::Live::ForkSessionConfig::Delegation, nil]
        optional :delegation, -> { OpenAI::Live::ForkSessionConfig::Delegation }

        # @!attribute store
        #   Whether to store the forked session. Omission inherits the stored session's
        #   setting.
        #
        #   @return [Boolean, nil]
        optional :store, OpenAI::Internal::Type::Boolean

        # @!method initialize(audio: nil, client: nil, delegation: nil, store: nil)
        #   Overrides for a stored session after connecting to the fork WebSocket. An empty
        #   object inherits the stored configuration; do not supply a new model.
        #   audio.format applies only to the new WebSocket connection. client overrides are
        #   only supported for WebRTC forks.
        #
        #   @param audio [OpenAI::Models::Live::ForkSessionConfig::Audio]
        #     Audio format for a WebSocket fork. WebRTC forks negotiate their audio format and
        #     must omit this field.
        #
        #   @param client [OpenAI::Models::Live::ClientConfig]
        #     Frontend data-channel permissions for a WebRTC fork. Omitted permissions inherit
        #     the stored values. Not supported for WebSocket forks.
        #
        #   @param delegation [OpenAI::Models::Live::ForkSessionConfig::Delegation]
        #     Overrides for the stored session’s Responses backend. Only supported when the
        #     stored session already uses Responses delegation; the delegation type cannot
        #     change.
        #
        #   @param store [Boolean]
        #     Whether to store the forked session. Omission inherits the stored session's
        #     setting.

        # @see OpenAI::Models::Live::ForkSessionConfig#audio
        class Audio < OpenAI::Internal::Type::BaseModel
          # @!attribute format_
          #   Audio encoding and sample rate for audio sent and received over a Live WebSocket
          #   connection. WebRTC and SIP negotiate their media format separately.
          #
          #   @return [OpenAI::Models::Live::AudioFormat::AudioPCM, OpenAI::Models::Live::AudioFormat::AudioPCMU, OpenAI::Models::Live::AudioFormat::AudioPCMA, nil]
          optional :format_, union: -> { OpenAI::Live::AudioFormat }, api_name: :format

          # @!method initialize(format_: nil)
          #   Audio format for a WebSocket fork. WebRTC forks negotiate their audio format and
          #   must omit this field.
          #
          #   @param format_ [OpenAI::Models::Live::AudioFormat::AudioPCM, OpenAI::Models::Live::AudioFormat::AudioPCMU, OpenAI::Models::Live::AudioFormat::AudioPCMA]
          #     Audio encoding and sample rate for audio sent and received over a Live WebSocket
          #     connection. WebRTC and SIP negotiate their media format separately.
        end

        # @see OpenAI::Models::Live::ForkSessionConfig#delegation
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
          #   Overrides for the stored session’s Responses backend. Only supported when the
          #   stored session already uses Responses delegation; the delegation type cannot
          #   change.
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
