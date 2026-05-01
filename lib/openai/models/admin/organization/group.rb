# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Groups#create
        class Group < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier for the group.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   Unix timestamp (in seconds) when the group was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute group_type
          #   The type of the group.
          #
          #   @return [String]
          required :group_type, String

          # @!attribute is_scim_managed
          #   Whether the group is managed through SCIM and controlled by your identity
          #   provider.
          #
          #   @return [Boolean]
          required :is_scim_managed, OpenAI::Internal::Type::Boolean

          # @!attribute name
          #   Display name of the group.
          #
          #   @return [String]
          required :name, String

          # @!method initialize(id:, created_at:, group_type:, is_scim_managed:, name:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::Group} for more details.
          #
          #   Details about an organization group.
          #
          #   @param id [String] Identifier for the group.
          #
          #   @param created_at [Integer] Unix timestamp (in seconds) when the group was created.
          #
          #   @param group_type [String] The type of the group.
          #
          #   @param is_scim_managed [Boolean] Whether the group is managed through SCIM and controlled by your identity provid
          #
          #   @param name [String] Display name of the group.
        end
      end
    end
  end
end
