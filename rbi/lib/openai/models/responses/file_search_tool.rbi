# typed: strong

module OpenAI
  module Models
    module Responses
      class FileSearchTool < OpenAI::Internal::Type::BaseModel
        # The type of the file search tool. Always `file_search`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The IDs of the vector stores to search.
        sig { returns(T::Array[String]) }
        attr_accessor :vector_store_ids

        # A filter to apply based on file attributes.
        sig { returns(T.nilable(T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter))) }
        attr_reader :filters

        sig do
          params(
            filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Internal::AnyHash, OpenAI::Models::CompoundFilter)
          )
            .void
        end
        attr_writer :filters

        # The maximum number of results to return. This number should be between 1 and 50
        #   inclusive.
        sig { returns(T.nilable(Integer)) }
        attr_reader :max_num_results

        sig { params(max_num_results: Integer).void }
        attr_writer :max_num_results

        # Ranking options for search.
        sig { returns(T.nilable(OpenAI::Models::Responses::FileSearchTool::RankingOptions)) }
        attr_reader :ranking_options

        sig do
          params(
            ranking_options: T.any(OpenAI::Models::Responses::FileSearchTool::RankingOptions, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :ranking_options

        # A tool that searches for relevant content from uploaded files. Learn more about
        #   the
        #   [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        sig do
          params(
            vector_store_ids: T::Array[String],
            filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Internal::AnyHash, OpenAI::Models::CompoundFilter),
            max_num_results: Integer,
            ranking_options: T.any(OpenAI::Models::Responses::FileSearchTool::RankingOptions, OpenAI::Internal::AnyHash),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          vector_store_ids:,
          filters: nil,
          max_num_results: nil,
          ranking_options: nil,
          type: :file_search
        )
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
        def to_hash; end

        # A filter to apply based on file attributes.
        module Filters
          extend OpenAI::Internal::Type::Union

          sig { override.returns([OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter]) }
          def self.variants; end
        end

        class RankingOptions < OpenAI::Internal::Type::BaseModel
          # The ranker to use for the file search.
          sig { returns(T.nilable(OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol)) }
          attr_reader :ranker

          sig { params(ranker: OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol).void }
          attr_writer :ranker

          # The score threshold for the file search, a number between 0 and 1. Numbers
          #   closer to 1 will attempt to return only the most relevant results, but may
          #   return fewer results.
          sig { returns(T.nilable(Float)) }
          attr_reader :score_threshold

          sig { params(score_threshold: Float).void }
          attr_writer :score_threshold

          # Ranking options for search.
          sig do
            params(
              ranker: OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol,
              score_threshold: Float
            )
              .returns(T.attached_class)
          end
          def self.new(ranker: nil, score_threshold: nil); end

          sig do
            override
              .returns(
                {ranker: OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::OrSymbol, score_threshold: Float}
              )
          end
          def to_hash; end

          # The ranker to use for the file search.
          module Ranker
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::TaggedSymbol) }

            AUTO = T.let(:auto, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::TaggedSymbol)
            DEFAULT_2024_11_15 =
              T.let(
                :"default-2024-11-15",
                OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::TaggedSymbol
              )

            sig do
              override.returns(T::Array[OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker::TaggedSymbol])
            end
            def self.values; end
          end
        end
      end
    end
  end
end
