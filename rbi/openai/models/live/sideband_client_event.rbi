# typed: strong

module OpenAI
  module Models

    module Live

      # Client events accepted by an attached Live sideband WebSocket. The session has
      # already started. Send input audio over the primary connection.
      module SidebandClientEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::SessionUpdateEvent,
            OpenAI::Live::InputAudioMuteEvent,
            OpenAI::Live::InputAudioUnmuteEvent,
            OpenAI::Live::OutputAudioFixturePlayEvent,
            OpenAI::Live::SidebandClientEvent::TransportDtmfSend,
            OpenAI::Live::InstructionsAppendEvent,
            OpenAI::Live::ThinkingAppendEvent,
            OpenAI::Live::CommentaryAppendEvent,
            OpenAI::Live::DecisionCreateEvent,
            OpenAI::Live::DecisionItemCreateEvent,
            OpenAI::Live::DecisionItemDeleteEvent,
            OpenAI::Live::ResponseItemCreateEvent,
            OpenAI::Live::ResponseCreateEvent,
            OpenAI::Live::SessionCloseEvent
          )
        end

        class TransportDtmfSend < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::SidebandClientEvent::TransportDtmfSend,
              OpenAI::Internal::AnyHash
            )
          end

          # The DTMF key to send: one of `0`–`9`, `A`–`D`, `*`, or `#`.
          sig { returns(String) }
          attr_accessor :event

          sig { returns(Symbol) }
          attr_accessor :type

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          sig { returns(T.nilable(String)) }
          attr_accessor :event_id

          # Send one DTMF keypress to the SIP trunk through a Live sideband connection. This
          # command is supported only for SIP calls. A successful send emits
          # `transport.dtmf.sent` on sideband. If you provide `event_id`, the success
          # notification includes it as `client_event_id`; a failure includes it as
          # `error.client_event_id`. Send separate events for multiple keypresses.
          sig do
            params(

              event: String,

              event_id: T.nilable(String),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The DTMF key to send: one of `0`–`9`, `A`–`D`, `*`, or `#`.
            event:,

            # Optional client identifier for correlating this command with a server event's
            # client_event_id or error.client_event_id.
            event_id: nil,

            type: :"transport.dtmf.send"
          )
          end

          sig do
            override.returns(
              {event: String, type: Symbol, event_id: T.nilable(String)}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Live::SidebandClientEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
