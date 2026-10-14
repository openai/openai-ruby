# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ClientConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute data_channel
        #   Client and server event permissions for the WebRTC frontend data channel.
        #
        #   @return [OpenAI::Models::Live::DataChannelConfig]
        required :data_channel, -> { OpenAI::Live::DataChannelConfig }

        # @!method initialize(data_channel:)
        #   Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        #   session. Trusted sideband connections are unaffected.
        #
        #   @param data_channel [OpenAI::Models::Live::DataChannelConfig]
        #     Client and server event permissions for the WebRTC frontend data channel.
      end
    end
  end
end
