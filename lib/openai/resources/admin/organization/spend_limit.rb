# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class SpendLimit
          # Get the organization's hard spend limit.
          #
          # @overload retrieve(request_options: {})
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationSpendLimit]
          #
          # @see OpenAI::Models::Admin::Organization::SpendLimitRetrieveParams
          def retrieve(params = {})
            @client.request(
              method: :get,
              path: "organization/spend_limit",
              model: OpenAI::Admin::Organization::OrganizationSpendLimit,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::SpendLimitUpdateParams} for more details.
          #
          # Create or replace the organization's hard spend limit.
          #
          # @overload update(currency:, interval:, threshold_amount:, request_options: {})
          #
          # @param currency [Symbol, OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::Currency] The currency for the threshold amount. Currently, only `USD` is supported.
          #
          # @param interval [Symbol, OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::Interval] The time interval for evaluating spend against the threshold. Currently, only `m
          #
          # @param threshold_amount [Integer] The hard spend limit amount, in cents.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationSpendLimit]
          #
          # @see OpenAI::Models::Admin::Organization::SpendLimitUpdateParams
          def update(params)
            parsed, options = OpenAI::Admin::Organization::SpendLimitUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/spend_limit",
              body: parsed,
              model: OpenAI::Admin::Organization::OrganizationSpendLimit,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Delete the organization's hard spend limit.
          #
          # @overload delete(request_options: {})
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationSpendLimitDeleted]
          #
          # @see OpenAI::Models::Admin::Organization::SpendLimitDeleteParams
          def delete(params = {})
            @client.request(
              method: :delete,
              path: "organization/spend_limit",
              model: OpenAI::Admin::Organization::OrganizationSpendLimitDeleted,
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
