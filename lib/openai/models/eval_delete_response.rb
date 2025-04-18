# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#delete
    class EvalDeleteResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute deleted
      #
      #   @return [Boolean]
      required :deleted, OpenAI::Internal::Type::Boolean

      # @!attribute eval_id
      #
      #   @return [String]
      required :eval_id, String

      # @!attribute object
      #
      #   @return [String]
      required :object, String

      # @!method initialize(deleted:, eval_id:, object:)
      #   @param deleted [Boolean]
      #   @param eval_id [String]
      #   @param object [String]
    end
  end
end
