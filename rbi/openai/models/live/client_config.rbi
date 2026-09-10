# typed: strong

module OpenAI
  module Models

    module Live

      class ClientConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ClientConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # Client and server event permissions for the WebRTC frontend data channel.
        sig { returns(OpenAI::Live::DataChannelConfig) }
        attr_reader :data_channel

        sig { params(data_channel: OpenAI::Live::DataChannelConfig::OrHash).void }
        attr_writer :data_channel

        # Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        # session. Trusted sideband connections are unaffected.
        sig do
          params(

            data_channel: OpenAI::Live::DataChannelConfig::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Client and server event permissions for the WebRTC frontend data channel.

          data_channel:
        )
        end

        sig do
          override.returns(
            {data_channel: OpenAI::Live::DataChannelConfig}
          )
        end
        def to_hash
        end

      end

    end

  end
end
