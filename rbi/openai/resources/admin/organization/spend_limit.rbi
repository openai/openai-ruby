# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class SpendLimit
          # Get the organization's hard spend limit.
          sig do
            params(request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::OrganizationSpendLimit
            )
          end
          def retrieve(request_options: {})
          end

          # Create or replace the organization's hard spend limit.
          sig do
            params(
              currency:
                OpenAI::Admin::Organization::SpendLimitUpdateParams::Currency::OrSymbol,
              interval:
                OpenAI::Admin::Organization::SpendLimitUpdateParams::Interval::OrSymbol,
              threshold_amount: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::OrganizationSpendLimit)
          end
          def update(
            # The currency for the threshold amount. Currently, only `USD` is supported.
            currency:,
            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            interval:,
            # The hard spend limit amount, in cents.
            threshold_amount:,
            request_options: {}
          )
          end

          # Delete the organization's hard spend limit.
          sig do
            params(request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::OrganizationSpendLimitDeleted
            )
          end
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
