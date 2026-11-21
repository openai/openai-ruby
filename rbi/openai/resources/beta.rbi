# typed: strong

module OpenAI
  module Resources

    class Beta

      sig { returns(OpenAI::Resources::Beta::Agents) }
      attr_reader :agents

      # Create and manage model responses.
      sig { returns(OpenAI::Resources::Beta::Responses) }
      attr_reader :responses

      sig { returns(OpenAI::Resources::Beta::ChatKit) }
      attr_reader :chatkit

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end

  end
end
