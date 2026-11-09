# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class ServiceTierSettings
            # Retrieve the configured default and enabled service tiers for a project.
            #
            # @overload retrieve(project_id, request_options: {})
            #
            # @param project_id [String]
            #   The ID of the project
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectServiceTierSettings]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceTierSettingRetrieveParams
            def retrieve(project_id, params = {})
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/service_tier_settings", project_id],
                model: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings,
                security: {admin_api_key_auth: true},
                options: params[:request_options]
              )
            end

            # Update the default or enabled service tiers atomically. Supply at least one
            # field. Omitted fields keep their current values.
            #
            # @overload update(project_id, default: nil, enabled_tiers: nil, request_options: {})
            #
            # @param project_id [String]
            #   The ID of the project
            #
            # @param default [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceTierSettingUpdateParams::Default]
            #   Default tier for requests that omit service_tier or use auto.
            #
            # @param enabled_tiers [Symbol, :all, Array<Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectOptionalServiceTier>]
            #   Additional service tiers enabled for this project. "all" includes future tiers.
            #   An empty array allows only Standard. Organization policy and eligibility still
            #   apply.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectServiceTierSettings]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceTierSettingUpdateParams
            def update(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::ServiceTierSettingUpdateParams.dump_request(
                params
              )
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/service_tier_settings", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings,
                security: {admin_api_key_auth: true},
                options: options
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
