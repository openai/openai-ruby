# typed: strong

module OpenAI
  module Resources
    class Admin
      sig { returns(Admin::WithRawResponse) }
      def with_raw_response
      end

      sig { returns(OpenAI::Resources::Admin::Organization) }
      attr_reader :organization

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end

      class WithRawResponse
        sig { returns(OpenAI::Resources::Admin::Organization::WithRawResponse) }
        attr_reader :organization

        # @api private
        sig { params(resource: Admin).returns(T.attached_class) }
        def self.new(resource:)
        end
      end
    end
  end
end
