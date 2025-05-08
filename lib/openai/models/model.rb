# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Models#retrieve
    class Model < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   The model identifier, which can be referenced in the API endpoints.
      #
      #   @return [String]
      required :id, String

      # @!attribute created
      #   The Unix timestamp (in seconds) when the model was created.
      #
      #   @return [Integer]
      required :created, Integer

      # @!attribute object
      #   The object type, which is always "model".
      #
      #   @return [Symbol, :model]
      required :object, const: :model

      # @!attribute owned_by
      #   The organization that owns the model.
      #
      #   @return [String]
      required :owned_by, String

      # @!method initialize(id:, created:, owned_by:, object: :model)
      #   Describes an OpenAI model offering that can be used with the API.
      #
      #   @param id [String] The model identifier, which can be referenced in the API endpoints.
      #
      #   @param created [Integer] The Unix timestamp (in seconds) when the model was created.
      #
      #   @param owned_by [String] The organization that owns the model.
      #
      #   @param object [Symbol, :model] The object type, which is always "model".
    end
  end
end
