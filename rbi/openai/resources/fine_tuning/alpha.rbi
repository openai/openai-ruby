# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Alpha
        sig { returns(OpenAI::Resources::FineTuning::Alpha::Graders) }
        attr_reader :graders

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
