# frozen_string_literal: true

module OpenAI
  module Models
    class CsamModeration < OpenAI::Internal::Type::BaseModel
      # @!attribute categories
      #   Whether the image was flagged in each category.
      #
      #   @return [OpenAI::Models::CsamModeration::Categories]
      required :categories, -> { OpenAI::CsamModeration::Categories }

      # @!attribute category_applied_input_types
      #   The input types evaluated for each category.
      #
      #   @return [OpenAI::Models::CsamModeration::CategoryAppliedInputTypes]
      required :category_applied_input_types, -> { OpenAI::CsamModeration::CategoryAppliedInputTypes }

      # @!attribute category_scores
      #   The classifier score for each category.
      #
      #   @return [OpenAI::Models::CsamModeration::CategoryScores]
      required :category_scores, -> { OpenAI::CsamModeration::CategoryScores }

      # @!attribute flagged
      #   Whether either CSAM category was flagged.
      #
      #   @return [Boolean]
      required :flagged, OpenAI::Internal::Type::Boolean

      # @!method initialize(categories:, category_applied_input_types:, category_scores:, flagged:)
      #   @param categories [OpenAI::Models::CsamModeration::Categories]
      #     Whether the image was flagged in each category.
      #
      #   @param category_applied_input_types [OpenAI::Models::CsamModeration::CategoryAppliedInputTypes]
      #     The input types evaluated for each category.
      #
      #   @param category_scores [OpenAI::Models::CsamModeration::CategoryScores]
      #     The classifier score for each category.
      #
      #   @param flagged [Boolean]
      #     Whether either CSAM category was flagged.

      # @see OpenAI::Models::CsamModeration#categories
      class Categories < OpenAI::Internal::Type::BaseModel
        # @!attribute likely_csam
        #
        #   @return [Boolean]
        required :likely_csam, OpenAI::Internal::Type::Boolean, api_name: :"likely-csam"

        # @!attribute likely_csam_gen_ai
        #
        #   @return [Boolean]
        required :likely_csam_gen_ai, OpenAI::Internal::Type::Boolean, api_name: :"likely-csam/gen-ai"

        # @!method initialize(likely_csam:, likely_csam_gen_ai:)
        #   Whether the image was flagged in each category.
        #
        #   @param likely_csam [Boolean]
        #   @param likely_csam_gen_ai [Boolean]
      end

      # @see OpenAI::Models::CsamModeration#category_applied_input_types
      class CategoryAppliedInputTypes < OpenAI::Internal::Type::BaseModel
        # @!attribute likely_csam
        #
        #   @return [Array<Symbol, OpenAI::Models::CsamModeration::CategoryAppliedInputTypes::LikelyCsam>]
        required(
          :likely_csam,
          -> {
            OpenAI::Internal::Type::ArrayOf[enum: OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsam]
          },
          api_name: :"likely-csam"
        )

        # @!attribute likely_csam_gen_ai
        #
        #   @return [Array<Symbol, OpenAI::Models::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi>]
        required(
          :likely_csam_gen_ai,
          -> {
            OpenAI::Internal::Type::ArrayOf[enum: OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi]
          },
          api_name: :"likely-csam/gen-ai"
        )

        # @!method initialize(likely_csam:, likely_csam_gen_ai:)
        #   The input types evaluated for each category.
        #
        #   @param likely_csam [Array<Symbol, OpenAI::Models::CsamModeration::CategoryAppliedInputTypes::LikelyCsam>]
        #   @param likely_csam_gen_ai [Array<Symbol, OpenAI::Models::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi>]

        module LikelyCsam
          extend OpenAI::Internal::Type::Enum

          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module LikelyCsamGenAi
          extend OpenAI::Internal::Type::Enum

          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      # @see OpenAI::Models::CsamModeration#category_scores
      class CategoryScores < OpenAI::Internal::Type::BaseModel
        # @!attribute likely_csam
        #
        #   @return [Float]
        required :likely_csam, Float, api_name: :"likely-csam"

        # @!attribute likely_csam_gen_ai
        #
        #   @return [Float]
        required :likely_csam_gen_ai, Float, api_name: :"likely-csam/gen-ai"

        # @!method initialize(likely_csam:, likely_csam_gen_ai:)
        #   The classifier score for each category.
        #
        #   @param likely_csam [Float]
        #   @param likely_csam_gen_ai [Float]
      end
    end
  end
end
