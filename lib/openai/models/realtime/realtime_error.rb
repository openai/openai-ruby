# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeError < OpenAI::Internal::Type::BaseModel
        # @!attribute message
        #   A human-readable error message.
        #
        #   @return [String]
        required :message, String

        # @!attribute type
        #   The type of error (e.g., "invalid_request_error", "server_error").
        #
        #   @return [String]
        required :type, String

        # @!attribute code
        #   Error code, if any.
        #
        #   @return [String, nil]
        optional :code, String, nil?: true

        # @!attribute event_id
        #   The event_id of the client event that caused the error, if applicable.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!attribute param
        #   Parameter related to the error, if any.
        #
        #   @return [String, nil]
        optional :param, String, nil?: true

        # @!method initialize(message:, type:, code: nil, event_id: nil, param: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeError} for more details.
        #
        #   Details of the error.
        #
        #   @param message [String] A human-readable error message.
        #
        #   @param type [String] The type of error (e.g., "invalid_request_error", "server_error").
        #
        #   @param code [String, nil] Error code, if any.
        #
        #   @param event_id [String, nil] The event_id of the client event that caused the error, if applicable.
        #
        #   @param param [String, nil] Parameter related to the error, if any.
      end
    end
  end
end
