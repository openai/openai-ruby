# typed: strong

module OpenAI
  module Models

    module Live

      # Server events for Live. Response lifecycle events are wrapped inside
      # response.event; dispatch the nested event by its full type and tolerate new
      # response event types. Follow the
      # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting)
      # when designing the conversation and delegation policy.
      module ServerEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::SessionStartedEvent,
            OpenAI::Live::SessionUpdatedEvent,
            OpenAI::Live::InputAudioMutedEvent,
            OpenAI::Live::InputAudioUnmutedEvent,
            OpenAI::Live::InstructionsAppendedEvent,
            OpenAI::Live::ThinkingAppendedEvent,
            OpenAI::Live::CommentaryAppendedEvent,
            OpenAI::Live::ServerEvent::SessionInputAudioAppend,
            OpenAI::Live::OutputAudioDeltaEvent,
            OpenAI::Live::InputTranscriptDeltaEvent,
            OpenAI::Live::OutputTranscriptDeltaEvent,
            OpenAI::Live::DelegationCreatedEvent,
            OpenAI::Live::ResponseEvent,
            OpenAI::Live::SessionUsageUpdatedEvent,
            OpenAI::Live::SessionClosedEvent,
            OpenAI::Live::ErrorEvent,
            OpenAI::Live::InfoEvent,
            OpenAI::Live::ServerEvent::TransportDtmfReceived,
            OpenAI::Live::ServerEvent::TransportDtmfSend,
            OpenAI::Live::ServerEvent::TransportRinging,
            OpenAI::Live::ServerEvent::TransportAnswered,
            OpenAI::Live::ServerEvent::TransportFailed
          )
        end

        class SessionInputAudioAppend < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ServerEvent::SessionInputAudioAppend,
              OpenAI::Internal::AnyHash
            )
          end

          # Base64-encoded raw mono PCM16LE at 24 kHz received from the primary transport,
          # reflected to the sideband before model-input muting. This server event uses the
          # same audio key as the client command, but is not an acknowledgment of it.
          sig { returns(String) }
          attr_accessor :audio

          # The event type, always `session.input_audio.append`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Input audio received from the primary transport and reflected to a Live sideband
          # connection before model-input muting.
          sig do
            params(

              audio: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Base64-encoded raw mono PCM16LE at 24 kHz received from the primary transport,
            # reflected to the sideband before model-input muting. This server event uses the
            # same audio key as the client command, but is not an acknowledgment of it.
            audio:,

            # The event type, always `session.input_audio.append`.

            type: :"session.input_audio.append"
          )
          end

          sig do
            override.returns(
              {audio: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class TransportDtmfReceived < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ServerEvent::TransportDtmfReceived,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :event

          sig { returns(String) }
          attr_accessor :event_id

          sig { returns(Symbol) }
          attr_accessor :type

          # A SIP DTMF keypress received from the caller. Delivered only to sideband
          # observers.
          sig do
            params(

              event: String,

              event_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            event:,

            event_id:,

            type: :"transport.dtmf.received"
          )
          end

          sig do
            override.returns(
              {event: String, event_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class TransportDtmfSend < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ServerEvent::TransportDtmfSend,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :event

          sig { returns(String) }
          attr_accessor :event_id

          sig { returns(Symbol) }
          attr_accessor :type

          # A SIP DTMF keypress successfully sent by the hosted tool. Delivered only to
          # sideband observers; this is not a client command.
          sig do
            params(

              event: String,

              event_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            event:,

            event_id:,

            type: :"transport.dtmf.send"
          )
          end

          sig do
            override.returns(
              {event: String, event_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class TransportRinging < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ServerEvent::TransportRinging,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :event_id

          # The canonical Live session ID.
          sig { returns(String) }
          attr_accessor :session_id

          sig { returns(Symbol) }
          attr_accessor :type

          # The outbound SIP provider leg is ringing or providing early media. Delivered
          # only to sideband observers.
          sig do
            params(

              event_id: String,

              session_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            event_id:,

            # The canonical Live session ID.
            session_id:,

            type: :"transport.ringing"
          )
          end

          sig do
            override.returns(
              {event_id: String, session_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class TransportAnswered < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ServerEvent::TransportAnswered,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :event_id

          # The canonical Live session ID.
          sig { returns(String) }
          attr_accessor :session_id

          sig { returns(Symbol) }
          attr_accessor :type

          # The outbound SIP provider leg answered and media is established. Delivered only
          # to sideband observers.
          sig do
            params(

              event_id: String,

              session_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            event_id:,

            # The canonical Live session ID.
            session_id:,

            type: :"transport.answered"
          )
          end

          sig do
            override.returns(
              {event_id: String, session_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class TransportFailed < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ServerEvent::TransportFailed,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(OpenAI::Live::ServerEvent::TransportFailed::Error) }
          attr_reader :error

          sig { params(error: OpenAI::Live::ServerEvent::TransportFailed::Error::OrHash).void }
          attr_writer :error

          sig { returns(String) }
          attr_accessor :event_id

          # The canonical Live session ID.
          sig { returns(String) }
          attr_accessor :session_id

          sig { returns(Symbol) }
          attr_accessor :type

          # An asynchronous outbound SIP setup failure. Delivered only to sideband
          # observers.
          sig do
            params(

              error: OpenAI::Live::ServerEvent::TransportFailed::Error::OrHash,

              event_id: String,

              session_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            error:,

            event_id:,

            # The canonical Live session ID.
            session_id:,

            type: :"transport.failed"
          )
          end

          sig do
            override.returns(
              {
                error: OpenAI::Live::ServerEvent::TransportFailed::Error,
                event_id: String,
                session_id: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class Error < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::ServerEvent::TransportFailed::Error,
                OpenAI::Internal::AnyHash
              )
            end

            # The call setup failure code.
            sig { returns(String) }
            attr_accessor :code

            sig { returns(String) }
            attr_accessor :message

            sig { returns(Symbol) }
            attr_accessor :type

            # The parameter related to the error, if any. Empty when no parameter applies.
            sig { returns(T.nilable(String)) }
            attr_reader :param

            sig { params(param: String).void }
            attr_writer :param

            sig do
              params(

                code: String,

                message: String,

                param: String,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The call setup failure code.
              code:,

              message:,

              # The parameter related to the error, if any. Empty when no parameter applies.
              param: nil,

              type: :call_error
            )
            end

            sig do
              override.returns(
                {code: String, message: String, type: Symbol, param: T.nilable(String)}
              )
            end
            def to_hash
            end

          end
        end

        sig { override.returns(T::Array[OpenAI::Live::ServerEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
