# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Roles#update
        class RoleUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute role_id
          #
          #   @return [String]
          required :role_id, String

          # @!attribute description
          #   New description for the role.
          #
          #   @return [String, nil]
          optional :description, String, nil?: true

          # @!attribute permissions
          #   Updated set of permissions for the role.
          #
          #   @return [Array<String>, nil]
          optional :permissions, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute role_name
          #   New name for the role.
          #
          #   @return [String, nil]
          optional :role_name, String, nil?: true

          # @!method initialize(role_id:, description: nil, permissions: nil, role_name: nil, request_options: {})
          #   @param role_id [String]
          #
          #   @param description [String, nil] New description for the role.
          #
          #   @param permissions [Array<String>, nil] Updated set of permissions for the role.
          #
          #   @param role_name [String, nil] New name for the role.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
