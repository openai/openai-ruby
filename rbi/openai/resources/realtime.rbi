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

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
