# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Alpha
        # @return [OpenAI::Resources::FineTuning::Alpha::Graders]
        attr_reader :graders

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @graders = OpenAI::Resources::FineTuning::Alpha::Graders.new(client: client)
        end
      end
    end
  end
end
