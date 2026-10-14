# frozen_string_literal: true

module OpenAI
  module Resources
    class Safety
      # @return [OpenAI::Resources::Safety::Cases]
      attr_reader :cases

      # @return [OpenAI::Resources::Safety::Alerts]
      attr_reader :alerts

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @cases = OpenAI::Resources::Safety::Cases.new(client: client)
        @alerts = OpenAI::Resources::Safety::Alerts.new(client: client)
      end
    end
  end
end
