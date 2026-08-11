# typed: strong

module OpenAI
  module Resources
    class Chat
      sig { returns(Chat::WithRawResponse) }
      def with_raw_response
      end

      # Given a list of messages comprising a conversation, the model will return a
      # response.
      sig { returns(OpenAI::Resources::Chat::Completions) }
      attr_reader :completions

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end

      class WithRawResponse
        sig { returns(OpenAI::Resources::Chat::Completions::WithRawResponse) }
        attr_reader :completions

        # @api private
        sig { params(resource: Chat).returns(T.attached_class) }
        def self.new(resource:)
        end
      end
    end
  end
end
