# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        # List user actions and configuration changes within this organization.
        # @return [OpenAI::Resources::Admin::Organization::AuditLogs]
        attr_reader :audit_logs

        # @return [OpenAI::Resources::Admin::Organization::AdminAPIKeys]
        attr_reader :admin_api_keys

        # @return [OpenAI::Resources::Admin::Organization::Usage]
        attr_reader :usage

        # @return [OpenAI::Resources::Admin::Organization::Invites]
        attr_reader :invites

        # @return [OpenAI::Resources::Admin::Organization::Users]
        attr_reader :users

        # @return [OpenAI::Resources::Admin::Organization::Groups]
        attr_reader :groups

        # @return [OpenAI::Resources::Admin::Organization::Roles]
        attr_reader :roles

        # @return [OpenAI::Resources::Admin::Organization::DataRetention]
        attr_reader :data_retention

        # @return [OpenAI::Resources::Admin::Organization::SpendLimit]
        attr_reader :spend_limit

        # @return [OpenAI::Resources::Admin::Organization::SpendAlerts]
        attr_reader :spend_alerts

        # @return [OpenAI::Resources::Admin::Organization::Certificates]
        attr_reader :certificates

        # @return [OpenAI::Resources::Admin::Organization::Projects]
        attr_reader :projects

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @audit_logs = OpenAI::Resources::Admin::Organization::AuditLogs.new(client: client)
          @admin_api_keys = OpenAI::Resources::Admin::Organization::AdminAPIKeys.new(client: client)
          @usage = OpenAI::Resources::Admin::Organization::Usage.new(client: client)
          @invites = OpenAI::Resources::Admin::Organization::Invites.new(client: client)
          @users = OpenAI::Resources::Admin::Organization::Users.new(client: client)
          @groups = OpenAI::Resources::Admin::Organization::Groups.new(client: client)
          @roles = OpenAI::Resources::Admin::Organization::Roles.new(client: client)
          @data_retention = OpenAI::Resources::Admin::Organization::DataRetention.new(client: client)
          @spend_limit = OpenAI::Resources::Admin::Organization::SpendLimit.new(client: client)
          @spend_alerts = OpenAI::Resources::Admin::Organization::SpendAlerts.new(client: client)
          @certificates = OpenAI::Resources::Admin::Organization::Certificates.new(client: client)
          @projects = OpenAI::Resources::Admin::Organization::Projects.new(client: client)
        end
      end
    end
  end
end
