# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          sig do
            returns(OpenAI::Resources::Admin::Organization::Projects::Users)
          end
          attr_reader :users

          sig do
            returns(
              OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts
            )
          end
          attr_reader :service_accounts

          sig do
            returns(OpenAI::Resources::Admin::Organization::Projects::APIKeys)
          end
          attr_reader :api_keys

          sig do
            returns(
              OpenAI::Resources::Admin::Organization::Projects::RateLimits
            )
          end
          attr_reader :rate_limits

          sig do
            returns(
              OpenAI::Resources::Admin::Organization::Projects::ModelPermissions
            )
          end
          attr_reader :model_permissions

          sig do
            returns(
              OpenAI::Resources::Admin::Organization::Projects::HostedToolPermissions
            )
          end
          attr_reader :hosted_tool_permissions

          sig do
            returns(OpenAI::Resources::Admin::Organization::Projects::Groups)
          end
          attr_reader :groups

          sig do
            returns(OpenAI::Resources::Admin::Organization::Projects::Roles)
          end
          attr_reader :roles

          sig do
            returns(
              OpenAI::Resources::Admin::Organization::Projects::DataRetention
            )
          end
          attr_reader :data_retention

          sig do
            returns(
              OpenAI::Resources::Admin::Organization::Projects::SpendAlerts
            )
          end
          attr_reader :spend_alerts

          sig do
            returns(
              OpenAI::Resources::Admin::Organization::Projects::Certificates
            )
          end
          attr_reader :certificates

          # Create a new project in the organization. Projects can be created and archived,
          # but cannot be deleted.
          sig do
            params(
              name: String,
              external_key_id: T.nilable(String),
              geography: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Project)
          end
          def create(
            # The friendly name of the project, this name appears in reports.
            name:,
            # External key ID to associate with the project.
            external_key_id: nil,
            # Create the project with the specified data residency region. Your organization
            # must have access to Data residency functionality in order to use. See
            # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
            # to review the functionality and limitations of setting this field.
            geography: nil,
            request_options: {}
          )
          end

          # Retrieves a project.
          sig do
            params(
              project_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Project)
          end
          def retrieve(
            # The ID of the project.
            project_id,
            request_options: {}
          )
          end

          # Modifies a project in the organization.
          sig do
            params(
              project_id: String,
              external_key_id: T.nilable(String),
              geography: T.nilable(String),
              name: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Project)
          end
          def update(
            # The ID of the project.
            project_id,
            # External key ID to associate with the project.
            external_key_id: nil,
            # Geography for the project.
            geography: nil,
            # The updated name of the project, this name appears in reports.
            name: nil,
            request_options: {}
          )
          end

          # Returns a list of projects.
          sig do
            params(
              after: String,
              include_archived: T::Boolean,
              limit: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Admin::Organization::Project
              ]
            )
          end
          def list(
            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            after: nil,
            # If `true` returns all projects including those that have been `archived`.
            # Archived projects are not included by default.
            include_archived: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            limit: nil,
            request_options: {}
          )
          end

          # Archives a project in the organization. Archived projects cannot be used or
          # updated.
          sig do
            params(
              project_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Project)
          end
          def archive(
            # The ID of the project.
            project_id,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
