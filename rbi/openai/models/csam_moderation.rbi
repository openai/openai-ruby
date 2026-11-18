# typed: strong

module OpenAI
  module Models

    class CsamModeration < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::CsamModeration,
          OpenAI::Internal::AnyHash
        )
      end

      # Whether the image was flagged in each category.
      sig { returns(OpenAI::CsamModeration::Categories) }
      attr_reader :categories

      sig { params(categories: OpenAI::CsamModeration::Categories::OrHash).void }
      attr_writer :categories

      # The input types evaluated for each category.
      sig { returns(OpenAI::CsamModeration::CategoryAppliedInputTypes) }
      attr_reader :category_applied_input_types

      sig { params(category_applied_input_types: OpenAI::CsamModeration::CategoryAppliedInputTypes::OrHash).void }
      attr_writer :category_applied_input_types

      # The classifier score for each category.
      sig { returns(OpenAI::CsamModeration::CategoryScores) }
      attr_reader :category_scores

      sig { params(category_scores: OpenAI::CsamModeration::CategoryScores::OrHash).void }
      attr_writer :category_scores

      # Whether either CSAM category was flagged.
      sig { returns(T::Boolean) }
      attr_accessor :flagged

      sig do
        params(

          categories: OpenAI::CsamModeration::Categories::OrHash,

          category_applied_input_types: OpenAI::CsamModeration::CategoryAppliedInputTypes::OrHash,

          category_scores: OpenAI::CsamModeration::CategoryScores::OrHash,

          flagged: T::Boolean
        )
          .returns(T.attached_class)
      end
      def self.new(

        # Whether the image was flagged in each category.
        categories:,

        # The input types evaluated for each category.
        category_applied_input_types:,

        # The classifier score for each category.
        category_scores:,

        # Whether either CSAM category was flagged.

        flagged:
      )
      end

      sig do
        override.returns(
          {
            categories: OpenAI::CsamModeration::Categories,
            category_applied_input_types: OpenAI::CsamModeration::CategoryAppliedInputTypes,
            category_scores: OpenAI::CsamModeration::CategoryScores,
            flagged: T::Boolean
          }
        )
      end
      def to_hash
      end

      class Categories < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::CsamModeration::Categories,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(T::Boolean) }
        attr_accessor :likely_csam

        sig { returns(T::Boolean) }
        attr_accessor :likely_csam_gen_ai

        # Whether the image was flagged in each category.
        sig do
          params(

            likely_csam: T::Boolean,

            likely_csam_gen_ai: T::Boolean
          )
            .returns(T.attached_class)
        end
        def self.new(

          likely_csam:,

          likely_csam_gen_ai:
        )
        end

        sig do
          override.returns(
            {likely_csam: T::Boolean, likely_csam_gen_ai: T::Boolean}
          )
        end
        def to_hash
        end

      end

      class CategoryAppliedInputTypes < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::CsamModeration::CategoryAppliedInputTypes,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(T::Array[OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsam::TaggedSymbol]) }
        attr_accessor :likely_csam

        sig { returns(T::Array[OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi::TaggedSymbol]) }
        attr_accessor :likely_csam_gen_ai

        # The input types evaluated for each category.
        sig do
          params(

            likely_csam: T::Array[OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsam::OrSymbol],

            likely_csam_gen_ai: T::Array[OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi::OrSymbol]
          )
            .returns(T.attached_class)
        end
        def self.new(

          likely_csam:,

          likely_csam_gen_ai:
        )
        end

        sig do
          override.returns(
            {
              likely_csam: T::Array[OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsam::TaggedSymbol],
              likely_csam_gen_ai: T::Array[
                OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi::TaggedSymbol
              ]
            }
          )
        end
        def to_hash
        end

        module LikelyCsam
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsam) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IMAGE = T.let(:image, OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsam::TaggedSymbol)

          sig {
            override.returns(T::Array[OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsam::TaggedSymbol])
          }
          def self.values
          end
        end

        module LikelyCsamGenAi
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias {
            T.all(Symbol, OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi)
          }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IMAGE = T.let(:image, OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi::TaggedSymbol)

          sig {
            override.returns(T::Array[OpenAI::CsamModeration::CategoryAppliedInputTypes::LikelyCsamGenAi::TaggedSymbol])
          }
          def self.values
          end
        end
      end

      class CategoryScores < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::CsamModeration::CategoryScores,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(Float) }
        attr_accessor :likely_csam

        sig { returns(Float) }
        attr_accessor :likely_csam_gen_ai

        # The classifier score for each category.
        sig do
          params(

            likely_csam: Float,

            likely_csam_gen_ai: Float
          )
            .returns(T.attached_class)
        end
        def self.new(

          likely_csam:,

          likely_csam_gen_ai:
        )
        end

        sig do
          override.returns(
            {likely_csam: Float, likely_csam_gen_ai: Float}
          )
        end
        def to_hash
        end

      end

    end

  end
end
