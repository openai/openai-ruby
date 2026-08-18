# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          # @return [OpenAI::Resources::Admin::Organization::Projects::Users]
          attr_reader :users

          # @return [OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts]
          attr_reader :service_accounts

          # @return [OpenAI::Resources::Admin::Organization::Projects::APIKeys]
          attr_reader :api_keys

          # @return [OpenAI::Resources::Admin::Organization::Projects::RateLimits]
          attr_reader :rate_limits

          # @return [OpenAI::Resources::Admin::Organization::Projects::ModelPermissions]
          attr_reader :model_permissions

          # @return [OpenAI::Resources::Admin::Organization::Projects::HostedToolPermissions]
          attr_reader :hosted_tool_permissions

          # @return [OpenAI::Resources::Admin::Organization::Projects::Groups]
          attr_reader :groups

          # @return [OpenAI::Resources::Admin::Organization::Projects::Roles]
          attr_reader :roles

          # @return [OpenAI::Resources::Admin::Organization::Projects::DataRetention]
          attr_reader :data_retention

          # @return [OpenAI::Resources::Admin::Organization::Projects::SpendLimit]
          attr_reader :spend_limit

          # @return [OpenAI::Resources::Admin::Organization::Projects::SpendAlerts]
          attr_reader :spend_alerts

          # @return [OpenAI::Resources::Admin::Organization::Projects::Certificates]
          attr_reader :certificates

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::ProjectCreateParams} for more details.
          #
          # Create a new project in the organization. Projects can be created and archived,
          # but cannot be deleted.
          #
          # @overload create(name:, external_key_id: nil, geography: nil, request_options: {})
          #
          # @param name [String] The friendly name of the project, this name appears in reports.
          #
          # @param external_key_id [String, nil] External key ID to associate with the project.
          #
          # @param geography [String, nil] Create the project with the specified data residency region. Your organization m
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Project]
          #
          # @see OpenAI::Models::Admin::Organization::ProjectCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::ProjectCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/projects",
              body: parsed,
              model: OpenAI::Admin::Organization::Project,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Retrieves a project.
          #
          # @overload retrieve(project_id, request_options: {})
          #
          # @param project_id [String] The ID of the project.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Project]
          #
          # @see OpenAI::Models::Admin::Organization::ProjectRetrieveParams
          def retrieve(project_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/projects/%1$s", project_id],
              model: OpenAI::Admin::Organization::Project,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Modifies a project in the organization.
          #
          # @overload update(project_id, external_key_id: nil, geography: nil, name: nil, request_options: {})
          #
          # @param project_id [String] The ID of the project.
          #
          # @param external_key_id [String, nil] External key ID to associate with the project.
          #
          # @param geography [String, nil] Geography for the project.
          #
          # @param name [String, nil] The updated name of the project, this name appears in reports.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Project]
          #
          # @see OpenAI::Models::Admin::Organization::ProjectUpdateParams
          def update(project_id, params = {})
            parsed, options = OpenAI::Admin::Organization::ProjectUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["organization/projects/%1$s", project_id],
              body: parsed,
              model: OpenAI::Admin::Organization::Project,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::ProjectListParams} for more details.
          #
          # Returns a list of projects.
          #
          # @overload list(after: nil, include_archived: nil, limit: nil, request_options: {})
          #
          # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          # @param include_archived [Boolean] If `true` returns all projects including those that have been `archived`. Archiv
          #
          # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Project>]
          #
          # @see OpenAI::Models::Admin::Organization::ProjectListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::ProjectListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/projects",
              query: query,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Admin::Organization::Project,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Archives a project in the organization. Archived projects cannot be used or
          # updated.
          #
          # @overload archive(project_id, request_options: {})
          #
          # @param project_id [String] The ID of the project.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Project]
          #
          # @see OpenAI::Models::Admin::Organization::ProjectArchiveParams
          def archive(project_id, params = {})
            @client.request(
              method: :post,
              path: ["organization/projects/%1$s/archive", project_id],
              model: OpenAI::Admin::Organization::Project,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @users = OpenAI::Resources::Admin::Organization::Projects::Users.new(client: client)
            @service_accounts = OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts.new(client: client)
            @api_keys = OpenAI::Resources::Admin::Organization::Projects::APIKeys.new(client: client)
            @rate_limits = OpenAI::Resources::Admin::Organization::Projects::RateLimits.new(client: client)
            @model_permissions =
              OpenAI::Resources::Admin::Organization::Projects::ModelPermissions.new(client: client)
            @hosted_tool_permissions =
              OpenAI::Resources::Admin::Organization::Projects::HostedToolPermissions.new(client: client)
            @groups = OpenAI::Resources::Admin::Organization::Projects::Groups.new(client: client)
            @roles = OpenAI::Resources::Admin::Organization::Projects::Roles.new(client: client)
            @data_retention = OpenAI::Resources::Admin::Organization::Projects::DataRetention.new(client: client)
            @spend_limit = OpenAI::Resources::Admin::Organization::Projects::SpendLimit.new(client: client)
            @spend_alerts = OpenAI::Resources::Admin::Organization::Projects::SpendAlerts.new(client: client)
            @certificates = OpenAI::Resources::Admin::Organization::Projects::Certificates.new(client: client)
          end
        end
      end
    end
  end
end
