# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#delete
    class FileDeleted < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #
      #   @return [String]
      required :id, String

      # @!attribute deleted
      #
      #   @return [Boolean]
      required :deleted, OpenAI::Internal::Type::BooleanModel

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

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
