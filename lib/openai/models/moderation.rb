# frozen_string_literal: true

module OpenAI
  module Models
    class Moderation < OpenAI::BaseModel
      # @!attribute categories
      #   A list of the categories, and whether they are flagged or not.
      #
      #   @return [OpenAI::Models::Moderation::Categories]
      required :categories, -> { OpenAI::Models::Moderation::Categories }

      # @!attribute category_applied_input_types
      #   A list of the categories along with the input type(s) that the score applies to.
      #
      #   @return [OpenAI::Models::Moderation::CategoryAppliedInputTypes]
      required :category_applied_input_types, -> { OpenAI::Models::Moderation::CategoryAppliedInputTypes }

      # @!attribute category_scores
      #   A list of the categories along with their scores as predicted by model.
      #
      #   @return [OpenAI::Models::Moderation::CategoryScores]
      required :category_scores, -> { OpenAI::Models::Moderation::CategoryScores }

      # @!attribute flagged
      #   Whether any of the below categories are flagged.
      #
      #   @return [Boolean]
      required :flagged, OpenAI::BooleanModel

      # @!parse
      #   # @param categories [OpenAI::Models::Moderation::Categories]
      #   # @param category_applied_input_types [OpenAI::Models::Moderation::CategoryAppliedInputTypes]
      #   # @param category_scores [OpenAI::Models::Moderation::CategoryScores]
      #   # @param flagged [Boolean]
      #   #
      #   def initialize(categories:, category_applied_input_types:, category_scores:, flagged:, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      class Categories < OpenAI::BaseModel
        # @!attribute harassment
        #   Content that expresses, incites, or promotes harassing language towards any
        #     target.
        #
        #   @return [Boolean]
        required :harassment, OpenAI::BooleanModel

        # @!attribute harassment_threatening
        #   Harassment content that also includes violence or serious harm towards any
        #     target.
        #
        #   @return [Boolean]
        required :harassment_threatening, OpenAI::BooleanModel, api_name: :"harassment/threatening"

        # @!attribute hate
        #   Content that expresses, incites, or promotes hate based on race, gender,
        #     ethnicity, religion, nationality, sexual orientation, disability status, or
        #     caste. Hateful content aimed at non-protected groups (e.g., chess players) is
        #     harassment.
        #
        #   @return [Boolean]
        required :hate, OpenAI::BooleanModel

        # @!attribute hate_threatening
        #   Hateful content that also includes violence or serious harm towards the targeted
        #     group based on race, gender, ethnicity, religion, nationality, sexual
        #     orientation, disability status, or caste.
        #
        #   @return [Boolean]
        required :hate_threatening, OpenAI::BooleanModel, api_name: :"hate/threatening"

        # @!attribute illicit
        #   Content that includes instructions or advice that facilitate the planning or
        #     execution of wrongdoing, or that gives advice or instruction on how to commit
        #     illicit acts. For example, "how to shoplift" would fit this category.
        #
        #   @return [Boolean, nil]
        required :illicit, OpenAI::BooleanModel, nil?: true

        # @!attribute illicit_violent
        #   Content that includes instructions or advice that facilitate the planning or
        #     execution of wrongdoing that also includes violence, or that gives advice or
        #     instruction on the procurement of any weapon.
        #
        #   @return [Boolean, nil]
        required :illicit_violent, OpenAI::BooleanModel, api_name: :"illicit/violent", nil?: true

        # @!attribute self_harm
        #   Content that promotes, encourages, or depicts acts of self-harm, such as
        #     suicide, cutting, and eating disorders.
        #
        #   @return [Boolean]
        required :self_harm, OpenAI::BooleanModel, api_name: :"self-harm"

        # @!attribute self_harm_instructions
        #   Content that encourages performing acts of self-harm, such as suicide, cutting,
        #     and eating disorders, or that gives instructions or advice on how to commit such
        #     acts.
        #
        #   @return [Boolean]
        required :self_harm_instructions, OpenAI::BooleanModel, api_name: :"self-harm/instructions"

        # @!attribute self_harm_intent
        #   Content where the speaker expresses that they are engaging or intend to engage
        #     in acts of self-harm, such as suicide, cutting, and eating disorders.
        #
        #   @return [Boolean]
        required :self_harm_intent, OpenAI::BooleanModel, api_name: :"self-harm/intent"

        # @!attribute sexual
        #   Content meant to arouse sexual excitement, such as the description of sexual
        #     activity, or that promotes sexual services (excluding sex education and
        #     wellness).
        #
        #   @return [Boolean]
        required :sexual, OpenAI::BooleanModel

        # @!attribute sexual_minors
        #   Sexual content that includes an individual who is under 18 years old.
        #
        #   @return [Boolean]
        required :sexual_minors, OpenAI::BooleanModel, api_name: :"sexual/minors"

        # @!attribute violence
        #   Content that depicts death, violence, or physical injury.
        #
        #   @return [Boolean]
        required :violence, OpenAI::BooleanModel

        # @!attribute violence_graphic
        #   Content that depicts death, violence, or physical injury in graphic detail.
        #
        #   @return [Boolean]
        required :violence_graphic, OpenAI::BooleanModel, api_name: :"violence/graphic"

        # @!parse
        #   # A list of the categories, and whether they are flagged or not.
        #   #
        #   # @param harassment [Boolean]
        #   # @param harassment_threatening [Boolean]
        #   # @param hate [Boolean]
        #   # @param hate_threatening [Boolean]
        #   # @param illicit [Boolean, nil]
        #   # @param illicit_violent [Boolean, nil]
        #   # @param self_harm [Boolean]
        #   # @param self_harm_instructions [Boolean]
        #   # @param self_harm_intent [Boolean]
        #   # @param sexual [Boolean]
        #   # @param sexual_minors [Boolean]
        #   # @param violence [Boolean]
        #   # @param violence_graphic [Boolean]
        #   #
        #   def initialize(
        #     harassment:,
        #     harassment_threatening:,
        #     hate:,
        #     hate_threatening:,
        #     illicit:,
        #     illicit_violent:,
        #     self_harm:,
        #     self_harm_instructions:,
        #     self_harm_intent:,
        #     sexual:,
        #     sexual_minors:,
        #     violence:,
        #     violence_graphic:,
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end

      class CategoryAppliedInputTypes < OpenAI::BaseModel
        # @!attribute harassment
        #   The applied input type(s) for the category 'harassment'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment>]
        required :harassment,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment] }

        # @!attribute harassment_threatening
        #   The applied input type(s) for the category 'harassment/threatening'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening>]
        required :harassment_threatening,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening] },
                 api_name: :"harassment/threatening"

        # @!attribute hate
        #   The applied input type(s) for the category 'hate'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate>]
        required :hate, -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate] }

        # @!attribute hate_threatening
        #   The applied input type(s) for the category 'hate/threatening'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening>]
        required :hate_threatening,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening] },
                 api_name: :"hate/threatening"

        # @!attribute illicit
        #   The applied input type(s) for the category 'illicit'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit>]
        required :illicit,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit] }

        # @!attribute illicit_violent
        #   The applied input type(s) for the category 'illicit/violent'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent>]
        required :illicit_violent,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent] },
                 api_name: :"illicit/violent"

        # @!attribute self_harm
        #   The applied input type(s) for the category 'self-harm'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm>]
        required :self_harm,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm] },
                 api_name: :"self-harm"

        # @!attribute self_harm_instructions
        #   The applied input type(s) for the category 'self-harm/instructions'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction>]
        required :self_harm_instructions,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction] },
                 api_name: :"self-harm/instructions"

        # @!attribute self_harm_intent
        #   The applied input type(s) for the category 'self-harm/intent'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent>]
        required :self_harm_intent,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent] },
                 api_name: :"self-harm/intent"

        # @!attribute sexual
        #   The applied input type(s) for the category 'sexual'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual>]
        required :sexual,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual] }

        # @!attribute sexual_minors
        #   The applied input type(s) for the category 'sexual/minors'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor>]
        required :sexual_minors,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor] },
                 api_name: :"sexual/minors"

        # @!attribute violence
        #   The applied input type(s) for the category 'violence'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence>]
        required :violence,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence] }

        # @!attribute violence_graphic
        #   The applied input type(s) for the category 'violence/graphic'.
        #
        #   @return [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic>]
        required :violence_graphic,
                 -> { OpenAI::ArrayOf[enum: OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic] },
                 api_name: :"violence/graphic"

        # @!parse
        #   # A list of the categories along with the input type(s) that the score applies to.
        #   #
        #   # @param harassment [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment>]
        #   # @param harassment_threatening [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening>]
        #   # @param hate [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate>]
        #   # @param hate_threatening [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening>]
        #   # @param illicit [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit>]
        #   # @param illicit_violent [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent>]
        #   # @param self_harm [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm>]
        #   # @param self_harm_instructions [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction>]
        #   # @param self_harm_intent [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent>]
        #   # @param sexual [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual>]
        #   # @param sexual_minors [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor>]
        #   # @param violence [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence>]
        #   # @param violence_graphic [Array<Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic>]
        #   #
        #   def initialize(
        #     harassment:,
        #     harassment_threatening:,
        #     hate:,
        #     hate_threatening:,
        #     illicit:,
        #     illicit_violent:,
        #     self_harm:,
        #     self_harm_instructions:,
        #     self_harm_intent:,
        #     sexual:,
        #     sexual_minors:,
        #     violence:,
        #     violence_graphic:,
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        class Harassment < OpenAI::Enum
          TEXT = :text

          finalize!
        end

        # @abstract
        #
        class HarassmentThreatening < OpenAI::Enum
          TEXT = :text

          finalize!
        end

        # @abstract
        #
        class Hate < OpenAI::Enum
          TEXT = :text

          finalize!
        end

        # @abstract
        #
        class HateThreatening < OpenAI::Enum
          TEXT = :text

          finalize!
        end

        # @abstract
        #
        class Illicit < OpenAI::Enum
          TEXT = :text

          finalize!
        end

        # @abstract
        #
        class IllicitViolent < OpenAI::Enum
          TEXT = :text

          finalize!
        end

        # @abstract
        #
        class SelfHarm < OpenAI::Enum
          TEXT = :text
          IMAGE = :image

          finalize!
        end

        # @abstract
        #
        class SelfHarmInstruction < OpenAI::Enum
          TEXT = :text
          IMAGE = :image

          finalize!
        end

        # @abstract
        #
        class SelfHarmIntent < OpenAI::Enum
          TEXT = :text
          IMAGE = :image

          finalize!
        end

        # @abstract
        #
        class Sexual < OpenAI::Enum
          TEXT = :text
          IMAGE = :image

          finalize!
        end

        # @abstract
        #
        class SexualMinor < OpenAI::Enum
          TEXT = :text

          finalize!
        end

        # @abstract
        #
        class Violence < OpenAI::Enum
          TEXT = :text
          IMAGE = :image

          finalize!
        end

        # @abstract
        #
        class ViolenceGraphic < OpenAI::Enum
          TEXT = :text
          IMAGE = :image

          finalize!
        end
      end

      class CategoryScores < OpenAI::BaseModel
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

        # @!parse
        #   # A list of the categories along with their scores as predicted by model.
        #   #
        #   # @param harassment [Float]
        #   # @param harassment_threatening [Float]
        #   # @param hate [Float]
        #   # @param hate_threatening [Float]
        #   # @param illicit [Float]
        #   # @param illicit_violent [Float]
        #   # @param self_harm [Float]
        #   # @param self_harm_instructions [Float]
        #   # @param self_harm_intent [Float]
        #   # @param sexual [Float]
        #   # @param sexual_minors [Float]
        #   # @param violence [Float]
        #   # @param violence_graphic [Float]
        #   #
        #   def initialize(
        #     harassment:,
        #     harassment_threatening:,
        #     hate:,
        #     hate_threatening:,
        #     illicit:,
        #     illicit_violent:,
        #     self_harm:,
        #     self_harm_instructions:,
        #     self_harm_intent:,
        #     sexual:,
        #     sexual_minors:,
        #     violence:,
        #     violence_graphic:,
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
