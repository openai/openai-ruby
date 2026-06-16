# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class SpendAlerts
            # Creates a project spend alert.
            sig do
              params(
                project_id: String,
                currency:
                  OpenAI::Admin::Organization::Projects::SpendAlertCreateParams::Currency::OrSymbol,
                interval:
                  OpenAI::Admin::Organization::Projects::SpendAlertCreateParams::Interval::OrSymbol,
                notification_channel:
                  OpenAI::Admin::Organization::Projects::SpendAlertCreateParams::NotificationChannel::OrHash,
                threshold_amount: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendAlert
              )
            end
            def create(
              # The ID of the project to update.
              project_id,
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

            # Retrieves a project spend alert.
            sig do
              params(
                alert_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendAlert
              )
            end
            def retrieve(
              # The ID of the spend alert to retrieve.
              alert_id,
              # The ID of the project.
              project_id:,
              request_options: {}
            )
            end

            # Updates a project spend alert.
            sig do
              params(
                alert_id: String,
                project_id: String,
                currency:
                  OpenAI::Admin::Organization::Projects::SpendAlertUpdateParams::Currency::OrSymbol,
                interval:
                  OpenAI::Admin::Organization::Projects::SpendAlertUpdateParams::Interval::OrSymbol,
                notification_channel:
                  OpenAI::Admin::Organization::Projects::SpendAlertUpdateParams::NotificationChannel::OrHash,
                threshold_amount: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendAlert
              )
            end
            def update(
              # Path param: The ID of the spend alert to update.
              alert_id,
              # Path param: The ID of the project to update.
              project_id:,
              # Body param: The currency for the threshold amount.
              currency:,
              # Body param: The time interval for evaluating spend against the threshold.
              interval:,
              # Body param: Email notification settings for a spend alert.
              notification_channel:,
              # Body param: The alert threshold amount, in cents.
              threshold_amount:,
              request_options: {}
            )
            end

            # Lists project spend alerts.
            sig do
              params(
                project_id: String,
                after: String,
                before: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::ConversationCursorPage[
                  OpenAI::Admin::Organization::Projects::ProjectSpendAlert
                ]
              )
            end
            def list(
              # The ID of the project to inspect.
              project_id,
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

            # Deletes a project spend alert.
            sig do
              params(
                alert_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendAlertDeleted
              )
            end
            def delete(
              # The ID of the spend alert to delete.
              alert_id,
              # The ID of the project to update.
              project_id:,
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
end
