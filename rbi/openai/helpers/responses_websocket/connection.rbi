# typed: strong

module OpenAI
  module Models
    module Responses
      class Connection
        include Enumerable

        ServerEvent = T.type_alias do
          T.any(
            OpenAI::Responses::ResponsesServerEvent::Variants,
            OpenAI::Responses::UnknownServerEvent
          )
        end

        ClientEvent = T.type_alias do
          T.any(
            OpenAI::Responses::ResponsesClientEvent::Variants,
            OpenAI::Internal::AnyHash
          )
        end

        Elem = type_member { {fixed: ServerEvent} }

        sig { returns(URI::Generic) }
        attr_reader :url

        sig { returns(OpenAI::Responses::ConnectionResources::Response) }
        attr_reader :response

        # @api private
        sig { params(socket: T.anything, url: URI::Generic).returns(T.attached_class) }
        def self.new(socket:, url:)
        end

        sig do
          params(block: T.nilable(T.proc.params(event: ServerEvent).void)).returns(
            T.any(OpenAI::Responses::Connection, T::Enumerator[ServerEvent])
          )
        end
        def each(&block)
        end

        sig { returns(T.nilable(ServerEvent)) }
        def receive
        end

        # @api private
        sig { returns(T.nilable(String)) }
        def receive_raw
        end

        sig { params(event: ClientEvent).void }
        def send_event(event)
        end

        # @api private
        sig { params(data: String).void }
        def send_raw(data)
        end

        sig { params(code: Integer, reason: String).void }
        def close(code: 1000, reason: "")
        end

        # @api private
        sig { void }
        def abort
        end

        sig { returns(T::Boolean) }
        def closed?
        end

        # @api private
        sig { returns(T::Boolean) }
        def poisoned?
        end
      end
    end
  end
end
