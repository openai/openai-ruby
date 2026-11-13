# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionErrorEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute error
        #   The error that occurred.
        #
        #   @return [OpenAI::Models::Beta::SessionError]
        required :error, -> { OpenAI::Beta::SessionError }

        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute type
        #   The type of the object. Always `error`.
        #
        #   @return [Symbol, :error]
        required :type, const: :error

        # @!attribute obfuscation
        #   Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(error:, event_id:, session_id:, obfuscation: nil, type: :error)
        #   Emitted when a turn or session fails.
        #
        #   @param error [OpenAI::Models::Beta::SessionError]
        #     The error that occurred.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param obfuscation [String]
        #     Random alphanumeric padding. Present when stream obfuscation is enabled.
        #
        #   @param type [Symbol, :error]
        #     The type of the object. Always `error`.
      end
    end
  end
end
