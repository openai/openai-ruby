# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class ChatKit
        # @return [OpenAI::Resources::Beta::ChatKit::Sessions]
        attr_reader :sessions

        # @return [OpenAI::Resources::Beta::ChatKit::Threads]
        attr_reader :threads

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @sessions = OpenAI::Resources::Beta::ChatKit::Sessions.new(client: client)
          @threads = OpenAI::Resources::Beta::ChatKit::Threads.new(client: client)
        end
      end
    end
  end
end
