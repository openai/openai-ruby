# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        # Returns a wrapper that exposes the raw HTTP response for each request.
        #
        # @return [Organization::WithRawResponse]
        def with_raw_response
          WithRawResponse.new(
            resource: Organization.new(
              client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
            )
          )
        end

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
        # @param client [OpenAI::Internal::Transport::RequestClient]
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

        class WithRawResponse
          # List user actions and configuration changes within this organization.
          # @return [OpenAI::Resources::Admin::Organization::AuditLogs::WithRawResponse]
          attr_reader :audit_logs

          # @return [OpenAI::Resources::Admin::Organization::AdminAPIKeys::WithRawResponse]
          attr_reader :admin_api_keys

          # @return [OpenAI::Resources::Admin::Organization::Usage::WithRawResponse]
          attr_reader :usage

          # @return [OpenAI::Resources::Admin::Organization::Invites::WithRawResponse]
          attr_reader :invites

          # @return [OpenAI::Resources::Admin::Organization::Users::WithRawResponse]
          attr_reader :users

          # @return [OpenAI::Resources::Admin::Organization::Groups::WithRawResponse]
          attr_reader :groups

          # @return [OpenAI::Resources::Admin::Organization::Roles::WithRawResponse]
          attr_reader :roles

          # @return [OpenAI::Resources::Admin::Organization::DataRetention::WithRawResponse]
          attr_reader :data_retention

          # @return [OpenAI::Resources::Admin::Organization::SpendLimit::WithRawResponse]
          attr_reader :spend_limit

          # @return [OpenAI::Resources::Admin::Organization::SpendAlerts::WithRawResponse]
          attr_reader :spend_alerts

          # @return [OpenAI::Resources::Admin::Organization::Certificates::WithRawResponse]
          attr_reader :certificates

          # @return [OpenAI::Resources::Admin::Organization::Projects::WithRawResponse]
          attr_reader :projects

          # @api private
          #
          # @param resource [Organization]
          def initialize(resource:)
            @resource = resource

            @audit_logs =
              OpenAI::Resources::Admin::Organization::AuditLogs::WithRawResponse.new(
                resource: @resource.audit_logs
              )

            @admin_api_keys =
              OpenAI::Resources::Admin::Organization::AdminAPIKeys::WithRawResponse.new(
                resource: @resource.admin_api_keys
              )

            @usage =
              OpenAI::Resources::Admin::Organization::Usage::WithRawResponse.new(
                resource: @resource.usage
              )

            @invites =
              OpenAI::Resources::Admin::Organization::Invites::WithRawResponse.new(
                resource: @resource.invites
              )

            @users =
              OpenAI::Resources::Admin::Organization::Users::WithRawResponse.new(
                resource: @resource.users
              )

            @groups =
              OpenAI::Resources::Admin::Organization::Groups::WithRawResponse.new(
                resource: @resource.groups
              )

            @roles =
              OpenAI::Resources::Admin::Organization::Roles::WithRawResponse.new(
                resource: @resource.roles
              )

            @data_retention =
              OpenAI::Resources::Admin::Organization::DataRetention::WithRawResponse.new(
                resource: @resource.data_retention
              )

            @spend_limit =
              OpenAI::Resources::Admin::Organization::SpendLimit::WithRawResponse.new(
                resource: @resource.spend_limit
              )

            @spend_alerts =
              OpenAI::Resources::Admin::Organization::SpendAlerts::WithRawResponse.new(
                resource: @resource.spend_alerts
              )

            @certificates =
              OpenAI::Resources::Admin::Organization::Certificates::WithRawResponse.new(
                resource: @resource.certificates
              )

            @projects =
              OpenAI::Resources::Admin::Organization::Projects::WithRawResponse.new(
                resource: @resource.projects
              )
          end
        end
      end
    end
  end
end
