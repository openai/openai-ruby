# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Groups#update
        class GroupUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute group_id
          #
          #   @return [String]
          required :group_id, String

          # @!attribute name
          #   New display name for the group.
          #
          #   @return [String]
          required :name, String

          # @!method initialize(group_id:, name:, request_options: {})
          #   @param group_id [String]
          #
          #   @param name [String] New display name for the group.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
