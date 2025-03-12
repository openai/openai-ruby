# typed: strong

module OpenAI
  module Models
    module Responses
      class FileSearchTool < OpenAI::BaseModel
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(T::Array[String]) }
        def vector_store_ids
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def vector_store_ids=(_)
        end

        sig { returns(T.nilable(T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter))) }
        def filters
        end

        sig do
          params(_: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter))
            .returns(T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter))
        end
        def filters=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def max_num_results
        end

        sig { params(_: Integer).returns(Integer) }
        def max_num_results=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Responses::FileSearchTool::RankingOptions)) }
        def ranking_options
        end

        sig do
          params(_: OpenAI::Models::Responses::FileSearchTool::RankingOptions)
            .returns(OpenAI::Models::Responses::FileSearchTool::RankingOptions)
        end
        def ranking_options=(_)
        end

        sig do
          params(
            vector_store_ids: T::Array[String],
            filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter),
            max_num_results: Integer,
            ranking_options: OpenAI::Models::Responses::FileSearchTool::RankingOptions,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(vector_store_ids:, filters: nil, max_num_results: nil, ranking_options: nil, type: :file_search)
        end

        sig do
          override
            .returns(
              {
                type: Symbol,
                vector_store_ids: T::Array[String],
                filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter),
                max_num_results: Integer,
                ranking_options: OpenAI::Models::Responses::FileSearchTool::RankingOptions
              }
            )
        end
        def to_hash
        end

        class Filters < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns([[NilClass, OpenAI::Models::ComparisonFilter], [NilClass, OpenAI::Models::CompoundFilter]])
            end
            private def variants
            end
          end
        end

        class RankingOptions < OpenAI::BaseModel
          sig { returns(T.nilable(Symbol)) }
          def ranker
          end

          sig { params(_: Symbol).returns(Symbol) }
          def ranker=(_)
          end

          sig { returns(T.nilable(Float)) }
          def score_threshold
          end

          sig { params(_: Float).returns(Float) }
          def score_threshold=(_)
          end

          sig { params(ranker: Symbol, score_threshold: Float).returns(T.attached_class) }
          def self.new(ranker: nil, score_threshold: nil)
          end

          sig { override.returns({ranker: Symbol, score_threshold: Float}) }
          def to_hash
          end

          class Ranker < OpenAI::Enum
            abstract!

            AUTO = :auto
            DEFAULT_2024_11_15 = :"default-2024-11-15"

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
