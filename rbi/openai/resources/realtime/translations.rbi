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

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
