# typed: strong

module OpenAI
  module Models
    module Responses
      class FileSearchTool < OpenAI::BaseModel
        # The type of the file search tool. Always `file_search`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The IDs of the vector stores to search.
        sig { returns(T::Array[String]) }
        def vector_store_ids
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def vector_store_ids=(_)
        end

        # A filter to apply based on file attributes.
        sig { returns(T.nilable(T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter))) }
        def filters
        end

        sig do
          params(_: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter))
            .returns(T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter))
        end
        def filters=(_)
        end

        # The maximum number of results to return. This number should be between 1 and 50
        #   inclusive.
        sig { returns(T.nilable(Integer)) }
        def max_num_results
        end

        sig { params(_: Integer).returns(Integer) }
        def max_num_results=(_)
        end

        # Ranking options for search.
        sig { returns(T.nilable(OpenAI::Models::Responses::FileSearchTool::RankingOptions)) }
        def ranking_options
        end

        sig do
          params(_: OpenAI::Models::Responses::FileSearchTool::RankingOptions)
            .returns(OpenAI::Models::Responses::FileSearchTool::RankingOptions)
        end
        def ranking_options=(_)
        end

        # A tool that searches for relevant content from uploaded files. Learn more about
        #   the
        #   [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
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

        # A filter to apply based on file attributes.
        class Filters < OpenAI::Union
          abstract!

          Variants = type_template(:out) { {fixed: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter)} }
        end

        class RankingOptions < OpenAI::BaseModel
          # The ranker to use for the file search.
          sig { returns(T.nilable(Symbol)) }
          def ranker
          end

          sig { params(_: Symbol).returns(Symbol) }
          def ranker=(_)
          end

          # The score threshold for the file search, a number between 0 and 1. Numbers
          #   closer to 1 will attempt to return only the most relevant results, but may
          #   return fewer results.
          sig { returns(T.nilable(Float)) }
          def score_threshold
          end

          sig { params(_: Float).returns(Float) }
          def score_threshold=(_)
          end

          # Ranking options for search.
          sig { params(ranker: Symbol, score_threshold: Float).returns(T.attached_class) }
          def self.new(ranker: nil, score_threshold: nil)
          end

          sig { override.returns({ranker: Symbol, score_threshold: Float}) }
          def to_hash
          end

          # The ranker to use for the file search.
          class Ranker < OpenAI::Enum
            abstract!

            Value = type_template(:out) { {fixed: Symbol} }

            AUTO = :auto
            DEFAULT_2024_11_15 = :"default-2024-11-15"
          end
        end
      end
    end
  end
end
