# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Checkpoints
        sig { returns(Checkpoints::WithRawResponse) }
        def with_raw_response
        end

        # Manage fine-tuning jobs to tailor a model to your specific training data.
        sig { returns(OpenAI::Resources::FineTuning::Checkpoints::Permissions) }
        attr_reader :permissions

        # @api private
        sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
        def self.new(client:)
        end

        class WithRawResponse
          sig { returns(OpenAI::Resources::FineTuning::Checkpoints::Permissions::WithRawResponse) }
          attr_reader :permissions

          # @api private
          sig { params(resource: Checkpoints).returns(T.attached_class) }
          def self.new(resource:)
          end
        end
      end
    end
  end
end
