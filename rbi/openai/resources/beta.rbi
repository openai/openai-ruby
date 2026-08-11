# typed: strong

module OpenAI
  module Resources
    class Beta
      sig { returns(Beta::WithRawResponse) }
      def with_raw_response
      end

      sig { returns(OpenAI::Resources::Beta::Responses) }
      attr_reader :responses

      sig { returns(OpenAI::Resources::Beta::ChatKit) }
      attr_reader :chatkit

      # Build Assistants that can call models and use tools.
      sig { returns(OpenAI::Resources::Beta::Assistants) }
      attr_reader :assistants

      # Build Assistants that can call models and use tools.
      sig { returns(OpenAI::Resources::Beta::Threads) }
      attr_reader :threads

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end

      class WithRawResponse
        sig { returns(OpenAI::Resources::Beta::Responses::WithRawResponse) }
        attr_reader :responses

        sig { returns(OpenAI::Resources::Beta::ChatKit::WithRawResponse) }
        attr_reader :chatkit

        sig { returns(OpenAI::Resources::Beta::Assistants::WithRawResponse) }
        attr_reader :assistants

        sig { returns(OpenAI::Resources::Beta::Threads::WithRawResponse) }
        attr_reader :threads

        # @api private
        sig { params(resource: Beta).returns(T.attached_class) }
        def self.new(resource:)
        end
      end
    end
  end
end
