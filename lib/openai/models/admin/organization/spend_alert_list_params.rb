# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendAlerts#list
        class SpendAlertListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Cursor for pagination. Provide the ID of the last spend alert from the previous
          #   response to fetch the next page.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute before
          #   Cursor for pagination. Provide the ID of the first spend alert from the previous
          #   response to fetch the previous page.
          #
          #   @return [String, nil]
          optional :before, String

          # @!attribute limit
          #   A limit on the number of spend alerts to return. Defaults to 20.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   Sort order for the returned spend alerts.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::SpendAlertListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Admin::Organization::SpendAlertListParams::Order }

          # @!method initialize(after: nil, before: nil, limit: nil, order: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::SpendAlertListParams} for more details.
          #
          #   @param after [String] Cursor for pagination. Provide the ID of the last spend alert from the previous
          #
          #   @param before [String] Cursor for pagination. Provide the ID of the first spend alert from the previous
          #
          #   @param limit [Integer] A limit on the number of spend alerts to return. Defaults to 20.
          #
          #   @param order [Symbol, OpenAI::Models::Admin::Organization::SpendAlertListParams::Order] Sort order for the returned spend alerts.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Sort order for the returned spend alerts.
          module Order
            extend OpenAI::Internal::Type::Enum

            ASC = :asc
            DESC = :desc

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
