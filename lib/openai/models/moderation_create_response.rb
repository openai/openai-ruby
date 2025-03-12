# frozen_string_literal: true

module OpenAI
  module Models
    class ModerationCreateResponse < OpenAI::BaseModel
      # @!attribute id
      #   The unique identifier for the moderation request.
      #
      #   @return [String]
      required :id, String

      # @!attribute model
      #   The model used to generate the moderation results.
      #
      #   @return [String]
      required :model, String

      # @!attribute results
      #   A list of moderation objects.
      #
      #   @return [Array<OpenAI::Models::Moderation>]
      required :results, -> { OpenAI::ArrayOf[OpenAI::Models::Moderation] }

      # @!parse
      #   # Represents if a given text input is potentially harmful.
      #   #
      #   # @param id [String]
      #   # @param model [String]
      #   # @param results [Array<OpenAI::Models::Moderation>]
      #   #
      #   def initialize(id:, model:, results:, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
