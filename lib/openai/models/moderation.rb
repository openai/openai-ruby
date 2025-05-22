# frozen_string_literal: true

module OpenAI
  module Models
    class Moderation < OpenAI::Internal::Type::BaseModel
      # @!attribute categories
      #   A list of the categories, and whether they are flagged or not.
      #
      #   @return [OpenAI::Models::Moderation::Categories]
      required :categories, -> { OpenAI::Moderation::Categories }

      # @!attribute category_applied_input_types
      #   A list of the categories along with the input type(s) that the score applies to.
      #
      #   @return [OpenAI::Models::Moderation::CategoryAppliedInputTypes]
      required :category_applied_input_types, -> { OpenAI::Moderation::CategoryAppliedInputTypes }

      # @!attribute category_scores
      #   A list of the categories along with their scores as predicted by model.
      #
      #   @return [OpenAI::Models::Moderation::CategoryScores]
      required :category_scores, -> { OpenAI::Moderation::CategoryScores }

      # @!attribute flagged
      #   Whether any of the below categories are flagged.
      #
      #   @return [Boolean]
      required :flagged, OpenAI::Internal::Type::Boolean

      # @!method initialize(categories:, category_applied_input_types:, category_scores:, flagged:)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::Moderation} for more details.
      #
      #   @param categories [OpenAI::Models::Moderation::Categories] A list of the categories, and whether they are flagged or not.
      #
      #   @param category_applied_input_types [OpenAI::Models::Moderation::CategoryAppliedInputTypes] A list of the categories along with the input type(s) that the score applies to.
      #
      #   @param category_scores [OpenAI::Models::Moderation::CategoryScores] A list of the categories along with their scores as predicted by model.
      #
      #   @param flagged [Boolean] Whether any of the below categories are flagged.

      # @see OpenAI::Models::Moderation#categories
      class Categories < OpenAI::Internal::Type::BaseModel
        # @!attribute harassment
        #   Content that expresses, incites, or promotes harassing language towards any
        #   target.
        #
        #   @return [Boolean]
        required :harassment, OpenAI::Internal::Type::Boolean

        # @!attribute harassment_threatening
        #   Harassment content that also includes violence or serious harm towards any
        #   target.
        #
        #   @return [Boolean]
        required :harassment_threatening, OpenAI::Internal::Type::Boolean, api_name: :"harassment/threatening"

        # @!attribute hate
        #   Content that expresses, incites, or promotes hate based on race, gender,
        #   ethnicity, religion, nationality, sexual orientation, disability status, or
        #   caste. Hateful content aimed at non-protected groups (e.g., chess players) is
        #   harassment.
        #
        #   @return [Boolean]
        required :hate, OpenAI::Internal::Type::Boolean

        # @!attribute hate_threatening
        #   Hateful content that also includes violence or serious harm towards the targeted
        #   group based on race, gender, ethnicity, religion, nationality, sexual
        #   orientation, disability status, or caste.
        #
        #   @return [Boolean]
        required :hate_threatening, OpenAI::Internal::Type::Boolean, api_name: :"hate/threatening"

        # @!attribute illicit
        #   Content that includes instructions or advice that facilitate the planning or
        #   execution of wrongdoing, or that gives advice or instruction on how to commit
        #   illicit acts. For example, "how to shoplift" would fit this category.
        #
        #   @return [Boolean, nil]
        required :illicit, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute illicit_violent
        #   Content that includes instructions or advice that facilitate the planning or
        #   execution of wrongdoing that also includes violence, or that gives advice or
        #   instruction on the procurement of any weapon.
        #
        #   @return [Boolean, nil]
        required :illicit_violent, OpenAI::Internal::Type::Boolean, api_name: :"illicit/violent", nil?: true

        # @!attribute self_harm
        #   Content that promotes, encourages, or depicts acts of self-harm, such as
        #   suicide, cutting, and eating disorders.
        #
        #   @return [Boolean]
        required :self_harm, OpenAI::Internal::Type::Boolean, api_name: :"self-harm"

        # @!attribute self_harm_instructions
        #   Content that encourages performing acts of self-harm, such as suicide, cutting,
        #   and eating disorders, or that gives instructions or advice on how to commit such
        #   acts.
        #
        #   @return [Boolean]
        required :self_harm_instructions, OpenAI::Internal::Type::Boolean, api_name: :"self-harm/instructions"

        # @!attribute self_harm_intent
        #   Content where the speaker expresses that they are engaging or intend to engage
        #   in acts of self-harm, such as suicide, cutting, and eating disorders.
        #
        #   @return [Boolean]
        required :self_harm_intent, OpenAI::Internal::Type::Boolean, api_name: :"self-harm/intent"

        # @!attribute sexual
        #   Content meant to arouse sexual excitement, such as the description of sexual
        #   activity, or that promotes sexual services (excluding sex education and
        #   wellness).
        #
        #   @return [Boolean]
        required :sexual, OpenAI::Internal::Type::Boolean

        # @!attribute sexual_minors
        #   Sexual content that includes an individual who is under 18 years old.
        #
        #   @return [Boolean]
        required :sexual_minors, OpenAI::Internal::Type::Boolean, api_name: :"sexual/minors"

        # @!attribute violence
        #   Content that depicts death, violence, or physical injury.
        #
        #   @return [Boolean]
        required :violence, OpenAI::Internal::Type::Boolean

        # @!attribute violence_graphic
        #   Content that depicts death, violence, or physical injury in graphic detail.
        #
        #   @return [Boolean]
        required :violence_graphic, OpenAI::Internal::Type::Boolean, api_name: :"violence/graphic"

        # @!method initialize(harassment:, harassment_threatening:, hate:, hate_threatening:, illicit:, illicit_violent:, self_harm:, self_harm_instructions:, self_harm_intent:, sexual:, sexual_minors:, violence:, violence_graphic:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Moderation::Categories} for more details.
        #
        #   A list of the categories, and whether they are flagged or not.
        #
        #   @param harassment [Boolean] Content that expresses, incites, or promotes harassing language towards any targ
        #
        #   @param harassment_threatening [Boolean] Harassment content that also includes violence or serious harm towards any targe
        #
        #   @param hate [Boolean] Content that expresses, incites, or promotes hate based on race, gender, ethnici
        #
        #   @param hate_threatening [Boolean] Hateful content that also includes violence or serious harm towards the targeted
        #
        #   @param illicit [Boolean, nil] Content that includes instructions or advice that facilitate the planning or exe
        #
        #   @param illicit_violent [Boolean, nil] Content that includes instructions or advice that facilitate the planning or exe
        #
        #   @param self_harm [Boolean] Content that promotes, encourages, or depicts acts of self-harm, such as suicide
        #
        #   @param self_harm_instructions [Boolean] Content that encourages performing acts of self-harm, such as suicide, cutting,
        #
        #   @param self_harm_intent [Boolean] Content where the speaker expresses that they are engaging or intend to engage i
        #
        #   @param sexual [Boolean] Content meant to arouse sexual excitement, such as the description of sexual act
        #
        #   @param sexual_minors [Boolean] Sexual content that includes an individual who is under 18 years old.
        #
        #   @param violence [Boolean] Content that depicts death, violence, or physical injury.
        #
        #   @param violence_graphic [Boolean] Content that depicts death, violence, or physical injury in graphic detail.
      end

      # @see OpenAI::Models::Moderation#category_applied_input_types
      class CategoryAppliedInputTypes < OpenAI::Internal::Type::BaseModel
        # @!attribute harassment
        #   The applied input type(s) for the category 'harassment'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment>]
        required :harassment,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::Harassment]
                 }

        # @!attribute harassment_threatening
        #   The applied input type(s) for the category 'harassment/threatening'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening>]
        required :harassment_threatening,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::HarassmentThreatening]
                 },
                 api_name: :"harassment/threatening"

        # @!attribute hate
        #   The applied input type(s) for the category 'hate'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate>]
        required :hate,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::Hate]
                 }

        # @!attribute hate_threatening
        #   The applied input type(s) for the category 'hate/threatening'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening>]
        required :hate_threatening,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::HateThreatening]
                 },
                 api_name: :"hate/threatening"

        # @!attribute illicit
        #   The applied input type(s) for the category 'illicit'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit>]
        required :illicit,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::Illicit]
                 }

        # @!attribute illicit_violent
        #   The applied input type(s) for the category 'illicit/violent'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent>]
        required :illicit_violent,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::IllicitViolent]
                 },
                 api_name: :"illicit/violent"

        # @!attribute self_harm
        #   The applied input type(s) for the category 'self-harm'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm>]
        required :self_harm,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm]
                 },
                 api_name: :"self-harm"

        # @!attribute self_harm_instructions
        #   The applied input type(s) for the category 'self-harm/instructions'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction>]
        required :self_harm_instructions,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction]
                 },
                 api_name: :"self-harm/instructions"

        # @!attribute self_harm_intent
        #   The applied input type(s) for the category 'self-harm/intent'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent>]
        required :self_harm_intent,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent]
                 },
                 api_name: :"self-harm/intent"

        # @!attribute sexual
        #   The applied input type(s) for the category 'sexual'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual>]
        required :sexual,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::Sexual]
                 }

        # @!attribute sexual_minors
        #   The applied input type(s) for the category 'sexual/minors'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor>]
        required :sexual_minors,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::SexualMinor]
                 },
                 api_name: :"sexual/minors"

        # @!attribute violence
        #   The applied input type(s) for the category 'violence'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence>]
        required :violence,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::Violence]
                 }

        # @!attribute violence_graphic
        #   The applied input type(s) for the category 'violence/graphic'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic>]
        required :violence_graphic,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic]
                 },
                 api_name: :"violence/graphic"

        # @!method initialize(harassment:, harassment_threatening:, hate:, hate_threatening:, illicit:, illicit_violent:, self_harm:, self_harm_instructions:, self_harm_intent:, sexual:, sexual_minors:, violence:, violence_graphic:)
        #   A list of the categories along with the input type(s) that the score applies to.
        #
        #   @param harassment [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment>] The applied input type(s) for the category 'harassment'.
        #
        #   @param harassment_threatening [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening>] The applied input type(s) for the category 'harassment/threatening'.
        #
        #   @param hate [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate>] The applied input type(s) for the category 'hate'.
        #
        #   @param hate_threatening [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening>] The applied input type(s) for the category 'hate/threatening'.
        #
        #   @param illicit [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit>] The applied input type(s) for the category 'illicit'.
        #
        #   @param illicit_violent [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent>] The applied input type(s) for the category 'illicit/violent'.
        #
        #   @param self_harm [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm>] The applied input type(s) for the category 'self-harm'.
        #
        #   @param self_harm_instructions [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction>] The applied input type(s) for the category 'self-harm/instructions'.
        #
        #   @param self_harm_intent [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent>] The applied input type(s) for the category 'self-harm/intent'.
        #
        #   @param sexual [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual>] The applied input type(s) for the category 'sexual'.
        #
        #   @param sexual_minors [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor>] The applied input type(s) for the category 'sexual/minors'.
        #
        #   @param violence [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence>] The applied input type(s) for the category 'violence'.
        #
        #   @param violence_graphic [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic>] The applied input type(s) for the category 'violence/graphic'.

        module Harassment
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module HarassmentThreatening
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module Hate
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module HateThreatening
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module Illicit
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module IllicitViolent
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module SelfHarm
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module SelfHarmInstruction
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module SelfHarmIntent
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module Sexual
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module SexualMinor
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module Violence
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        module ViolenceGraphic
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          IMAGE = :image

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      # @see OpenAI::Models::Moderation#category_scores
      class CategoryScores < OpenAI::Internal::Type::BaseModel
        # @!attribute harassment
        #   The score for the category 'harassment'.
        #
        #   @return [Float]
        required :harassment, Float

        # @!attribute harassment_threatening
        #   The score for the category 'harassment/threatening'.
        #
        #   @return [Float]
        required :harassment_threatening, Float, api_name: :"harassment/threatening"

        # @!attribute hate
        #   The score for the category 'hate'.
        #
        #   @return [Float]
        required :hate, Float

        # @!attribute hate_threatening
        #   The score for the category 'hate/threatening'.
        #
        #   @return [Float]
        required :hate_threatening, Float, api_name: :"hate/threatening"

        # @!attribute illicit
        #   The score for the category 'illicit'.
        #
        #   @return [Float]
        required :illicit, Float

        # @!attribute illicit_violent
        #   The score for the category 'illicit/violent'.
        #
        #   @return [Float]
        required :illicit_violent, Float, api_name: :"illicit/violent"

        # @!attribute self_harm
        #   The score for the category 'self-harm'.
        #
        #   @return [Float]
        required :self_harm, Float, api_name: :"self-harm"

        # @!attribute self_harm_instructions
        #   The score for the category 'self-harm/instructions'.
        #
        #   @return [Float]
        required :self_harm_instructions, Float, api_name: :"self-harm/instructions"

        # @!attribute self_harm_intent
        #   The score for the category 'self-harm/intent'.
        #
        #   @return [Float]
        required :self_harm_intent, Float, api_name: :"self-harm/intent"

        # @!attribute sexual
        #   The score for the category 'sexual'.
        #
        #   @return [Float]
        required :sexual, Float

        # @!attribute sexual_minors
        #   The score for the category 'sexual/minors'.
        #
        #   @return [Float]
        required :sexual_minors, Float, api_name: :"sexual/minors"

        # @!attribute violence
        #   The score for the category 'violence'.
        #
        #   @return [Float]
        required :violence, Float

        # @!attribute violence_graphic
        #   The score for the category 'violence/graphic'.
        #
        #   @return [Float]
        required :violence_graphic, Float, api_name: :"violence/graphic"

        # @!method initialize(harassment:, harassment_threatening:, hate:, hate_threatening:, illicit:, illicit_violent:, self_harm:, self_harm_instructions:, self_harm_intent:, sexual:, sexual_minors:, violence:, violence_graphic:)
        #   A list of the categories along with their scores as predicted by model.
        #
        #   @param harassment [Float] The score for the category 'harassment'.
        #
        #   @param harassment_threatening [Float] The score for the category 'harassment/threatening'.
        #
        #   @param hate [Float] The score for the category 'hate'.
        #
        #   @param hate_threatening [Float] The score for the category 'hate/threatening'.
        #
        #   @param illicit [Float] The score for the category 'illicit'.
        #
        #   @param illicit_violent [Float] The score for the category 'illicit/violent'.
        #
        #   @param self_harm [Float] The score for the category 'self-harm'.
        #
        #   @param self_harm_instructions [Float] The score for the category 'self-harm/instructions'.
        #
        #   @param self_harm_intent [Float] The score for the category 'self-harm/intent'.
        #
        #   @param sexual [Float] The score for the category 'sexual'.
        #
        #   @param sexual_minors [Float] The score for the category 'sexual/minors'.
        #
        #   @param violence [Float] The score for the category 'violence'.
        #
        #   @param violence_graphic [Float] The score for the category 'violence/graphic'.
      end
    end
  end
end
