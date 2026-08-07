# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Groups#list
        class GroupListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   A cursor for use in pagination. `after` is a group ID that defines your place in
          #   the list. For instance, if you make a list request and receive 100 objects,
          #   ending with group_abc, your subsequent call can include `after=group_abc` in
          #   order to fetch the next page of the list.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   A limit on the number of groups to be returned. Limit can range between 0 and
          #   1000, and the default is 100.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   Specifies the sort order of the returned groups.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::GroupListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Admin::Organization::GroupListParams::Order }

          # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::GroupListParams} for more details.
          #
          #   @param after [String] A cursor for use in pagination. `after` is a group ID that defines your place in
          #
          #   @param limit [Integer] A limit on the number of groups to be returned. Limit can range between 0 and 10
          #
          #   @param order [Symbol, OpenAI::Models::Admin::Organization::GroupListParams::Order] Specifies the sort order of the returned groups.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Specifies the sort order of the returned groups.
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
