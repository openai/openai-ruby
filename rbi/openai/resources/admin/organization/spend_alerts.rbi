# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class SpendAlerts
          # Creates an organization spend alert.
          sig do
            params(
              currency:
                OpenAI::Admin::Organization::SpendAlertCreateParams::Currency::OrSymbol,
              interval:
                OpenAI::Admin::Organization::SpendAlertCreateParams::Interval::OrSymbol,
              notification_channel:
                OpenAI::Admin::Organization::SpendAlertCreateParams::NotificationChannel::OrHash,
              threshold_amount: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::OrganizationSpendAlert)
          end
          def create(
            # The currency for the threshold amount.
            currency:,
            # The time interval for evaluating spend against the threshold.
            interval:,
            # Email notification settings for a spend alert.
            notification_channel:,
            # The alert threshold amount, in cents.
            threshold_amount:,
            request_options: {}
          )
          end

          # Updates an organization spend alert.
          sig do
            params(
              alert_id: String,
              currency:
                OpenAI::Admin::Organization::SpendAlertUpdateParams::Currency::OrSymbol,
              interval:
                OpenAI::Admin::Organization::SpendAlertUpdateParams::Interval::OrSymbol,
              notification_channel:
                OpenAI::Admin::Organization::SpendAlertUpdateParams::NotificationChannel::OrHash,
              threshold_amount: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::OrganizationSpendAlert)
          end
          def update(
            # The ID of the spend alert to update.
            alert_id,
            # The currency for the threshold amount.
            currency:,
            # The time interval for evaluating spend against the threshold.
            interval:,
            # Email notification settings for a spend alert.
            notification_channel:,
            # The alert threshold amount, in cents.
            threshold_amount:,
            request_options: {}
          )
          end

          # Lists organization spend alerts.
          sig do
            params(
              after: String,
              before: String,
              limit: Integer,
              order:
                OpenAI::Admin::Organization::SpendAlertListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Admin::Organization::OrganizationSpendAlert
              ]
            )
          end
          def list(
            # Cursor for pagination. Provide the ID of the last spend alert from the previous
            # response to fetch the next page.
            after: nil,
            # Cursor for pagination. Provide the ID of the first spend alert from the previous
            # response to fetch the previous page.
            before: nil,
            # A limit on the number of spend alerts to return. Defaults to 20.
            limit: nil,
            # Sort order for the returned spend alerts.
            order: nil,
            request_options: {}
          )
          end

          # Deletes an organization spend alert.
          sig do
            params(
              alert_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Admin::Organization::OrganizationSpendAlertDeleted
            )
          end
          def delete(
            # The ID of the spend alert to delete.
            alert_id,
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
