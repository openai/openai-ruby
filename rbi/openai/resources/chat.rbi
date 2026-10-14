# typed: strong

module OpenAI
  module Resources
    class Chat
      # Given a list of messages comprising a conversation, the model will return a
      # response.
      sig { returns(OpenAI::Resources::Chat::Completions) }
      attr_reader :completions

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
