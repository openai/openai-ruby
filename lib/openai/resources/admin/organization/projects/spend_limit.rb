# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class SpendLimit
            # Get a project's hard spend limit.
            #
            # @overload retrieve(project_id, request_options: {})
            #
            # @param project_id [String] The ID of the project whose hard spend limit is being managed.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendLimitRetrieveParams
            def retrieve(project_id, params = {})
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/spend_limit", project_id],
                model: OpenAI::Admin::Organization::Projects::ProjectSpendLimit,
                security: {admin_api_key_auth: true},
                options: params[:request_options]
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams} for more
            # details.
            #
            # Create or replace a project's hard spend limit.
            #
            # @overload update(project_id, currency:, interval:, threshold_amount:, request_options: {})
            #
            # @param project_id [String] The ID of the project whose hard spend limit is being managed.
            #
            # @param currency [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams::Currency] The currency for the threshold amount. Currently, only `USD` is supported.
            #
            # @param interval [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams::Interval] The time interval for evaluating spend against the threshold. Currently, only `m
            #
            # @param threshold_amount [Integer] The hard spend limit amount, in cents.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams
            def update(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/spend_limit", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectSpendLimit,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Delete a project's hard spend limit.
            #
            # @overload delete(project_id, request_options: {})
            #
            # @param project_id [String] The ID of the project whose hard spend limit is being managed.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimitDeleted]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendLimitDeleteParams
            def delete(project_id, params = {})
              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/spend_limit", project_id],
                model: OpenAI::Admin::Organization::Projects::ProjectSpendLimitDeleted,
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
