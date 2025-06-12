# typed: strong

module OpenAI
  module Resources
    class Containers
      sig { returns(OpenAI::Resources::Containers::Files) }
      attr_reader :files

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
