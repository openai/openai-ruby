# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        # List user actions and configuration changes within this organization.
        sig { returns(OpenAI::Resources::Admin::Organization::AuditLogs) }
        attr_reader :audit_logs

        sig { returns(OpenAI::Resources::Admin::Organization::AdminAPIKeys) }
        attr_reader :admin_api_keys

        sig { returns(OpenAI::Resources::Admin::Organization::Usage) }
        attr_reader :usage

        sig { returns(OpenAI::Resources::Admin::Organization::Invites) }
        attr_reader :invites

        sig { returns(OpenAI::Resources::Admin::Organization::Users) }
        attr_reader :users

        sig { returns(OpenAI::Resources::Admin::Organization::Groups) }
        attr_reader :groups

        sig { returns(OpenAI::Resources::Admin::Organization::Roles) }
        attr_reader :roles

        sig { returns(OpenAI::Resources::Admin::Organization::DataRetention) }
        attr_reader :data_retention

        sig { returns(OpenAI::Resources::Admin::Organization::SpendAlerts) }
        attr_reader :spend_alerts

        sig { returns(OpenAI::Resources::Admin::Organization::Certificates) }
        attr_reader :certificates

        sig { returns(OpenAI::Resources::Admin::Organization::Projects) }
        attr_reader :projects

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
