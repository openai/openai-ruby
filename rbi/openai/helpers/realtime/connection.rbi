# typed: strong

module OpenAI
  module Models
    module Realtime
      class Connection < OpenAI::Realtime::BaseConnection
        include Enumerable

        ServerEvent =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeServerEvent::Variants,
              OpenAI::Realtime::UnknownServerEvent
            )
          end

        ClientEvent =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeClientEvent::Variants,
              OpenAI::Internal::AnyHash
            )
          end

        Elem = type_member { { fixed: ServerEvent } }

        sig { returns(OpenAI::Realtime::ConnectionResources::Session) }
        attr_reader :session

        sig { returns(OpenAI::Realtime::ConnectionResources::Response) }
        attr_reader :response

        sig { returns(OpenAI::Realtime::ConnectionResources::InputAudioBuffer) }
        attr_reader :input_audio_buffer

        sig { returns(OpenAI::Realtime::ConnectionResources::Conversation) }
        attr_reader :conversation

        # @api private
        sig do
          params(socket: T.untyped, url: URI::Generic).returns(T.attached_class)
        end
        def self.new(socket:, url:)
        end

        sig do
          params(
            block: T.nilable(T.proc.params(event: ServerEvent).void)
          ).returns(
            T.any(OpenAI::Realtime::Connection, T::Enumerator[ServerEvent])
          )
        end
        def each(&block)
        end

        sig { returns(T.nilable(ServerEvent)) }
        def receive
        end

        sig { params(data: String).returns(ServerEvent) }
        def parse_event(data)
        end

        sig { params(event: ClientEvent).void }
        def send_event(event)
        end
      end
    end
  end
end
