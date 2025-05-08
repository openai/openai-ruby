# typed: strong

module OpenAI
  module Resources
    class FineTuning
      class Methods
        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
