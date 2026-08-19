# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Assistants#delete
      class AssistantDeleted < OpenAI::Internal::Type::BaseModel
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
        #   @return [Symbol, :"assistant.deleted"]
        required :object, const: :"assistant.deleted"

        # @!method initialize(id:, deleted:, object: :"assistant.deleted")
        #   @param id [String]
        #   @param deleted [Boolean]
        #   @param object [Symbol, :"assistant.deleted"]
      end
    end
  end
end
