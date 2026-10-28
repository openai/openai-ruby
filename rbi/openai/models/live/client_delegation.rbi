# typed: strong

module OpenAI
  module Models

    module Live

      class ClientDelegation < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ClientDelegation,
            OpenAI::Internal::AnyHash
          )
        end

        # The delegation owner. Always `client` for tasks handled by your application.
        sig { returns(Symbol) }
        attr_accessor :type

        # Milliseconds to wait before requesting an automatic spoken acknowledgement for a
        # delegation. The model may still speak before this delay. Any commentary or
        # thinking appended to the session cancels all pending acknowledgements, including
        # those for other delegations. Defaults to 400 for Decisions sessions and 0
        # (request immediately) for other sessions. Omission in a session update preserves
        # the current value. Updates apply to subsequent delegations.
        sig { returns(T.nilable(Integer)) }
        attr_reader :acknowledgement_delay_ms

        sig { params(acknowledgement_delay_ms: Integer).void }
        attr_writer :acknowledgement_delay_ms

        # Delegate tasks to your application. The Live session emits delegation events
        # that your backend handles.
        sig do
          params(

            acknowledgement_delay_ms: Integer,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Milliseconds to wait before requesting an automatic spoken acknowledgement for a
          # delegation. The model may still speak before this delay. Any commentary or
          # thinking appended to the session cancels all pending acknowledgements, including
          # those for other delegations. Defaults to 400 for Decisions sessions and 0
          # (request immediately) for other sessions. Omission in a session update preserves
          # the current value. Updates apply to subsequent delegations.
          acknowledgement_delay_ms: nil,

          # The delegation owner. Always `client` for tasks handled by your application.

          type: :client
        )
        end

        sig do
          override.returns(
            {type: Symbol, acknowledgement_delay_ms: Integer}
          )
        end
        def to_hash
        end

      end

    end

  end
end
