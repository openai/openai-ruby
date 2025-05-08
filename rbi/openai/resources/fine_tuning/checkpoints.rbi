# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Checkpoints
        sig { returns(OpenAI::Resources::FineTuning::Checkpoints::Permissions) }
        attr_reader :permissions

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
