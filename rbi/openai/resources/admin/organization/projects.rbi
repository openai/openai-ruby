# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class Projects

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::Users) }
          attr_reader :users

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts) }
          attr_reader :service_accounts

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::APIKeys) }
          attr_reader :api_keys

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::RateLimits) }
          attr_reader :rate_limits

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::ModelPermissions) }
          attr_reader :model_permissions

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::HostedToolPermissions) }
          attr_reader :hosted_tool_permissions

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::Groups) }
          attr_reader :groups

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::Roles) }
          attr_reader :roles

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::DataRetention) }
          attr_reader :data_retention

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::SpendLimit) }
          attr_reader :spend_limit

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::SpendAlerts) }
          attr_reader :spend_alerts

          sig { returns(OpenAI::Resources::Admin::Organization::Projects::Certificates) }
          attr_reader :certificates

          # Create a new project in the organization. Projects can be created and archived,
          # but cannot be deleted.
          sig {
            params(
              name: String,
              external_key_id: T.nilable(String),
              geography: T.nilable(String),
              residency: T.nilable(OpenAI::Admin::Organization::ProjectResidency::OrSymbol),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Admin::Organization::Project)
          }
          def create(
            # The friendly name of the project, this name appears in reports.
            name:,
            # External key ID to associate with the project.
            external_key_id: nil,
            # Create the project with the specified data residency region. Your organization
            # must have access to Data residency functionality in order to use. See
            # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
            # to review the functionality and limitations of setting this field. Deprecated:
            # use `residency` instead. Do not provide both `geography` and `residency`.
            geography: nil,
            # Create the project with the specified residency configuration. Your organization
            # must have access to the requested residency configuration in order to use it.
            # See
            # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
            # to review the functionality and limitations of setting this field.
            residency: nil,
            request_options: {}
          )
          end

          # Retrieves a project.
          sig {
            params(project_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::Project
            )
          }
          def retrieve(
            # The ID of the project.
            project_id,
            request_options: {}
          )
          end

          # Modifies a project in the organization.
          sig {
            params(
              project_id: String,
              external_key_id: T.nilable(String),
              geography: T.nilable(String),
              name: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Admin::Organization::Project)
          }
          def update(
            # The ID of the project.
            project_id,
            # External key ID to associate with the project.
            external_key_id: nil,
            # Geography for the project. Deprecated: use `residency` when creating a project
            # to configure data residency. This field is retained for backward compatibility.
            geography: nil,
            # The updated name of the project, this name appears in reports.
            name: nil,
            request_options: {}
          )
          end

          # Returns a list of projects.
          sig {
            params(
              after: String,
              include_archived: T::Boolean,
              limit: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::ConversationCursorPage[OpenAI::Admin::Organization::Project])
          }
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
          sig {
            params(project_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::Project
            )
          }
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
