# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class EvalJSONLFileIDSource < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The identifier of the file.
        #
        #   @return [String]
        required :id, String

        # @!attribute type
        #   The type of jsonl source. Always `file_id`.
        #
        #   @return [Symbol, :file_id]
        required :type, const: :file_id

        # @!method initialize(id:, type: :file_id)
        #   @param id [String] The identifier of the file.
        #
        #   @param type [Symbol, :file_id] The type of jsonl source. Always `file_id`.
      end
    end

    EvalJSONLFileIDSource = Evals::EvalJSONLFileIDSource
  end
end
