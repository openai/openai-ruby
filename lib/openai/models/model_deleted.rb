# frozen_string_literal: true

module OpenAI
  module Models
    class ModelDeleted < OpenAI::BaseModel
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
      #   @return [String]
      required :object, String

      # @!parse
      #   # @param id [String]
      #   # @param deleted [Boolean]
      #   # @param object [String]
      #   #
      #   def initialize(id:, deleted:, object:, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
