# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Assistants#delete
      class AssistantDeleted < OpenAI::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #
        #   @return [Boolean]
        required :deleted, OpenAI::BooleanModel

        # @!attribute object
        #
        #   @return [Symbol, :"assistant.deleted"]
        required :object, const: :"assistant.deleted"

        # @!parse
        #   # @param id [String]
        #   # @param deleted [Boolean]
        #   # @param object [Symbol, :"assistant.deleted"]
        #   #
        #   def initialize(id:, deleted:, object: :"assistant.deleted", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
