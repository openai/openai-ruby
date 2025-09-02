# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      # @return [OpenAI::Resources::Realtime::ClientSecrets]
      attr_reader :client_secrets

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @client_secrets = OpenAI::Resources::Realtime::ClientSecrets.new(client: client)
      end
    end
  end
end
