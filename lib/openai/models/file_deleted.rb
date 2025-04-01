# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#delete
    class FileDeleted < OpenAI::BaseModel
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
      #   @return [Symbol, :file]
      required :object, const: :file

      # @!parse
      #   # @param id [String]
      #   # @param deleted [Boolean]
      #   # @param object [Symbol, :file]
      #   #
      #   def initialize(id:, deleted:, object: :file, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
