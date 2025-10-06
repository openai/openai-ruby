# typed: strong

module OpenAI
  module Resources
    class Beta
      sig { returns(OpenAI::Resources::Beta::ChatKit) }
      attr_reader :chatkit

      sig { returns(OpenAI::Resources::Beta::Assistants) }
      attr_reader :assistants

      sig { returns(OpenAI::Resources::Beta::Threads) }
      attr_reader :threads

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
