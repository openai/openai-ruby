# typed: strong

module OpenAI
  module Models
    class Moderation < OpenAI::BaseModel
      # A list of the categories, and whether they are flagged or not.
      sig { returns(OpenAI::Models::Moderation::Categories) }
      def categories
      end

      sig { params(_: OpenAI::Models::Moderation::Categories).returns(OpenAI::Models::Moderation::Categories) }
      def categories=(_)
      end

      # A list of the categories along with the input type(s) that the score applies to.
      sig { returns(OpenAI::Models::Moderation::CategoryAppliedInputTypes) }
      def category_applied_input_types
      end

      sig do
        params(_: OpenAI::Models::Moderation::CategoryAppliedInputTypes)
          .returns(OpenAI::Models::Moderation::CategoryAppliedInputTypes)
      end
      def category_applied_input_types=(_)
      end

      # A list of the categories along with their scores as predicted by model.
      sig { returns(OpenAI::Models::Moderation::CategoryScores) }
      def category_scores
      end

      sig { params(_: OpenAI::Models::Moderation::CategoryScores).returns(OpenAI::Models::Moderation::CategoryScores) }
      def category_scores=(_)
      end

      # Whether any of the below categories are flagged.
      sig { returns(T::Boolean) }
      def flagged
      end

      sig { params(_: T::Boolean).returns(T::Boolean) }
      def flagged=(_)
      end

      sig do
        params(
          categories: OpenAI::Models::Moderation::Categories,
          category_applied_input_types: OpenAI::Models::Moderation::CategoryAppliedInputTypes,
          category_scores: OpenAI::Models::Moderation::CategoryScores,
          flagged: T::Boolean
        )
          .returns(T.attached_class)
      end
      def self.new(categories:, category_applied_input_types:, category_scores:, flagged:)
      end

      sig do
        override
          .returns(
            {
              categories: OpenAI::Models::Moderation::Categories,
              category_applied_input_types: OpenAI::Models::Moderation::CategoryAppliedInputTypes,
              category_scores: OpenAI::Models::Moderation::CategoryScores,
              flagged: T::Boolean
            }
          )
      end
      def to_hash
      end

      class Categories < OpenAI::BaseModel
        # Content that expresses, incites, or promotes harassing language towards any
        #   target.
        sig { returns(T::Boolean) }
        def harassment
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def harassment=(_)
        end

        # Harassment content that also includes violence or serious harm towards any
        #   target.
        sig { returns(T::Boolean) }
        def harassment_threatening
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def harassment_threatening=(_)
        end

        # Content that expresses, incites, or promotes hate based on race, gender,
        #   ethnicity, religion, nationality, sexual orientation, disability status, or
        #   caste. Hateful content aimed at non-protected groups (e.g., chess players) is
        #   harassment.
        sig { returns(T::Boolean) }
        def hate
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def hate=(_)
        end

        # Hateful content that also includes violence or serious harm towards the targeted
        #   group based on race, gender, ethnicity, religion, nationality, sexual
        #   orientation, disability status, or caste.
        sig { returns(T::Boolean) }
        def hate_threatening
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def hate_threatening=(_)
        end

        # Content that includes instructions or advice that facilitate the planning or
        #   execution of wrongdoing, or that gives advice or instruction on how to commit
        #   illicit acts. For example, "how to shoplift" would fit this category.
        sig { returns(T.nilable(T::Boolean)) }
        def illicit
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def illicit=(_)
        end

        # Content that includes instructions or advice that facilitate the planning or
        #   execution of wrongdoing that also includes violence, or that gives advice or
        #   instruction on the procurement of any weapon.
        sig { returns(T.nilable(T::Boolean)) }
        def illicit_violent
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def illicit_violent=(_)
        end

        # Content that promotes, encourages, or depicts acts of self-harm, such as
        #   suicide, cutting, and eating disorders.
        sig { returns(T::Boolean) }
        def self_harm
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def self_harm=(_)
        end

        # Content that encourages performing acts of self-harm, such as suicide, cutting,
        #   and eating disorders, or that gives instructions or advice on how to commit such
        #   acts.
        sig { returns(T::Boolean) }
        def self_harm_instructions
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def self_harm_instructions=(_)
        end

        # Content where the speaker expresses that they are engaging or intend to engage
        #   in acts of self-harm, such as suicide, cutting, and eating disorders.
        sig { returns(T::Boolean) }
        def self_harm_intent
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def self_harm_intent=(_)
        end

        # Content meant to arouse sexual excitement, such as the description of sexual
        #   activity, or that promotes sexual services (excluding sex education and
        #   wellness).
        sig { returns(T::Boolean) }
        def sexual
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def sexual=(_)
        end

        # Sexual content that includes an individual who is under 18 years old.
        sig { returns(T::Boolean) }
        def sexual_minors
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def sexual_minors=(_)
        end

        # Content that depicts death, violence, or physical injury.
        sig { returns(T::Boolean) }
        def violence
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def violence=(_)
        end

        # Content that depicts death, violence, or physical injury in graphic detail.
        sig { returns(T::Boolean) }
        def violence_graphic
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def violence_graphic=(_)
        end

        # A list of the categories, and whether they are flagged or not.
        sig do
          params(
            harassment: T::Boolean,
            harassment_threatening: T::Boolean,
            hate: T::Boolean,
            hate_threatening: T::Boolean,
            illicit: T.nilable(T::Boolean),
            illicit_violent: T.nilable(T::Boolean),
            self_harm: T::Boolean,
            self_harm_instructions: T::Boolean,
            self_harm_intent: T::Boolean,
            sexual: T::Boolean,
            sexual_minors: T::Boolean,
            violence: T::Boolean,
            violence_graphic: T::Boolean
          )
            .returns(T.attached_class)
        end
        def self.new(
          harassment:,
          harassment_threatening:,
          hate:,
          hate_threatening:,
          illicit:,
          illicit_violent:,
          self_harm:,
          self_harm_instructions:,
          self_harm_intent:,
          sexual:,
          sexual_minors:,
          violence:,
          violence_graphic:
        )
        end

        sig do
          override
            .returns(
              {
                harassment: T::Boolean,
                harassment_threatening: T::Boolean,
                hate: T::Boolean,
                hate_threatening: T::Boolean,
                illicit: T.nilable(T::Boolean),
                illicit_violent: T.nilable(T::Boolean),
                self_harm: T::Boolean,
                self_harm_instructions: T::Boolean,
                self_harm_intent: T::Boolean,
                sexual: T::Boolean,
                sexual_minors: T::Boolean,
                violence: T::Boolean,
                violence_graphic: T::Boolean
              }
            )
        end
        def to_hash
        end
      end

      class CategoryAppliedInputTypes < OpenAI::BaseModel
        # The applied input type(s) for the category 'harassment'.
        sig { returns(T::Array[Symbol]) }
        def harassment
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def harassment=(_)
        end

        # The applied input type(s) for the category 'harassment/threatening'.
        sig { returns(T::Array[Symbol]) }
        def harassment_threatening
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def harassment_threatening=(_)
        end

        # The applied input type(s) for the category 'hate'.
        sig { returns(T::Array[Symbol]) }
        def hate
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def hate=(_)
        end

        # The applied input type(s) for the category 'hate/threatening'.
        sig { returns(T::Array[Symbol]) }
        def hate_threatening
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def hate_threatening=(_)
        end

        # The applied input type(s) for the category 'illicit'.
        sig { returns(T::Array[Symbol]) }
        def illicit
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def illicit=(_)
        end

        # The applied input type(s) for the category 'illicit/violent'.
        sig { returns(T::Array[Symbol]) }
        def illicit_violent
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def illicit_violent=(_)
        end

        # The applied input type(s) for the category 'self-harm'.
        sig { returns(T::Array[Symbol]) }
        def self_harm
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def self_harm=(_)
        end

        # The applied input type(s) for the category 'self-harm/instructions'.
        sig { returns(T::Array[Symbol]) }
        def self_harm_instructions
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def self_harm_instructions=(_)
        end

        # The applied input type(s) for the category 'self-harm/intent'.
        sig { returns(T::Array[Symbol]) }
        def self_harm_intent
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def self_harm_intent=(_)
        end

        # The applied input type(s) for the category 'sexual'.
        sig { returns(T::Array[Symbol]) }
        def sexual
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def sexual=(_)
        end

        # The applied input type(s) for the category 'sexual/minors'.
        sig { returns(T::Array[Symbol]) }
        def sexual_minors
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def sexual_minors=(_)
        end

        # The applied input type(s) for the category 'violence'.
        sig { returns(T::Array[Symbol]) }
        def violence
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def violence=(_)
        end

        # The applied input type(s) for the category 'violence/graphic'.
        sig { returns(T::Array[Symbol]) }
        def violence_graphic
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def violence_graphic=(_)
        end

        # A list of the categories along with the input type(s) that the score applies to.
        sig do
          params(
            harassment: T::Array[Symbol],
            harassment_threatening: T::Array[Symbol],
            hate: T::Array[Symbol],
            hate_threatening: T::Array[Symbol],
            illicit: T::Array[Symbol],
            illicit_violent: T::Array[Symbol],
            self_harm: T::Array[Symbol],
            self_harm_instructions: T::Array[Symbol],
            self_harm_intent: T::Array[Symbol],
            sexual: T::Array[Symbol],
            sexual_minors: T::Array[Symbol],
            violence: T::Array[Symbol],
            violence_graphic: T::Array[Symbol]
          )
            .returns(T.attached_class)
        end
        def self.new(
          harassment:,
          harassment_threatening:,
          hate:,
          hate_threatening:,
          illicit:,
          illicit_violent:,
          self_harm:,
          self_harm_instructions:,
          self_harm_intent:,
          sexual:,
          sexual_minors:,
          violence:,
          violence_graphic:
        )
        end

        sig do
          override
            .returns(
              {
                harassment: T::Array[Symbol],
                harassment_threatening: T::Array[Symbol],
                hate: T::Array[Symbol],
                hate_threatening: T::Array[Symbol],
                illicit: T::Array[Symbol],
                illicit_violent: T::Array[Symbol],
                self_harm: T::Array[Symbol],
                self_harm_instructions: T::Array[Symbol],
                self_harm_intent: T::Array[Symbol],
                sexual: T::Array[Symbol],
                sexual_minors: T::Array[Symbol],
                violence: T::Array[Symbol],
                violence_graphic: T::Array[Symbol]
              }
            )
        end
        def to_hash
        end

        class Harassment < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
        end

        class HarassmentThreatening < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
        end

        class Hate < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
        end

        class HateThreatening < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
        end

        class Illicit < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
        end

        class IllicitViolent < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
        end

        class SelfHarm < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
          IMAGE = :image
        end

        class SelfHarmInstruction < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
          IMAGE = :image
        end

        class SelfHarmIntent < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
          IMAGE = :image
        end

        class Sexual < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
          IMAGE = :image
        end

        class SexualMinor < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
        end

        class Violence < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
          IMAGE = :image
        end

        class ViolenceGraphic < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          TEXT = :text
          IMAGE = :image
        end
      end

      class CategoryScores < OpenAI::BaseModel
        # The score for the category 'harassment'.
        sig { returns(Float) }
        def harassment
        end

        sig { params(_: Float).returns(Float) }
        def harassment=(_)
        end

        # The score for the category 'harassment/threatening'.
        sig { returns(Float) }
        def harassment_threatening
        end

        sig { params(_: Float).returns(Float) }
        def harassment_threatening=(_)
        end

        # The score for the category 'hate'.
        sig { returns(Float) }
        def hate
        end

        sig { params(_: Float).returns(Float) }
        def hate=(_)
        end

        # The score for the category 'hate/threatening'.
        sig { returns(Float) }
        def hate_threatening
        end

        sig { params(_: Float).returns(Float) }
        def hate_threatening=(_)
        end

        # The score for the category 'illicit'.
        sig { returns(Float) }
        def illicit
        end

        sig { params(_: Float).returns(Float) }
        def illicit=(_)
        end

        # The score for the category 'illicit/violent'.
        sig { returns(Float) }
        def illicit_violent
        end

        sig { params(_: Float).returns(Float) }
        def illicit_violent=(_)
        end

        # The score for the category 'self-harm'.
        sig { returns(Float) }
        def self_harm
        end

        sig { params(_: Float).returns(Float) }
        def self_harm=(_)
        end

        # The score for the category 'self-harm/instructions'.
        sig { returns(Float) }
        def self_harm_instructions
        end

        sig { params(_: Float).returns(Float) }
        def self_harm_instructions=(_)
        end

        # The score for the category 'self-harm/intent'.
        sig { returns(Float) }
        def self_harm_intent
        end

        sig { params(_: Float).returns(Float) }
        def self_harm_intent=(_)
        end

        # The score for the category 'sexual'.
        sig { returns(Float) }
        def sexual
        end

        sig { params(_: Float).returns(Float) }
        def sexual=(_)
        end

        # The score for the category 'sexual/minors'.
        sig { returns(Float) }
        def sexual_minors
        end

        sig { params(_: Float).returns(Float) }
        def sexual_minors=(_)
        end

        # The score for the category 'violence'.
        sig { returns(Float) }
        def violence
        end

        sig { params(_: Float).returns(Float) }
        def violence=(_)
        end

        # The score for the category 'violence/graphic'.
        sig { returns(Float) }
        def violence_graphic
        end

        sig { params(_: Float).returns(Float) }
        def violence_graphic=(_)
        end

        # A list of the categories along with their scores as predicted by model.
        sig do
          params(
            harassment: Float,
            harassment_threatening: Float,
            hate: Float,
            hate_threatening: Float,
            illicit: Float,
            illicit_violent: Float,
            self_harm: Float,
            self_harm_instructions: Float,
            self_harm_intent: Float,
            sexual: Float,
            sexual_minors: Float,
            violence: Float,
            violence_graphic: Float
          )
            .returns(T.attached_class)
        end
        def self.new(
          harassment:,
          harassment_threatening:,
          hate:,
          hate_threatening:,
          illicit:,
          illicit_violent:,
          self_harm:,
          self_harm_instructions:,
          self_harm_intent:,
          sexual:,
          sexual_minors:,
          violence:,
          violence_graphic:
        )
        end

        sig do
          override
            .returns(
              {
                harassment: Float,
                harassment_threatening: Float,
                hate: Float,
                hate_threatening: Float,
                illicit: Float,
                illicit_violent: Float,
                self_harm: Float,
                self_harm_instructions: Float,
                self_harm_intent: Float,
                sexual: Float,
                sexual_minors: Float,
                violence: Float,
                violence_graphic: Float
              }
            )
        end
        def to_hash
        end
      end
    end
  end
end
