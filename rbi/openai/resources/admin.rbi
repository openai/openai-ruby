# typed: strong

module OpenAI
  module Resources
    class Admin
      sig { returns(OpenAI::Resources::Admin::Organization) }
      attr_reader :organization

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
