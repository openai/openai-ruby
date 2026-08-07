# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
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
      required :deleted, OpenAI::Internal::Type::Boolean

      # @!attribute object
      #
      #   @return [Symbol, :file]
      required :object, const: :file

      # @!method initialize(id:, deleted:, object: :file)
      #   @param id [String]
      #   @param deleted [Boolean]
      #   @param object [Symbol, :file]
    end
  end
end
