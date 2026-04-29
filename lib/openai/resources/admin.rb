# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      # @return [OpenAI::Resources::Admin::Organization]
      attr_reader :organization

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @organization = OpenAI::Resources::Admin::Organization.new(client: client)
      end
    end
  end
end
