# typed: strong

module OpenAI
  module Resources
    class Chat
      sig { returns(OpenAI::Resources::Chat::Completions) }
      def completions
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
