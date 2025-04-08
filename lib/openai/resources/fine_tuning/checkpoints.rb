# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Checkpoints
        # @return [OpenAI::Resources::FineTuning::Checkpoints::Permissions]
        attr_reader :permissions

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @permissions = OpenAI::Resources::FineTuning::Checkpoints::Permissions.new(client: client)
        end
      end
    end
  end
end
