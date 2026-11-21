# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      # @return [OpenAI::Resources::Beta::Agents]
      attr_reader :agents

      # Create and manage model responses.
      # @return [OpenAI::Resources::Beta::Responses]
      attr_reader :responses

      # @return [OpenAI::Resources::Beta::ChatKit]
      attr_reader :chatkit

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @agents = OpenAI::Resources::Beta::Agents.new(client: client)
        @responses = OpenAI::Resources::Beta::Responses.new(client: client)
        @chatkit = OpenAI::Resources::Beta::ChatKit.new(client: client)
      end
    end
  end
end
