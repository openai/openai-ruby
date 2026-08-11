# typed: strong

module OpenAI
  module Resources
    class Realtime
      class Translations
        sig do
          returns(OpenAI::Resources::Realtime::Translations::ClientSecrets)
        end
        attr_reader :client_secrets

        sig { returns(OpenAI::Resources::Realtime::Translations::Calls) }
        attr_reader :calls

        sig do
          params(
            model: String,
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            transport: T.untyped,
            transport_options: T::Hash[Symbol, T.untyped],
            block:
              T
                .proc
                .params(connection: OpenAI::Realtime::TranslationConnection)
                .returns(T.untyped)
          ).returns(T.untyped)
        end
        def connect(
          model:,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
