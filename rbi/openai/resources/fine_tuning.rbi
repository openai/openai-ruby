# typed: strong

module OpenAI
  module Resources
    class FineTuning
      sig { returns(OpenAI::Resources::FineTuning::Methods) }
      attr_reader :methods_

      sig { returns(OpenAI::Resources::FineTuning::Jobs) }
      attr_reader :jobs

      sig { returns(OpenAI::Resources::FineTuning::Checkpoints) }
      attr_reader :checkpoints

      sig { returns(OpenAI::Resources::FineTuning::Alpha) }
      attr_reader :alpha

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
