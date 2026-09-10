# typed: strong

module OpenAI
  module Models

    module Live

      class ServerEventSelector < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ServerEventSelector,
            OpenAI::Internal::AnyHash
          )
        end

        # The outer Live server event type. Use 'response.event' for Responses events.
        sig { returns(String) }
        attr_accessor :type

        # The nested Responses event type. Required when type is 'response.event';
        # forbidden for other event types.
        sig { returns(T.nilable(String)) }
        attr_reader :response_event

        sig { params(response_event: String).void }
        attr_writer :response_event

        # A Live server event selector for the WebRTC frontend data channel.
        sig do
          params(

            type: String,

            response_event: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The outer Live server event type. Use 'response.event' for Responses events.
          type:,

          # The nested Responses event type. Required when type is 'response.event';
          # forbidden for other event types.

          response_event: nil
        )
        end

        sig do
          override.returns(
            {type: String, response_event: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
