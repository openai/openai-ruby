# typed: strong

module OpenAI
  module Models
    class Moderation < OpenAI::Internal::Type::BaseModel
      # A list of the categories, and whether they are flagged or not.
      sig { returns(OpenAI::Models::Moderation::Categories) }
      attr_reader :categories

      sig { params(categories: T.any(OpenAI::Models::Moderation::Categories, OpenAI::Internal::AnyHash)).void }
      attr_writer :categories

      # A list of the categories along with the input type(s) that the score applies to.
      sig { returns(OpenAI::Models::Moderation::CategoryAppliedInputTypes) }
      attr_reader :category_applied_input_types

      sig do
        params(
          category_applied_input_types: T.any(OpenAI::Models::Moderation::CategoryAppliedInputTypes, OpenAI::Internal::AnyHash)
        )
          .void
      end
      attr_writer :category_applied_input_types

      # A list of the categories along with their scores as predicted by model.
      sig { returns(OpenAI::Models::Moderation::CategoryScores) }
      attr_reader :category_scores

      sig { params(category_scores: T.any(OpenAI::Models::Moderation::CategoryScores, OpenAI::Internal::AnyHash)).void }
      attr_writer :category_scores

      # Whether any of the below categories are flagged.
      sig { returns(T::Boolean) }
      attr_accessor :flagged

      sig do
        params(
          categories: T.any(OpenAI::Models::Moderation::Categories, OpenAI::Internal::AnyHash),
          category_applied_input_types: T.any(OpenAI::Models::Moderation::CategoryAppliedInputTypes, OpenAI::Internal::AnyHash),
          category_scores: T.any(OpenAI::Models::Moderation::CategoryScores, OpenAI::Internal::AnyHash),
          flagged: T::Boolean
        )
          .returns(T.attached_class)
      end
      def self.new(categories:, category_applied_input_types:, category_scores:, flagged:); end

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
      def to_hash; end

      class Categories < OpenAI::Internal::Type::BaseModel
        # Content that expresses, incites, or promotes harassing language towards any
        # target.
        sig { returns(T::Boolean) }
        attr_accessor :harassment

        # Harassment content that also includes violence or serious harm towards any
        # target.
        sig { returns(T::Boolean) }
        attr_accessor :harassment_threatening

        # Content that expresses, incites, or promotes hate based on race, gender,
        # ethnicity, religion, nationality, sexual orientation, disability status, or
        # caste. Hateful content aimed at non-protected groups (e.g., chess players) is
        # harassment.
        sig { returns(T::Boolean) }
        attr_accessor :hate

        # Hateful content that also includes violence or serious harm towards the targeted
        # group based on race, gender, ethnicity, religion, nationality, sexual
        # orientation, disability status, or caste.
        sig { returns(T::Boolean) }
        attr_accessor :hate_threatening

        # Content that includes instructions or advice that facilitate the planning or
        # execution of wrongdoing, or that gives advice or instruction on how to commit
        # illicit acts. For example, "how to shoplift" would fit this category.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :illicit

        # Content that includes instructions or advice that facilitate the planning or
        # execution of wrongdoing that also includes violence, or that gives advice or
        # instruction on the procurement of any weapon.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :illicit_violent

        # Content that promotes, encourages, or depicts acts of self-harm, such as
        # suicide, cutting, and eating disorders.
        sig { returns(T::Boolean) }
        attr_accessor :self_harm

        # Content that encourages performing acts of self-harm, such as suicide, cutting,
        # and eating disorders, or that gives instructions or advice on how to commit such
        # acts.
        sig { returns(T::Boolean) }
        attr_accessor :self_harm_instructions

        # Content where the speaker expresses that they are engaging or intend to engage
        # in acts of self-harm, such as suicide, cutting, and eating disorders.
        sig { returns(T::Boolean) }
        attr_accessor :self_harm_intent

        # Content meant to arouse sexual excitement, such as the description of sexual
        # activity, or that promotes sexual services (excluding sex education and
        # wellness).
        sig { returns(T::Boolean) }
        attr_accessor :sexual

        # Sexual content that includes an individual who is under 18 years old.
        sig { returns(T::Boolean) }
        attr_accessor :sexual_minors

        # Content that depicts death, violence, or physical injury.
        sig { returns(T::Boolean) }
        attr_accessor :violence

        # Content that depicts death, violence, or physical injury in graphic detail.
        sig { returns(T::Boolean) }
        attr_accessor :violence_graphic

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
        ); end
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
        def to_hash; end
      end

      class CategoryAppliedInputTypes < OpenAI::Internal::Type::BaseModel
        # The applied input type(s) for the category 'harassment'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol]) }
        attr_accessor :harassment

        # The applied input type(s) for the category 'harassment/threatening'.
        sig do
          returns(
            T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol]
          )
        end
        attr_accessor :harassment_threatening

        # The applied input type(s) for the category 'hate'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol]) }
        attr_accessor :hate

        # The applied input type(s) for the category 'hate/threatening'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol]) }
        attr_accessor :hate_threatening

        # The applied input type(s) for the category 'illicit'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol]) }
        attr_accessor :illicit

        # The applied input type(s) for the category 'illicit/violent'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol]) }
        attr_accessor :illicit_violent

        # The applied input type(s) for the category 'self-harm'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol]) }
        attr_accessor :self_harm

        # The applied input type(s) for the category 'self-harm/instructions'.
        sig do
          returns(
            T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol]
          )
        end
        attr_accessor :self_harm_instructions

        # The applied input type(s) for the category 'self-harm/intent'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol]) }
        attr_accessor :self_harm_intent

        # The applied input type(s) for the category 'sexual'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol]) }
        attr_accessor :sexual

        # The applied input type(s) for the category 'sexual/minors'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol]) }
        attr_accessor :sexual_minors

        # The applied input type(s) for the category 'violence'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol]) }
        attr_accessor :violence

        # The applied input type(s) for the category 'violence/graphic'.
        sig { returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol]) }
        attr_accessor :violence_graphic

        # A list of the categories along with the input type(s) that the score applies to.
        sig do
          params(
            harassment: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment::OrSymbol],
            harassment_threatening: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::OrSymbol],
            hate: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate::OrSymbol],
            hate_threatening: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening::OrSymbol],
            illicit: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit::OrSymbol],
            illicit_violent: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent::OrSymbol],
            self_harm: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm::OrSymbol],
            self_harm_instructions: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::OrSymbol],
            self_harm_intent: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::OrSymbol],
            sexual: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual::OrSymbol],
            sexual_minors: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor::OrSymbol],
            violence: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence::OrSymbol],
            violence_graphic: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::OrSymbol]
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
        ); end
        sig do
          override
            .returns(
              {
                harassment: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol],
                harassment_threatening: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol],
                hate: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol],
                hate_threatening: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol],
                illicit: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol],
                illicit_violent: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol],
                self_harm: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol],
                self_harm_instructions: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol],
                self_harm_intent: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol],
                sexual: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol],
                sexual_minors: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol],
                violence: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol],
                violence_graphic: T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol]
              }
            )
        end
        def to_hash; end

        module Harassment
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol)

          sig do
            override.returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol])
          end
          def self.values; end
        end

        module HarassmentThreatening
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol)

          sig do
            override
              .returns(
                T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol]
              )
          end
          def self.values; end
        end

        module Hate
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol]) }
          def self.values; end
        end

        module HateThreatening
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol])
          end
          def self.values; end
        end

        module Illicit
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol]) }
          def self.values; end
        end

        module IllicitViolent
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol])
          end
          def self.values; end
        end

        module SelfHarm
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol)
          IMAGE = T.let(:image, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol]) }
          def self.values; end
        end

        module SelfHarmInstruction
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol)
          IMAGE =
            T.let(:image, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol)

          sig do
            override
              .returns(
                T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol]
              )
          end
          def self.values; end
        end

        module SelfHarmIntent
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol)
          IMAGE =
            T.let(:image, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol])
          end
          def self.values; end
        end

        module Sexual
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol)
          IMAGE = T.let(:image, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol]) }
          def self.values; end
        end

        module SexualMinor
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol])
          end
          def self.values; end
        end

        module Violence
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol)
          IMAGE = T.let(:image, OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol]) }
          def self.values; end
        end

        module ViolenceGraphic
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT = T.let(:text, OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol)
          IMAGE =
            T.let(:image, OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol])
          end
          def self.values; end
        end
      end

      class CategoryScores < OpenAI::Internal::Type::BaseModel
        # The score for the category 'harassment'.
        sig { returns(Float) }
        attr_accessor :harassment

        # The score for the category 'harassment/threatening'.
        sig { returns(Float) }
        attr_accessor :harassment_threatening

        # The score for the category 'hate'.
        sig { returns(Float) }
        attr_accessor :hate

        # The score for the category 'hate/threatening'.
        sig { returns(Float) }
        attr_accessor :hate_threatening

        # The score for the category 'illicit'.
        sig { returns(Float) }
        attr_accessor :illicit

        # The score for the category 'illicit/violent'.
        sig { returns(Float) }
        attr_accessor :illicit_violent

        # The score for the category 'self-harm'.
        sig { returns(Float) }
        attr_accessor :self_harm

        # The score for the category 'self-harm/instructions'.
        sig { returns(Float) }
        attr_accessor :self_harm_instructions

        # The score for the category 'self-harm/intent'.
        sig { returns(Float) }
        attr_accessor :self_harm_intent

        # The score for the category 'sexual'.
        sig { returns(Float) }
        attr_accessor :sexual

        # The score for the category 'sexual/minors'.
        sig { returns(Float) }
        attr_accessor :sexual_minors

        # The score for the category 'violence'.
        sig { returns(Float) }
        attr_accessor :violence

        # The score for the category 'violence/graphic'.
        sig { returns(Float) }
        attr_accessor :violence_graphic

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
        ); end
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
        def to_hash; end
      end
    end
  end
end
