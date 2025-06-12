# frozen_string_literal: true

module OpenAI
  module Resources
    class Containers
      class Files
        # @return [OpenAI::Resources::Containers::Files::Content]
        attr_reader :content

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @content = OpenAI::Resources::Containers::Files::Content.new(client: client)
        end
      end
    end
  end
end
