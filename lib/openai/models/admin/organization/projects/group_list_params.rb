# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Groups#list
          class GroupListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute after
            #   Cursor for pagination. Provide the ID of the last group from the previous
            #   response to fetch the next page.
            #
            #   @return [String, nil]
            optional :after, String

            # @!attribute limit
            #   A limit on the number of project groups to return. Defaults to 20.
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!attribute order
            #   Sort order for the returned groups.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::GroupListParams::Order, nil]
            optional :order, enum: -> { OpenAI::Admin::Organization::Projects::GroupListParams::Order }

            # @!method initialize(project_id:, after: nil, limit: nil, order: nil, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Projects::GroupListParams} for more
            #   details.
            #
            #   @param project_id [String]
            #
            #   @param after [String] Cursor for pagination. Provide the ID of the last group from the previous respon
            #
            #   @param limit [Integer] A limit on the number of project groups to return. Defaults to 20.
            #
            #   @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::GroupListParams::Order] Sort order for the returned groups.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Sort order for the returned groups.
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
