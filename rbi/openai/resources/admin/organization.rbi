# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        sig { returns(Organization::WithRawResponse) }
        def with_raw_response
        end

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

        sig { returns(OpenAI::Resources::Admin::Organization::SpendLimit) }
        attr_reader :spend_limit

        sig { returns(OpenAI::Resources::Admin::Organization::SpendAlerts) }
        attr_reader :spend_alerts

        sig { returns(OpenAI::Resources::Admin::Organization::Certificates) }
        attr_reader :certificates

        sig { returns(OpenAI::Resources::Admin::Organization::Projects) }
        attr_reader :projects

        # @api private
        sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
        def self.new(client:)
        end

        class WithRawResponse
          sig { returns(OpenAI::Resources::Admin::Organization::AuditLogs::WithRawResponse) }
          attr_reader :audit_logs

          sig { returns(OpenAI::Resources::Admin::Organization::AdminAPIKeys::WithRawResponse) }
          attr_reader :admin_api_keys

          sig { returns(OpenAI::Resources::Admin::Organization::Usage::WithRawResponse) }
          attr_reader :usage

          sig { returns(OpenAI::Resources::Admin::Organization::Invites::WithRawResponse) }
          attr_reader :invites

          sig { returns(OpenAI::Resources::Admin::Organization::Users::WithRawResponse) }
          attr_reader :users

          sig { returns(OpenAI::Resources::Admin::Organization::Groups::WithRawResponse) }
          attr_reader :groups

          sig { returns(OpenAI::Resources::Admin::Organization::Roles::WithRawResponse) }
          attr_reader :roles

          sig { returns(OpenAI::Resources::Admin::Organization::DataRetention::WithRawResponse) }
          attr_reader :data_retention

          sig { returns(OpenAI::Resources::Admin::Organization::SpendLimit::WithRawResponse) }
          attr_reader :spend_limit

          sig { returns(OpenAI::Resources::Admin::Organization::SpendAlerts::WithRawResponse) }
          attr_reader :spend_alerts

          sig { returns(OpenAI::Resources::Admin::Organization::Certificates::WithRawResponse) }
          attr_reader :certificates

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::WithRawResponse) }
          attr_reader :projects

          # @api private
          sig { params(resource: Organization).returns(T.attached_class) }
          def self.new(resource:)
          end
        end
      end
    end
  end
end
