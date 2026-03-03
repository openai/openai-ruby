# typed: strong

module OpenAI
  module Resources
    class Beta
      sig { returns(OpenAI::Resources::Beta::ChatKit) }
      attr_reader :chatkit

      # Build Assistants that can call models and use tools.
      sig { returns(OpenAI::Resources::Beta::Assistants) }
      attr_reader :assistants

      # Build Assistants that can call models and use tools.
      sig { returns(OpenAI::Resources::Beta::Threads) }
      attr_reader :threads

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
