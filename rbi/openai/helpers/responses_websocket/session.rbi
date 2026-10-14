# typed: strong

module OpenAI
  module Models
    module Responses
      class SessionError < OpenAI::Errors::Error
        sig { returns(NilClass) }
        def cause
        end
      end

      class BufferError < SessionError
      end

      class StateLostError < SessionError
      end

      class RequestError < SessionError
        sig { returns(Connection::ServerEvent) }
        attr_reader :event

        # @api private
        sig { params(event: Connection::ServerEvent).returns(T.attached_class) }
        def self.new(event)
        end
      end

      class SessionLimits
        sig { returns(Integer) }
        attr_reader :max_lanes, :max_events_per_lane, :max_events, :max_bytes_per_lane, :max_bytes, :max_response_bytes

        sig do
          params(
            max_lanes: Integer,
            max_events_per_lane: Integer,
            max_events: Integer,
            max_bytes_per_lane: Integer,
            max_bytes: Integer,
            max_response_bytes: Integer
          )
            .returns(T.attached_class)
        end
        def self.new(
          max_lanes:,
          max_events_per_lane:,
          max_events:,
          max_bytes_per_lane:,
          max_bytes:,
          max_response_bytes:
        )
        end
      end

      class SessionLane
        sig { returns(T.nilable(String)) }
        attr_reader :stream_id

        sig { params(event: Connection::ClientEvent).void }
        def send_event(event)
        end

        sig { returns(Connection::ServerEvent) }
        def receive
        end

        sig { returns(OpenAI::Responses::Response) }
        def get_final_response
        end

        sig { void }
        def close
        end

        # @api private
        sig {
          params(session: Session, stream_id: T.nilable(String), pending_steers: T::Hash[String, T.untyped]).returns(
            T.attached_class
          )
        }
        def self.new(session, stream_id, pending_steers)
        end

        # @api private
        sig {
          params(event: Connection::ServerEvent, bytes: Integer, raw_command_sent: T::Boolean).returns(
            T.nilable(T::Boolean)
          )
        }
        def enqueue(event, bytes, raw_command_sent = false)
        end

        # @api private
        sig { params(error: T.nilable(Exception)).void }
        def discard(error = nil)
        end

        # @api private
        sig { void }
        def wake
        end
      end

      class Session
        sig { returns(SessionLimits) }
        attr_reader :limits

        sig { returns(SessionLane) }
        attr_reader :default

        sig do
          type_parameters(:Result)
            .params(
              client: OpenAI::Client,
              limits: SessionLimits,
              request_options: T.nilable(OpenAI::RequestOptions::OrHash),
              websocket_base_url: T.nilable(String),
              transport: T.anything,
              transport_options: T::Hash[Symbol, T.anything],
              block: T.proc.params(session: Session).returns(T.type_parameter(:Result))
            )
            .returns(T.type_parameter(:Result))
        end
        def self.open(
          client:,
          limits:,
          request_options: nil,
          websocket_base_url: nil,
          transport: nil,
          transport_options: {},
          &block
        )
        end

        sig { params(stream_id: T.nilable(String)).returns(SessionLane) }
        def lane(stream_id)
        end

        sig do
          params(
            restore: T.proc.params(session: Session).returns(T.anything),
            client: OpenAI::Client,
            request_options: T.nilable(OpenAI::RequestOptions::OrHash)
          )
            .returns(T.self_type)
        end
        def reconnect(restore:, client: T.unsafe(nil), request_options: nil)
        end

        sig { void }
        def close
        end

        # @api private
        sig {
          params(
            task: T.untyped,
            client: OpenAI::Client,
            limits: SessionLimits,
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            websocket_base_url: T.nilable(String),
            transport: T.anything,
            transport_options: T::Hash[Symbol, T.anything]
          )
            .returns(T.attached_class)
        }
        def self.new(task:, client:, limits:, request_options:, websocket_base_url:, transport:, transport_options:)
        end

        # @api private
        sig { void }
        def start
        end

        # @api private
        sig { params(event: Connection::ClientEvent).returns(OpenAI::Internal::AnyHash) }
        def encode_client_event(event)
        end

        # @api private
        sig { params(event: Connection::ClientEvent).void }
        def send_event(event)
        end

        # @api private
        sig { void }
        def check_reader!
        end

        # @api private
        sig { void }
        def assert_owner!
        end

        # @api private
        sig { params(bytes: Integer).void }
        def consumed(bytes)
        end

        # @api private
        sig { params(value: SessionLane).void }
        def detach(value)
        end
      end
    end
  end
end
