# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class Error < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   A machine-readable code identifying the Live error, such as `unknown_parameter`.
        #
        #   @return [String]
        required :code, String

        # @!attribute message
        #   A human-readable explanation of the Live error.
        #
        #   @return [String]
        required :message, String

        # @!attribute type
        #   The category of error, such as `invalid_request_error` for an invalid Live
        #   client command.
        #
        #   @return [String]
        required :type, String

        # @!attribute client_event_id
        #   The event_id of the client command that caused the error, when supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!attribute param
        #   The parameter that caused the error, when applicable, such as `session.voice`.
        #
        #   @return [String, nil]
        optional :param, String

        # @!method initialize(code:, message:, type:, client_event_id: nil, param: nil)
        #   Details of an error encountered by the Live session, including the affected
        #   parameter or client command when available.
        #
        #   @param code [String]
        #     A machine-readable code identifying the Live error, such as `unknown_parameter`.
        #
        #   @param message [String]
        #     A human-readable explanation of the Live error.
        #
        #   @param type [String]
        #     The category of error, such as `invalid_request_error` for an invalid Live
        #     client command.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command that caused the error, when supplied.
        #
        #   @param param [String]
        #     The parameter that caused the error, when applicable, such as `session.voice`.
      end
    end
  end
end
