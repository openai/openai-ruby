# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class SpendAlerts
            # Creates a project spend alert.
            #
            # @overload create(project_id, currency:, interval:, notification_channel:, threshold_amount:, request_options: {})
            #
            # @param project_id [String] The ID of the project to update.
            #
            # @param currency [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendAlertCreateParams::Currency] The currency for the threshold amount.
            #
            # @param interval [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendAlertCreateParams::Interval] The time interval for evaluating spend against the threshold.
            #
            # @param notification_channel [OpenAI::Models::Admin::Organization::Projects::SpendAlertCreateParams::NotificationChannel] Email notification settings for a spend alert.
            #
            # @param threshold_amount [Integer] The alert threshold amount, in cents.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendAlertCreateParams
            def create(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::SpendAlertCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/spend_alerts", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectSpendAlert,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Retrieves a project spend alert.
            #
            # @overload retrieve(alert_id, project_id:, request_options: {})
            #
            # @param alert_id [String] The ID of the spend alert to retrieve.
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendAlertRetrieveParams
            def retrieve(alert_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::SpendAlertRetrieveParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/spend_alerts/%2$s", project_id, alert_id],
                model: OpenAI::Admin::Organization::Projects::ProjectSpendAlert,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Updates a project spend alert.
            #
            # @overload update(alert_id, project_id:, currency:, interval:, notification_channel:, threshold_amount:, request_options: {})
            #
            # @param alert_id [String] Path param: The ID of the spend alert to update.
            #
            # @param project_id [String] Path param: The ID of the project to update.
            #
            # @param currency [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendAlertUpdateParams::Currency] Body param: The currency for the threshold amount.
            #
            # @param interval [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendAlertUpdateParams::Interval] Body param: The time interval for evaluating spend against the threshold.
            #
            # @param notification_channel [OpenAI::Models::Admin::Organization::Projects::SpendAlertUpdateParams::NotificationChannel] Body param: Email notification settings for a spend alert.
            #
            # @param threshold_amount [Integer] Body param: The alert threshold amount, in cents.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendAlertUpdateParams
            def update(alert_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::SpendAlertUpdateParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/spend_alerts/%2$s", project_id, alert_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectSpendAlert,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::SpendAlertListParams} for more
            # details.
            #
            # Lists project spend alerts.
            #
            # @overload list(project_id, after: nil, before: nil, limit: nil, order: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project to inspect.
            #
            # @param after [String] Cursor for pagination. Provide the ID of the last spend alert from the previous
            #
            # @param before [String] Cursor for pagination. Provide the ID of the first spend alert from the previous
            #
            # @param limit [Integer] A limit on the number of spend alerts to return. Defaults to 20.
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendAlertListParams::Order] Sort order for the returned spend alerts.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendAlertListParams
            def list(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::SpendAlertListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/spend_alerts", project_id],
                query: query,
                page: OpenAI::Internal::ConversationCursorPage,
                model: OpenAI::Admin::Organization::Projects::ProjectSpendAlert,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Deletes a project spend alert.
            #
            # @overload delete(alert_id, project_id:, request_options: {})
            #
            # @param alert_id [String] The ID of the spend alert to delete.
            #
            # @param project_id [String] The ID of the project to update.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlertDeleted]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::SpendAlertDeleteParams
            def delete(alert_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::SpendAlertDeleteParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/spend_alerts/%2$s", project_id, alert_id],
                model: OpenAI::Admin::Organization::Projects::ProjectSpendAlertDeleted,
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
