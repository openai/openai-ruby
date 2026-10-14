# typed: strong

module OpenAI
  module Resources

    class Realtime

      class Translations

        sig { returns(OpenAI::Resources::Realtime::Translations::ClientSecrets) }
        attr_reader :client_secrets

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end
