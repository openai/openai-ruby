# typed: strong

module OpenAI
  module Resources
    class Realtime
      sig { returns(Realtime::WithRawResponse) }
      def with_raw_response
      end

      sig { returns(OpenAI::Resources::Realtime::ClientSecrets) }
      attr_reader :client_secrets

      sig { returns(OpenAI::Resources::Realtime::Calls) }
      attr_reader :calls

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end

      class WithRawResponse
        sig { returns(OpenAI::Resources::Realtime::ClientSecrets::WithRawResponse) }
        attr_reader :client_secrets

        sig { returns(OpenAI::Resources::Realtime::Calls::WithRawResponse) }
        attr_reader :calls

        # @api private
        sig { params(resource: Realtime).returns(T.attached_class) }
        def self.new(resource:)
        end
      end
    end
  end
end
