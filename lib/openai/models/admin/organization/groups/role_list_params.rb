# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Roles#list
          class RoleListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute group_id
            #
            #   @return [String]
            required :group_id, String

            # @!attribute after
            #   Cursor for pagination. Provide the value from the previous response's `next`
            #   field to continue listing organization roles.
            #
            #   @return [String, nil]
            optional :after, String

            # @!attribute limit
            #   A limit on the number of organization role assignments to return.
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!attribute order
            #   Sort order for the returned organization roles.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Groups::RoleListParams::Order, nil]
            optional :order, enum: -> { OpenAI::Admin::Organization::Groups::RoleListParams::Order }

            # @!method initialize(group_id:, after: nil, limit: nil, order: nil, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Groups::RoleListParams} for more details.
            #
            #   @param group_id [String]
            #
            #   @param after [String] Cursor for pagination. Provide the value from the previous response's `next` fie
            #
            #   @param limit [Integer] A limit on the number of organization role assignments to return.
            #
            #   @param order [Symbol, OpenAI::Models::Admin::Organization::Groups::RoleListParams::Order] Sort order for the returned organization roles.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Sort order for the returned organization roles.
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
end
