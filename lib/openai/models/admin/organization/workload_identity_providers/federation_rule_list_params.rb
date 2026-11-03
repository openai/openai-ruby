# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module WorkloadIdentityProviders
          # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRules#list
          class FederationRuleListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute workload_identity_provider_id
            #
            #   @return [String]
            required :workload_identity_provider_id, String

            # @!attribute after
            #
            #   @return [String, nil]
            optional :after, String

            # @!attribute limit
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!attribute order
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order, nil]
            optional(
              :order,
              union: -> { OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order }
            )

            # @!attribute service_account_id
            #
            #   @return [String, nil]
            optional :service_account_id, String

            # @!method initialize(workload_identity_provider_id:, after: nil, limit: nil, order: nil, service_account_id: nil, request_options: {})
            #   @param workload_identity_provider_id [String]
            #   @param after [String]
            #   @param limit [Integer]
            #   @param order [Symbol, OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order]
            #   @param service_account_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            module Order
              extend OpenAI::Internal::Type::Union

              variant(
                const: -> {
                  OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::ASC
                }
              )

              variant(
                const: -> {
                  OpenAI::Models::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::DESC
                }
              )

              # @!method self.variants
              #   @return [Array(Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias {
                  OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleListParams::Order::TaggedSymbol
                }
              end

              # @!group

              ASC = :asc
              DESC = :desc

              # @!endgroup
            end
          end
        end
      end
    end
  end
end
