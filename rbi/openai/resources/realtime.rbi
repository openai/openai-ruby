# typed: strong

module OpenAI
  module Resources
    class Realtime
      sig { returns(OpenAI::Resources::Realtime::ClientSecrets) }
      attr_reader :client_secrets

      sig { returns(OpenAI::Resources::Realtime::Calls) }
      attr_reader :calls

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
