# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Groups#retrieve
          class GroupRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute group_id
            #
            #   @return [String]
            required :group_id, String

            # @!attribute group_type
            #   The type of group to retrieve.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::GroupRetrieveParams::GroupType, nil]
            optional :group_type, enum: -> { OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType }

            # @!method initialize(project_id:, group_id:, group_type: nil, request_options: {})
            #   @param project_id [String]
            #
            #   @param group_id [String]
            #
            #   @param group_type [Symbol, OpenAI::Models::Admin::Organization::Projects::GroupRetrieveParams::GroupType] The type of group to retrieve.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # The type of group to retrieve.
            module GroupType
              extend OpenAI::Internal::Type::Enum

              GROUP = :group
              TENANT_GROUP = :tenant_group

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
