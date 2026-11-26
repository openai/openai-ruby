# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class SpendLimit

          # Get the organization's hard spend limit.
          sig {
            params(request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::OrganizationSpendLimit
            )
          }
          def retrieve(request_options: {})
          end

          # Create or replace the organization's hard spend limit.
          sig {
            params(
              currency: OpenAI::Admin::Organization::SpendLimitUpdateParams::Currency::OrSymbol,
              interval: OpenAI::Admin::Organization::SpendLimitUpdateParams::Interval::OrSymbol,
              threshold_amount: Integer,
              notification_channel: T.nilable(
                OpenAI::Admin::Organization::SpendLimitUpdateParams::NotificationChannel::OrHash
              ),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Admin::Organization::OrganizationSpendLimit)
          }
          def update(
            # The currency for the threshold amount. Currently, only `USD` is supported.
            currency:,
            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            interval:,
            # The hard spend limit amount, in cents.
            threshold_amount:,
            # Configure email notifications when the spend limit is reached. Leave this out to
            # keep the current settings, or send null to reset to owner-only notifications.
            notification_channel: nil,
            request_options: {}
          )
          end

          # Delete the organization's hard spend limit.
          sig {
            params(request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::OrganizationSpendLimitDeleted
            )
          }
          def delete(request_options: {})
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
