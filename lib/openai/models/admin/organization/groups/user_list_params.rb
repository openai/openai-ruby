# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Users#list
          class UserListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute group_id
            #
            #   @return [String]
            required :group_id, String

            # @!attribute after
            #   A cursor for use in pagination. Provide the ID of the last user from the
            #   previous list response to retrieve the next page.
            #
            #   @return [String, nil]
            optional :after, String

            # @!attribute limit
            #   A limit on the number of users to be returned. Limit can range between 0 and
            #   1000, and the default is 100.
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!attribute order
            #   Specifies the sort order of users in the list.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Groups::UserListParams::Order, nil]
            optional :order, enum: -> { OpenAI::Admin::Organization::Groups::UserListParams::Order }

            # @!method initialize(group_id:, after: nil, limit: nil, order: nil, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Groups::UserListParams} for more details.
            #
            #   @param group_id [String]
            #
            #   @param after [String] A cursor for use in pagination. Provide the ID of the last user from the previou
            #
            #   @param limit [Integer] A limit on the number of users to be returned. Limit can range between 0 and 100
            #
            #   @param order [Symbol, OpenAI::Models::Admin::Organization::Groups::UserListParams::Order] Specifies the sort order of users in the list.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Specifies the sort order of users in the list.
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
