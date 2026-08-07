# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#delete
        class AdminAPIKeyDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #
          #   @return [Symbol, :"organization.admin_api_key.deleted"]
          required :object, const: :"organization.admin_api_key.deleted"

          # @!method initialize(id:, deleted:, object: :"organization.admin_api_key.deleted")
          #   @param id [String]
          #   @param deleted [Boolean]
          #   @param object [Symbol, :"organization.admin_api_key.deleted"]
        end
      end
    end
  end
end
