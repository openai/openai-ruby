# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Resources
    class FineTuning
      class Checkpoints
        # Manage fine-tuning jobs to tailor a model to your specific training data.
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
