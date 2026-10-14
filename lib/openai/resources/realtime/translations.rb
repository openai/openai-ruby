# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class Translations
        # @return [OpenAI::Resources::Realtime::Translations::ClientSecrets]
        attr_reader :client_secrets

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @client_secrets = OpenAI::Resources::Realtime::Translations::ClientSecrets.new(client: client)
        end
      end
    end
  end
end
