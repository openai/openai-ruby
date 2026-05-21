# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class SpendAlerts
          # Creates an organization spend alert.
          #
          # @overload create(currency:, interval:, notification_channel:, threshold_amount:, request_options: {})
          #
          # @param currency [Symbol, OpenAI::Models::Admin::Organization::SpendAlertCreateParams::Currency] The currency for the threshold amount.
          #
          # @param interval [Symbol, OpenAI::Models::Admin::Organization::SpendAlertCreateParams::Interval] The time interval for evaluating spend against the threshold.
          #
          # @param notification_channel [OpenAI::Models::Admin::Organization::SpendAlertCreateParams::NotificationChannel] Email notification settings for a spend alert.
          #
          # @param threshold_amount [Integer] The alert threshold amount, in cents.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationSpendAlert]
          #
          # @see OpenAI::Models::Admin::Organization::SpendAlertCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::SpendAlertCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/spend_alerts",
              body: parsed,
              model: OpenAI::Admin::Organization::OrganizationSpendAlert,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Updates an organization spend alert.
          #
          # @overload update(alert_id, currency:, interval:, notification_channel:, threshold_amount:, request_options: {})
          #
          # @param alert_id [String] The ID of the spend alert to update.
          #
          # @param currency [Symbol, OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::Currency] The currency for the threshold amount.
          #
          # @param interval [Symbol, OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::Interval] The time interval for evaluating spend against the threshold.
          #
          # @param notification_channel [OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::NotificationChannel] Email notification settings for a spend alert.
          #
          # @param threshold_amount [Integer] The alert threshold amount, in cents.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationSpendAlert]
          #
          # @see OpenAI::Models::Admin::Organization::SpendAlertUpdateParams
          def update(alert_id, params)
            parsed, options = OpenAI::Admin::Organization::SpendAlertUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["organization/spend_alerts/%1$s", alert_id],
              body: parsed,
              model: OpenAI::Admin::Organization::OrganizationSpendAlert,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::SpendAlertListParams} for more details.
          #
          # Lists organization spend alerts.
          #
          # @overload list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
          #
          # @param after [String] Cursor for pagination. Provide the ID of the last spend alert from the previous
          #
          # @param before [String] Cursor for pagination. Provide the ID of the first spend alert from the previous
          #
          # @param limit [Integer] A limit on the number of spend alerts to return. Defaults to 20.
          #
          # @param order [Symbol, OpenAI::Models::Admin::Organization::SpendAlertListParams::Order] Sort order for the returned spend alerts.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::OrganizationSpendAlert>]
          #
          # @see OpenAI::Models::Admin::Organization::SpendAlertListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::SpendAlertListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/spend_alerts",
              query: query,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Admin::Organization::OrganizationSpendAlert,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Deletes an organization spend alert.
          #
          # @overload delete(alert_id, request_options: {})
          #
          # @param alert_id [String] The ID of the spend alert to delete.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationSpendAlertDeleted]
          #
          # @see OpenAI::Models::Admin::Organization::SpendAlertDeleteParams
          def delete(alert_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/spend_alerts/%1$s", alert_id],
              model: OpenAI::Admin::Organization::OrganizationSpendAlertDeleted,
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
