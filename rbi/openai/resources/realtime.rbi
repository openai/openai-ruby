# typed: strong

module OpenAI
  module Resources
    class Realtime
      sig { returns(OpenAI::Resources::Realtime::ClientSecrets) }
      attr_reader :client_secrets

      sig { returns(OpenAI::Resources::Realtime::Calls) }
      attr_reader :calls

      sig { returns(OpenAI::Resources::Realtime::Translations) }
      attr_reader :translations

      sig do
        params(
          model: T.nilable(String),
          call_id: T.nilable(String),
          intent: T.nilable(Symbol),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          transport: T.untyped,
          transport_options: T::Hash[Symbol, T.untyped],
          block:
            T
              .proc
              .params(
                connection:
                  T.any(
                    OpenAI::Realtime::Connection,
                    OpenAI::Realtime::SidebandConnection,
                    OpenAI::Realtime::TranscriptionConnection
                  )
              )
              .returns(T.untyped)
        ).returns(T.untyped)
      end
      def connect(
        model: nil,
        call_id: nil,
        intent: nil,
        request_options: nil,
        transport: nil,
        transport_options: {},
        &block
      )
      end

      # @api private
      sig do
        params(
          model: T.nilable(String),
          call_id: T.nilable(String),
          intent: T.nilable(Symbol)
        ).returns(T::Array[T.untyped])
      end
      def connection_target(model:, call_id:, intent:)
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
