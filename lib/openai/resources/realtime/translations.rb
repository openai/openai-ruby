# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class Translations
        # @return [OpenAI::Resources::Realtime::Translations::ClientSecrets]
        attr_reader :client_secrets

        # @return [OpenAI::Resources::Realtime::Translations::Calls]
        attr_reader :calls

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @client_secrets = OpenAI::Resources::Realtime::Translations::ClientSecrets.new(client: client)
          @calls = OpenAI::Resources::Realtime::Translations::Calls.new(client: client)
        end
      end
    end
  end
end
