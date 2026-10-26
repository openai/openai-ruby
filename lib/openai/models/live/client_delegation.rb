# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ClientDelegation < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The delegation owner. Always `client` for tasks handled by your application.
        #
        #   @return [Symbol, :client]
        required :type, const: :client

        # @!attribute acknowledgement_delay_ms
        #   Milliseconds to wait before requesting an automatic spoken acknowledgement for a
        #   delegation. The model may still speak before this delay. Any commentary or
        #   thinking appended to the session cancels all pending acknowledgements, including
        #   those for other delegations. Defaults to 400 for Decisions sessions and 0
        #   (request immediately) for other sessions. Omission in a session update preserves
        #   the current value. Updates apply to subsequent delegations.
        #
        #   @return [Integer, nil]
        optional :acknowledgement_delay_ms, Integer

        # @!method initialize(acknowledgement_delay_ms: nil, type: :client)
        #   Delegate tasks to your application. The Live session emits delegation events
        #   that your backend handles.
        #
        #   @param acknowledgement_delay_ms [Integer]
        #     Milliseconds to wait before requesting an automatic spoken acknowledgement for a
        #     delegation. The model may still speak before this delay. Any commentary or
        #     thinking appended to the session cancels all pending acknowledgements, including
        #     those for other delegations. Defaults to 400 for Decisions sessions and 0
        #     (request immediately) for other sessions. Omission in a session update preserves
        #     the current value. Updates apply to subsequent delegations.
        #
        #   @param type [Symbol, :client]
        #     The delegation owner. Always `client` for tasks handled by your application.
      end
    end
  end
end
