# typed: strong

module OpenAI
  module Resources
    class Beta
      class ChatKit
        sig { returns(OpenAI::Resources::Beta::ChatKit::Sessions) }
        attr_reader :sessions

        sig { returns(OpenAI::Resources::Beta::ChatKit::Threads) }
        attr_reader :threads

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
