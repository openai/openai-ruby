# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#delete
        class AdminAPIKeyDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #
          #   @return [String, nil]
          optional :id, String

          # @!attribute deleted
          #
          #   @return [Boolean, nil]
          optional :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #
          #   @return [String, nil]
          optional :object, String

          # @!method initialize(id: nil, deleted: nil, object: nil)
          #   @param id [String]
          #   @param deleted [Boolean]
          #   @param object [String]
        end
      end
    end
  end
end
