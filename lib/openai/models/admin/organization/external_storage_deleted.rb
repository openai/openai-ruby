# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalStorage#delete
        class ExternalStorageDeleted < OpenAI::Internal::Type::BaseModel
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
          #   @return [Symbol, :"organization.external_storage.deleted"]
          required :object, const: :"organization.external_storage.deleted"

          # @!method initialize(id:, deleted:, object: :"organization.external_storage.deleted")
          #   @param id [String]
          #   @param deleted [Boolean]
          #   @param object [Symbol, :"organization.external_storage.deleted"]
        end
      end
    end
  end
end
