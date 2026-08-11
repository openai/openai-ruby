# typed: strong

module OpenAI
  module Resources
    class Graders
      sig { returns(OpenAI::Resources::Graders::GraderModels) }
      attr_reader :grader_models

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
