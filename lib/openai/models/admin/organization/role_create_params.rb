# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Roles#create
        class RoleCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute permissions
          #   Permissions to grant to the role.
          #
          #   @return [Array<String>]
          required :permissions, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute role_name
          #   Unique name for the role.
          #
          #   @return [String]
          required :role_name, String

          # @!attribute description
          #   Optional description of the role.
          #
          #   @return [String, nil]
          optional :description, String, nil?: true

          # @!method initialize(permissions:, role_name:, description: nil, request_options: {})
          #   @param permissions [Array<String>] Permissions to grant to the role.
          #
          #   @param role_name [String] Unique name for the role.
          #
          #   @param description [String, nil] Optional description of the role.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
