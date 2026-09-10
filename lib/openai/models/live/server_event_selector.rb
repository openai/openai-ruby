# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ServerEventSelector < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The outer Live server event type. Use 'response.event' for Responses events.
        #
        #   @return [String]
        required :type, String

        # @!attribute response_event
        #   The nested Responses event type. Required when type is 'response.event';
        #   forbidden for other event types.
        #
        #   @return [String, nil]
        optional :response_event, String

        # @!method initialize(type:, response_event: nil)
        #   A Live server event selector for the WebRTC frontend data channel.
        #
        #   @param type [String]
        #     The outer Live server event type. Use 'response.event' for Responses events.
        #
        #   @param response_event [String]
        #     The nested Responses event type. Required when type is 'response.event';
        #     forbidden for other event types.
      end
    end
  end
end
