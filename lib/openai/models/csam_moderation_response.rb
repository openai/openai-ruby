# frozen_string_literal: true

module OpenAI
  module Models
    class CsamModerationResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #
      #   @return [String]
      required :id, String

      # @!attribute model
      #
      #   @return [Symbol, :"omni-moderation-csam-latest"]
      required :model, const: :"omni-moderation-csam-latest"

      # @!attribute results
      #
      #   @return [Array<OpenAI::Models::CsamModeration>]
      required :results, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::CsamModeration] }

      # @!method initialize(id:, results:, model: :"omni-moderation-csam-latest")
      #   @param id [String]
      #   @param results [Array<OpenAI::Models::CsamModeration>]
      #   @param model [Symbol, :"omni-moderation-csam-latest"]
    end
  end
end
