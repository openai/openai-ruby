# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      # @return [OpenAI::Resources::FineTuning::Jobs]
      attr_reader :jobs

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @jobs = OpenAI::Resources::FineTuning::Jobs.new(client: client)
      end
    end
  end
end
