# typed: strong

module OpenAI
  module Models
    module Responses
      class FileSearchTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::FileSearchTool, OpenAI::Internal::AnyHash)
          end

        # The type of the file search tool. Always `file_search`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The IDs of the vector stores to search.
        sig { returns(T::Array[String]) }
        attr_accessor :vector_store_ids

        # A filter to apply.
        sig do
          returns(
            T.nilable(T.any(OpenAI::ComparisonFilter, OpenAI::CompoundFilter))
          )
        end
        attr_accessor :filters

        # The maximum number of results to return. This number should be between 1 and 50
        # inclusive.
        sig { returns(T.nilable(Integer)) }
        attr_reader :max_num_results

        sig { params(max_num_results: Integer).void }
        attr_writer :max_num_results

        # Ranking options for search.
        sig do
          returns(T.nilable(OpenAI::Responses::FileSearchTool::RankingOptions))
        end
        attr_reader :ranking_options

        sig do
          params(
            ranking_options:
              OpenAI::Responses::FileSearchTool::RankingOptions::OrHash
          ).void
        end
        attr_writer :ranking_options

        # A tool that searches for relevant content from uploaded files. Learn more about
        # the
        # [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        sig do
          params(
            vector_store_ids: T::Array[String],
            filters:
              T.nilable(
                T.any(
                  OpenAI::ComparisonFilter::OrHash,
                  OpenAI::CompoundFilter::OrHash
                )
              ),
            max_num_results: Integer,
            ranking_options:
              OpenAI::Responses::FileSearchTool::RankingOptions::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The IDs of the vector stores to search.
          vector_store_ids:,
          # A filter to apply.
          filters: nil,
          # The maximum number of results to return. This number should be between 1 and 50
          # inclusive.
          max_num_results: nil,
          # Ranking options for search.
          ranking_options: nil,
          # The type of the file search tool. Always `file_search`.
          type: :file_search
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              vector_store_ids: T::Array[String],
              filters:
                T.nilable(
                  T.any(OpenAI::ComparisonFilter, OpenAI::CompoundFilter)
                ),
              max_num_results: Integer,
              ranking_options: OpenAI::Responses::FileSearchTool::RankingOptions
            }
          )
        end
        def to_hash
        end

        # A filter to apply.
        module Filters
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(OpenAI::ComparisonFilter, OpenAI::CompoundFilter)
            end

          sig do
            override.returns(
              T::Array[OpenAI::Responses::FileSearchTool::Filters::Variants]
            )
          end
          def self.variants
          end
        end

        class RankingOptions < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::FileSearchTool::RankingOptions,
                OpenAI::Internal::AnyHash
              )
            end

          # The ranker to use for the file search.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol
              )
            )
          end
          attr_reader :ranker

          sig do
            params(
              ranker:
                OpenAI::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol
            ).void
          end
          attr_writer :ranker

          # The score threshold for the file search, a number between 0 and 1. Numbers
          # closer to 1 will attempt to return only the most relevant results, but may
          # return fewer results.
          sig { returns(T.nilable(Float)) }
          attr_reader :score_threshold

          sig { params(score_threshold: Float).void }
          attr_writer :score_threshold

          # Ranking options for search.
          sig do
            params(
              ranker:
                OpenAI::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol,
              score_threshold: Float
            ).returns(T.attached_class)
          end
          def self.new(
            # The ranker to use for the file search.
            ranker: nil,
            # The score threshold for the file search, a number between 0 and 1. Numbers
            # closer to 1 will attempt to return only the most relevant results, but may
            # return fewer results.
            score_threshold: nil
          )
          end

          sig do
            override.returns(
              {
                ranker:
                  OpenAI::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol,
                score_threshold: Float
              }
            )
          end
          def to_hash
          end

          # The ranker to use for the file search.
          module Ranker
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::FileSearchTool::RankingOptions::Ranker
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Responses::FileSearchTool::RankingOptions::Ranker::TaggedSymbol
              )
            DEFAULT_2024_11_15 =
              T.let(
                :"default-2024-11-15",
                OpenAI::Responses::FileSearchTool::RankingOptions::Ranker::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::FileSearchTool::RankingOptions::Ranker::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
