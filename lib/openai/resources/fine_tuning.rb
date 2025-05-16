# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      # @return [OpenAI::Resources::FineTuning::Methods]
      attr_reader :methods_

      # @return [OpenAI::Resources::FineTuning::Jobs]
      attr_reader :jobs

      # @return [OpenAI::Resources::FineTuning::Checkpoints]
      attr_reader :checkpoints

      # @return [OpenAI::Resources::FineTuning::Alpha]
      attr_reader :alpha

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @methods_ = OpenAI::Resources::FineTuning::Methods.new(client: client)
        @jobs = OpenAI::Resources::FineTuning::Jobs.new(client: client)
        @checkpoints = OpenAI::Resources::FineTuning::Checkpoints.new(client: client)
        @alpha = OpenAI::Resources::FineTuning::Alpha.new(client: client)
      end
    end
  end
end
