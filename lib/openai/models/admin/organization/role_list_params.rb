# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Roles#list
        class RoleListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Cursor for pagination. Provide the value from the previous response's `next`
          #   field to continue listing roles.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   A limit on the number of roles to return. Defaults to 1000.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   Sort order for the returned roles.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::RoleListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Admin::Organization::RoleListParams::Order }

          # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::RoleListParams} for more details.
          #
          #   @param after [String] Cursor for pagination. Provide the value from the previous response's `next` fie
          #
          #   @param limit [Integer] A limit on the number of roles to return. Defaults to 1000.
          #
          #   @param order [Symbol, OpenAI::Models::Admin::Organization::RoleListParams::Order] Sort order for the returned roles.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Sort order for the returned roles.
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
