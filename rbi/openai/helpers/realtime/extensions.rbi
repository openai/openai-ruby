# typed: strong

module OpenAI
  class Client
    sig { returns(T.nilable(URI::Generic)) }
    attr_reader :websocket_base_url

    # @api private
    sig do
      params(
        path: String,
        query: T::Hash[String, String],
        options: T.nilable(OpenAI::RequestOptions::OrHash)
      ).returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
    end
    def realtime_connection_request(path:, query:, options: nil)
    end
  end

  module Errors
    class RealtimeConnectionError < OpenAI::Errors::Error
      sig { returns(URI::Generic) }
      attr_reader :url

      sig { returns(T.nilable(Exception)) }
      def cause
      end

      sig do
        params(
          url: URI::Generic,
          message: T.nilable(String),
          cause: T.nilable(Exception)
        ).returns(T.attached_class)
      end
      def self.new(url:, message: nil, cause: nil)
      end
    end

    class RealtimeProtocolError < OpenAI::Errors::Error
      sig { returns(String) }
      attr_reader :data

      sig { returns(T.nilable(StandardError)) }
      def cause
      end

      sig do
        params(
          data: String,
          message: T.nilable(String),
          cause: T.nilable(StandardError)
        ).returns(T.attached_class)
      end
      def self.new(data:, message: nil, cause: nil)
      end
    end
  end

  module Internal
    module Logging
      class Context
        sig do
          params(response: OpenAI::HTTPClient::Response).returns(
            OpenAI::HTTPClient::Response
          )
        end
        def observe_raw_response(response)
        end
      end

      class ObservedEnumerable
        include Enumerable

        Elem = type_member(:out)

        sig do
          params(
            enumerable: T::Enumerable[Elem],
            context: OpenAI::Internal::Logging::Context,
            response: OpenAI::HTTPClient::Response,
            close: T.proc.void
          ).void
        end
        def initialize(enumerable:, context:, response:, close:)
        end

        sig { params(block: T.untyped).returns(T.untyped) }
        def each(&block)
        end

        sig { void }
        def close
        end

        sig { returns(T::Enumerable[Elem]) }
        private def iterator
        end
      end
    end

    module Transport
      class BaseClient
        # @api private
        sig do
          params(
            req: OpenAI::Internal::Transport::BaseClient::RequestComponents
          ).returns(OpenAI::HTTPClient::Response)
        end
        def request_raw(req)
        end
      end
    end
  end

  module Resources
    class Realtime
      sig { returns(OpenAI::Resources::Realtime::Translations) }
      attr_reader :translations

      sig do
        params(
          model: String,
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          transport: T.untyped,
          transport_options: T::Hash[Symbol, T.untyped],
          block: T.proc.params(connection: OpenAI::Realtime::Connection).returns(T.untyped)
        ).returns(T.untyped)
      end
      def connect(model:, request_options: nil, transport: nil, transport_options: {}, &block)
      end

      sig do
        params(
          call_id: String,
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          transport: T.untyped,
          transport_options: T::Hash[Symbol, T.untyped],
          block: T.proc.params(connection: OpenAI::Realtime::SidebandConnection).returns(T.untyped)
        ).returns(T.untyped)
      end
      def connect_to_call(call_id:, request_options: nil, transport: nil, transport_options: {}, &block)
      end

      sig do
        params(
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          transport: T.untyped,
          transport_options: T::Hash[Symbol, T.untyped],
          block: T.proc.params(connection: OpenAI::Realtime::TranscriptionConnection).returns(T.untyped)
        ).returns(T.untyped)
      end
      def connect_transcription(request_options: nil, transport: nil, transport_options: {}, &block)
      end

      class Calls
        sig do
          params(
            sdp: String,
            session:
              T.nilable(OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Realtime::CallCreateResponse)
        end
        def create(sdp:, session: nil, request_options: {})
        end
      end
    end
  end
end
