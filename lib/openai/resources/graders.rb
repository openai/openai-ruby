# frozen_string_literal: true

module OpenAI
  module Resources
    class Graders
      # @return [OpenAI::Resources::Graders::GraderModels]
      attr_reader :grader_models

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @grader_models = OpenAI::Resources::Graders::GraderModels.new(client: client)
      end
    end
  end
end
