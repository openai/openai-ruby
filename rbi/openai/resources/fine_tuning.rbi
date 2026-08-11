# typed: strong

module OpenAI
  module Resources
    class FineTuning
      sig { returns(FineTuning::WithRawResponse) }
      def with_raw_response
      end

      sig { returns(OpenAI::Resources::FineTuning::Methods) }
      attr_reader :methods_

      # Manage fine-tuning jobs to tailor a model to your specific training data.
      sig { returns(OpenAI::Resources::FineTuning::Jobs) }
      attr_reader :jobs

      sig { returns(OpenAI::Resources::FineTuning::Checkpoints) }
      attr_reader :checkpoints

      sig { returns(OpenAI::Resources::FineTuning::Alpha) }
      attr_reader :alpha

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end

      class WithRawResponse
        sig { returns(OpenAI::Resources::FineTuning::Jobs::WithRawResponse) }
        attr_reader :jobs

        sig { returns(OpenAI::Resources::FineTuning::Checkpoints::WithRawResponse) }
        attr_reader :checkpoints

        sig { returns(OpenAI::Resources::FineTuning::Alpha::WithRawResponse) }
        attr_reader :alpha

        # @api private
        sig { params(resource: FineTuning).returns(T.attached_class) }
        def self.new(resource:)
        end
      end
    end
  end
end
