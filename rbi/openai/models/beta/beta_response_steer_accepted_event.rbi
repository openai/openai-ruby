# typed: strong

module OpenAI
  module Models

    BetaResponseSteerAcceptedEvent = Beta::BetaResponseSteerAcceptedEvent

    module Beta

      class BetaResponseSteerAcceptedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseSteerAcceptedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The accepted steering submission.
        sig { returns(OpenAI::Beta::BetaResponseSteerAcceptedEvent::Steer) }
        attr_reader :steer

        sig { params(steer: OpenAI::Beta::BetaResponseSteerAcceptedEvent::Steer::OrHash).void }
        attr_writer :steer

        # The event discriminator. Always `response.steer.accepted`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The WebSocket lane that emitted this event. This field is present when the
        # target response's `response.create` event supplied a `stream_id`.
        sig { returns(T.nilable(String)) }
        attr_reader :stream_id

        sig { params(stream_id: String).void }
        attr_writer :stream_id

        # Emitted when steering input has been validated and queued. Acceptance means the
        # server owns the input, not that it has been applied. The successor's
        # `response.created` event is the commit point. If accepted input cannot be
        # committed, `response.steer.failed` returns it with the same steering ID.
        #
        # When the response stops for client-owned tool output or approval, the input
        # remains queued and `response.steer.pending` is emitted after
        # `response.completed`. Fill the pending event's `required_input` stubs with saved
        # results and send one matching explicit `response.create` per parent. Do not
        # resend accepted input while it is still queued.
        sig do
          params(

            sequence_number: Integer,

            steer: OpenAI::Beta::BetaResponseSteerAcceptedEvent::Steer::OrHash,

            stream_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The sequence number for this event.
          sequence_number:,

          # The accepted steering submission.
          steer:,

          # The WebSocket lane that emitted this event. This field is present when the
          # target response's `response.create` event supplied a `stream_id`.
          stream_id: nil,

          # The event discriminator. Always `response.steer.accepted`.

          type: :"response.steer.accepted"
        )
        end

        sig do
          override.returns(
            {
              sequence_number: Integer,
              steer: OpenAI::Beta::BetaResponseSteerAcceptedEvent::Steer,
              type: Symbol,
              stream_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        class Steer < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerAcceptedEvent::Steer,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID assigned to the steering submission.
          sig { returns(String) }
          attr_accessor :id

          # The ID of the response being steered.
          sig { returns(String) }
          attr_accessor :previous_response_id

          # The accepted steering submission.
          sig do
            params(

              id: String,

              previous_response_id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID assigned to the steering submission.
            id:,

            # The ID of the response being steered.

            previous_response_id:
          )
          end

          sig do
            override.returns(
              {id: String, previous_response_id: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
