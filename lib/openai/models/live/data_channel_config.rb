# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DataChannelConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute allowed_client_events
        #   Client event types that the frontend data channel may send. Use 'all' to allow
        #   every client event; an empty array allows none. Omission preserves the existing
        #   allow-all behavior.
        #
        #   @return [Symbol, :all, Array<String>, nil]
        optional :allowed_client_events, union: -> { OpenAI::Live::DataChannelConfig::AllowedClientEvents }

        # @!attribute allowed_server_events
        #   Server events that may be sent to the frontend data channel. Use 'all' to allow
        #   every server event; an empty array allows none. Omission preserves the existing
        #   allow-all behavior. Responses events use an object with type 'response.event'
        #   and a response_event selector.
        #
        #   @return [Symbol, :all, Array<OpenAI::Models::Live::ServerEventSelector>, nil]
        optional :allowed_server_events, union: -> { OpenAI::Live::DataChannelConfig::AllowedServerEvents }

        # @!method initialize(allowed_client_events: nil, allowed_server_events: nil)
        #   Control which Live events an untrusted WebRTC frontend can send and receive over
        #   its data channel. These restrictions do not apply to trusted sideband
        #   connections.
        #
        #   @param allowed_client_events [Symbol, :all, Array<String>]
        #     Client event types that the frontend data channel may send. Use 'all' to allow
        #     every client event; an empty array allows none. Omission preserves the existing
        #     allow-all behavior.
        #
        #   @param allowed_server_events [Symbol, :all, Array<OpenAI::Models::Live::ServerEventSelector>]
        #     Server events that may be sent to the frontend data channel. Use 'all' to allow
        #     every server event; an empty array allows none. Omission preserves the existing
        #     allow-all behavior. Responses events use an object with type 'response.event'
        #     and a response_event selector.

        # Client event types that the frontend data channel may send. Use 'all' to allow
        # every client event; an empty array allows none. Omission preserves the existing
        # allow-all behavior.
        #
        # @see OpenAI::Models::Live::DataChannelConfig#allowed_client_events
        module AllowedClientEvents
          extend OpenAI::Internal::Type::Union

          variant const: :all

          variant -> { OpenAI::Models::Live::DataChannelConfig::AllowedClientEvents::StringArray }

          # @!method self.variants
          #   @return [Array(Symbol, :all, Array<String>)]

          # @type [OpenAI::Internal::Type::Converter]
          StringArray = OpenAI::Internal::Type::ArrayOf[String]
        end

        # Server events that may be sent to the frontend data channel. Use 'all' to allow
        # every server event; an empty array allows none. Omission preserves the existing
        # allow-all behavior. Responses events use an object with type 'response.event'
        # and a response_event selector.
        #
        # @see OpenAI::Models::Live::DataChannelConfig#allowed_server_events
        module AllowedServerEvents
          extend OpenAI::Internal::Type::Union

          variant const: :all

          variant -> { OpenAI::Models::Live::DataChannelConfig::AllowedServerEvents::ServerEventSelectorArray }

          # @!method self.variants
          #   @return [Array(Symbol, :all, Array<OpenAI::Models::Live::ServerEventSelector>)]

          # @type [OpenAI::Internal::Type::Converter]
          ServerEventSelectorArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::Live::ServerEventSelector }]
        end
      end
    end
  end
end
