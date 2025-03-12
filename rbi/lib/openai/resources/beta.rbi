# typed: strong

module OpenAI
  module Resources
    class Beta
      sig { returns(OpenAI::Resources::Beta::Assistants) }
      def assistants
      end

      sig { returns(OpenAI::Resources::Beta::Threads) }
      def threads
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
