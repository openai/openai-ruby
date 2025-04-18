# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Moderations#create
    class ModerationCreateResponse < OpenAI::Internal::Type::BaseModel
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
      required :results, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Moderation] }

      # @!method initialize(id:, model:, results:)
      #   Represents if a given text input is potentially harmful.
      #
      #   @param id [String]
      #   @param model [String]
      #   @param results [Array<OpenAI::Models::Moderation>]
    end
  end
end
