# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Users#delete
        class UserDeleteResponse < OpenAI::Internal::Type::BaseModel
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
          #   @return [Symbol, :"organization.user.deleted"]
          required :object, const: :"organization.user.deleted"

          # @!method initialize(id:, deleted:, object: :"organization.user.deleted")
          #   @param id [String]
          #   @param deleted [Boolean]
          #   @param object [Symbol, :"organization.user.deleted"]
        end
      end
    end
  end
end
