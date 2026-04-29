# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        # List user actions and configuration changes within this organization.
        sig { returns(OpenAI::Resources::Admin::Organization::AuditLogs) }
        attr_reader :audit_logs

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
