# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Models#delete
    class ModelDeleted < OpenAI::Internal::Type::BaseModel
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
      #   @return [String]
      required :object, String

      # @!parse
      #   # @param id [String]
      #   # @param deleted [Boolean]
      #   # @param object [String]
      #   #
      #   def initialize(id:, deleted:, object:, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
