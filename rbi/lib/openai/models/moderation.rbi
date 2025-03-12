# typed: strong

module OpenAI
  module Models
    class Moderation < OpenAI::BaseModel
      sig { returns(OpenAI::Models::Moderation::Categories) }
      def categories
      end

      sig { params(_: OpenAI::Models::Moderation::Categories).returns(OpenAI::Models::Moderation::Categories) }
      def categories=(_)
      end

      sig { returns(OpenAI::Models::Moderation::CategoryAppliedInputTypes) }
      def category_applied_input_types
      end

      sig do
        params(_: OpenAI::Models::Moderation::CategoryAppliedInputTypes)
          .returns(OpenAI::Models::Moderation::CategoryAppliedInputTypes)
      end
      def category_applied_input_types=(_)
      end

      sig { returns(OpenAI::Models::Moderation::CategoryScores) }
      def category_scores
      end

      sig { params(_: OpenAI::Models::Moderation::CategoryScores).returns(OpenAI::Models::Moderation::CategoryScores) }
      def category_scores=(_)
      end

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
        sig { returns(T::Boolean) }
        def harassment
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def harassment=(_)
        end

        sig { returns(T::Boolean) }
        def harassment_threatening
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def harassment_threatening=(_)
        end

        sig { returns(T::Boolean) }
        def hate
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def hate=(_)
        end

        sig { returns(T::Boolean) }
        def hate_threatening
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def hate_threatening=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def illicit
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def illicit=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def illicit_violent
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def illicit_violent=(_)
        end

        sig { returns(T::Boolean) }
        def self_harm
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def self_harm=(_)
        end

        sig { returns(T::Boolean) }
        def self_harm_instructions
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def self_harm_instructions=(_)
        end

        sig { returns(T::Boolean) }
        def self_harm_intent
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def self_harm_intent=(_)
        end

        sig { returns(T::Boolean) }
        def sexual
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def sexual=(_)
        end

        sig { returns(T::Boolean) }
        def sexual_minors
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def sexual_minors=(_)
        end

        sig { returns(T::Boolean) }
        def violence
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def violence=(_)
        end

        sig { returns(T::Boolean) }
        def violence_graphic
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def violence_graphic=(_)
        end

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
        sig { returns(T::Array[Symbol]) }
        def harassment
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def harassment=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def harassment_threatening
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def harassment_threatening=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def hate
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def hate=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def hate_threatening
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def hate_threatening=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def illicit
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def illicit=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def illicit_violent
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def illicit_violent=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def self_harm
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def self_harm=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def self_harm_instructions
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def self_harm_instructions=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def self_harm_intent
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def self_harm_intent=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def sexual
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def sexual=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def sexual_minors
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def sexual_minors=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def violence
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def violence=(_)
        end

        sig { returns(T::Array[Symbol]) }
        def violence_graphic
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def violence_graphic=(_)
        end

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

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class HarassmentThreatening < OpenAI::Enum
          abstract!

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Hate < OpenAI::Enum
          abstract!

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class HateThreatening < OpenAI::Enum
          abstract!

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Illicit < OpenAI::Enum
          abstract!

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class IllicitViolent < OpenAI::Enum
          abstract!

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class SelfHarm < OpenAI::Enum
          abstract!

          TEXT = :text
          IMAGE = :image

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class SelfHarmInstruction < OpenAI::Enum
          abstract!

          TEXT = :text
          IMAGE = :image

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class SelfHarmIntent < OpenAI::Enum
          abstract!

          TEXT = :text
          IMAGE = :image

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Sexual < OpenAI::Enum
          abstract!

          TEXT = :text
          IMAGE = :image

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class SexualMinor < OpenAI::Enum
          abstract!

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Violence < OpenAI::Enum
          abstract!

          TEXT = :text
          IMAGE = :image

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class ViolenceGraphic < OpenAI::Enum
          abstract!

          TEXT = :text
          IMAGE = :image

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end

      class CategoryScores < OpenAI::BaseModel
        sig { returns(Float) }
        def harassment
        end

        sig { params(_: Float).returns(Float) }
        def harassment=(_)
        end

        sig { returns(Float) }
        def harassment_threatening
        end

        sig { params(_: Float).returns(Float) }
        def harassment_threatening=(_)
        end

        sig { returns(Float) }
        def hate
        end

        sig { params(_: Float).returns(Float) }
        def hate=(_)
        end

        sig { returns(Float) }
        def hate_threatening
        end

        sig { params(_: Float).returns(Float) }
        def hate_threatening=(_)
        end

        sig { returns(Float) }
        def illicit
        end

        sig { params(_: Float).returns(Float) }
        def illicit=(_)
        end

        sig { returns(Float) }
        def illicit_violent
        end

        sig { params(_: Float).returns(Float) }
        def illicit_violent=(_)
        end

        sig { returns(Float) }
        def self_harm
        end

        sig { params(_: Float).returns(Float) }
        def self_harm=(_)
        end

        sig { returns(Float) }
        def self_harm_instructions
        end

        sig { params(_: Float).returns(Float) }
        def self_harm_instructions=(_)
        end

        sig { returns(Float) }
        def self_harm_intent
        end

        sig { params(_: Float).returns(Float) }
        def self_harm_intent=(_)
        end

        sig { returns(Float) }
        def sexual
        end

        sig { params(_: Float).returns(Float) }
        def sexual=(_)
        end

        sig { returns(Float) }
        def sexual_minors
        end

        sig { params(_: Float).returns(Float) }
        def sexual_minors=(_)
        end

        sig { returns(Float) }
        def violence
        end

        sig { params(_: Float).returns(Float) }
        def violence=(_)
        end

        sig { returns(Float) }
        def violence_graphic
        end

        sig { params(_: Float).returns(Float) }
        def violence_graphic=(_)
        end

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
