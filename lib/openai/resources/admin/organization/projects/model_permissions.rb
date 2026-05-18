# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class ModelPermissions
            # Returns model permissions for a project.
            #
            # @overload retrieve(project_id, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectModelPermissions]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ModelPermissionRetrieveParams
            def retrieve(project_id, params = {})
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/model_permissions", project_id],
                model: OpenAI::Admin::Organization::Projects::ProjectModelPermissions,
                security: {admin_api_key_auth: true},
                options: params[:request_options]
              )
            end

            # Updates model permissions for a project.
            #
            # @overload update(project_id, mode:, model_ids:, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param mode [Symbol, OpenAI::Models::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode] The model permissions mode to apply.
            #
            # @param model_ids [Array<String>] The model IDs included in this permissions policy.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectModelPermissions]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ModelPermissionUpdateParams
            def update(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/model_permissions", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectModelPermissions,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Deletes model permissions for a project.
            #
            # @overload delete(project_id, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectModelPermissionsDeleted]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ModelPermissionDeleteParams
            def delete(project_id, params = {})
              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/model_permissions", project_id],
                model: OpenAI::Admin::Organization::Projects::ProjectModelPermissionsDeleted,
                security: {admin_api_key_auth: true},
                options: params[:request_options]
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
            end
          end
        end
      end
    end
  end
end
