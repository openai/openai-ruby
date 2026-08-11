# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Alpha
        sig { returns(Alpha::WithRawResponse) }
        def with_raw_response
        end

        # Manage fine-tuning jobs to tailor a model to your specific training data.
        sig { returns(OpenAI::Resources::FineTuning::Alpha::Graders) }
        attr_reader :graders

        # @api private
        sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
        def self.new(client:)
        end

        class WithRawResponse
          sig { returns(OpenAI::Resources::FineTuning::Alpha::Graders::WithRawResponse) }
          attr_reader :graders

          # @api private
          sig { params(resource: Alpha).returns(T.attached_class) }
          def self.new(resource:)
          end
        end
      end
    end
  end
end
