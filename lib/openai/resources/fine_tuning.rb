# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      # @return [OpenAI::Resources::FineTuning::Jobs]
      attr_reader :jobs

      # @return [OpenAI::Resources::FineTuning::Checkpoints]
      attr_reader :checkpoints

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @jobs = OpenAI::Resources::FineTuning::Jobs.new(client: client)
        @checkpoints = OpenAI::Resources::FineTuning::Checkpoints.new(client: client)
      end
    end
  end
end
