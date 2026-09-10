# typed: strong

module OpenAI
  module Models

    module Live

      class DataChannelConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DataChannelConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # Client event types that the frontend data channel may send. Use 'all' to allow
        # every client event; an empty array allows none. Omission preserves the existing
        # allow-all behavior.
        sig { returns(T.nilable(OpenAI::Live::DataChannelConfig::AllowedClientEvents::Variants)) }
        attr_reader :allowed_client_events

        sig { params(allowed_client_events: OpenAI::Live::DataChannelConfig::AllowedClientEvents::Variants).void }
        attr_writer :allowed_client_events

        # Server events that may be sent to the frontend data channel. Use 'all' to allow
        # every server event; an empty array allows none. Omission preserves the existing
        # allow-all behavior. Responses events use an object with type 'response.event'
        # and a response_event selector.
        sig { returns(T.nilable(T.any(Symbol, T::Array[OpenAI::Live::ServerEventSelector]))) }
        attr_reader :allowed_server_events

        sig { params(allowed_server_events: T.any(Symbol, T::Array[OpenAI::Live::ServerEventSelector::OrHash])).void }
        attr_writer :allowed_server_events

        # Control which Live events an untrusted WebRTC frontend can send and receive over
        # its data channel. These restrictions do not apply to trusted sideband
        # connections.
        sig do
          params(

            allowed_client_events: OpenAI::Live::DataChannelConfig::AllowedClientEvents::Variants,

            allowed_server_events: T.any(Symbol, T::Array[OpenAI::Live::ServerEventSelector::OrHash])
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Client event types that the frontend data channel may send. Use 'all' to allow
          # every client event; an empty array allows none. Omission preserves the existing
          # allow-all behavior.
          allowed_client_events: nil,

          # Server events that may be sent to the frontend data channel. Use 'all' to allow
          # every server event; an empty array allows none. Omission preserves the existing
          # allow-all behavior. Responses events use an object with type 'response.event'
          # and a response_event selector.

          allowed_server_events: nil
        )
        end

        sig do
          override.returns(
            {
              allowed_client_events: OpenAI::Live::DataChannelConfig::AllowedClientEvents::Variants,
              allowed_server_events: T.any(Symbol, T::Array[OpenAI::Live::ServerEventSelector])
            }
          )
        end
        def to_hash
        end

        # Client event types that the frontend data channel may send. Use 'all' to allow
        # every client event; an empty array allows none. Omission preserves the existing
        # allow-all behavior.
        module AllowedClientEvents
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, T::Array[String]) }

          sig { override.returns(T::Array[OpenAI::Live::DataChannelConfig::AllowedClientEvents::Variants]) }
          def self.variants
          end

          StringArray = T.let(
            OpenAI::Internal::Type::ArrayOf[String],
            OpenAI::Internal::Type::Converter
          )

        end

        # Server events that may be sent to the frontend data channel. Use 'all' to allow
        # every server event; an empty array allows none. Omission preserves the existing
        # allow-all behavior. Responses events use an object with type 'response.event'
        # and a response_event selector.
        module AllowedServerEvents
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, T::Array[OpenAI::Live::ServerEventSelector]) }

          sig { override.returns(T::Array[OpenAI::Live::DataChannelConfig::AllowedServerEvents::Variants]) }
          def self.variants
          end

          ServerEventSelectorArray = T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::Live::ServerEventSelector],
            OpenAI::Internal::Type::Converter
          )

        end

      end

    end

  end
end
