# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class SpendLimit
            # Get a project's hard spend limit.
            sig do
              params(
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendLimit
              )
            end
            def retrieve(
              # The ID of the project whose hard spend limit is being managed.
              project_id,
              request_options: {}
            )
            end

            # Create or replace a project's hard spend limit.
            sig do
              params(
                project_id: String,
                currency:
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::OrSymbol,
                interval:
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::OrSymbol,
                threshold_amount: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendLimit
              )
            end
            def update(
              # The ID of the project whose hard spend limit is being managed.
              project_id,
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

            # Delete a project's hard spend limit.
            sig do
              params(
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendLimitDeleted
              )
            end
            def delete(
              # The ID of the project whose hard spend limit is being managed.
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
end
