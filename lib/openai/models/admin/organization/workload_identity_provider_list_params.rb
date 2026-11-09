# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::WorkloadIdentityProviders#list
        class WorkloadIdentityProviderListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

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
          #   @return [Symbol, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderListParams::Order, nil]
          optional :order, union: -> { OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order }

          # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
          #   @param after [String]
          #   @param limit [Integer]
          #   @param order [Symbol, OpenAI::Models::Admin::Organization::WorkloadIdentityProviderListParams::Order]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          module Order
            extend OpenAI::Internal::Type::Union

            variant const: -> { OpenAI::Models::Admin::Organization::WorkloadIdentityProviderListParams::Order::ASC }

            variant const: -> { OpenAI::Models::Admin::Organization::WorkloadIdentityProviderListParams::Order::DESC }

            # @!method self.variants
            #   @return [Array(Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::TaggedSymbol }
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
