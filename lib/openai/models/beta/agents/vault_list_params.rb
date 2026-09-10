# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Vaults#list
        class VaultListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Return resources after this resource ID in the selected order.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   The maximum number of resources to return. Defaults to 20. Values are clamped
          #   between 1 and 100.
          #
          #   @return [Integer, nil]
          optional :limit, Integer, nil?: true

          # @!attribute order
          #   Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          #   `desc` for descending order. Defaults to `desc`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::VaultListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Beta::Agents::VaultListParams::Order }

          # @!attribute status
          #   Filter by one status or a list, such as `status=active` or
          #   `status[]=active&status[]=archived`. Both statuses are included by default.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::VaultStatus, Array<Symbol, OpenAI::Models::Beta::Agents::VaultStatus>, nil]
          optional :status, union: -> { OpenAI::Beta::Agents::VaultStatusFilter }

          # @!method initialize(after: nil, limit: nil, order: nil, status: nil, request_options: {})
          #   @param after [String]
          #     Return resources after this resource ID in the selected order.
          #
          #   @param limit [Integer, nil]
          #     The maximum number of resources to return. Defaults to 20. Values are clamped
          #     between 1 and 100.
          #
          #   @param order [Symbol, OpenAI::Models::Beta::Agents::VaultListParams::Order]
          #     Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          #     `desc` for descending order. Defaults to `desc`.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::Agents::VaultStatus, Array<Symbol, OpenAI::Models::Beta::Agents::VaultStatus>]
          #     Filter by one status or a list, such as `status=active` or
          #     `status[]=active&status[]=archived`. Both statuses are included by default.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `desc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            # Returns resources in ascending order.
            ASC = :asc

            # Returns resources in descending order.
            DESC = :desc

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
