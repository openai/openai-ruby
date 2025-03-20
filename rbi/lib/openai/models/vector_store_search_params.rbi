# typed: strong

module OpenAI
  module Models
    class VectorStoreSearchParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # A query string for a search
      sig { returns(T.any(String, T::Array[String])) }
      def query
      end

      sig { params(_: T.any(String, T::Array[String])).returns(T.any(String, T::Array[String])) }
      def query=(_)
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
      sig { returns(T.nilable(OpenAI::Models::VectorStoreSearchParams::RankingOptions)) }
      def ranking_options
      end

      sig do
        params(_: OpenAI::Models::VectorStoreSearchParams::RankingOptions)
          .returns(OpenAI::Models::VectorStoreSearchParams::RankingOptions)
      end
      def ranking_options=(_)
      end

      # Whether to rewrite the natural language query for vector search.
      sig { returns(T.nilable(T::Boolean)) }
      def rewrite_query
      end

      sig { params(_: T::Boolean).returns(T::Boolean) }
      def rewrite_query=(_)
      end

      sig do
        params(
          query: T.any(String, T::Array[String]),
          filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter),
          max_num_results: Integer,
          ranking_options: OpenAI::Models::VectorStoreSearchParams::RankingOptions,
          rewrite_query: T::Boolean,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(query:, filters: nil, max_num_results: nil, ranking_options: nil, rewrite_query: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              query: T.any(String, T::Array[String]),
              filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter),
              max_num_results: Integer,
              ranking_options: OpenAI::Models::VectorStoreSearchParams::RankingOptions,
              rewrite_query: T::Boolean,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # A query string for a search
      module Query
        extend OpenAI::Union

        Variants = type_template(:out) { {fixed: T.any(String, T::Array[String])} }

        StringArray = T.let(OpenAI::ArrayOf[String], OpenAI::Converter)
      end

      # A filter to apply based on file attributes.
      module Filters
        extend OpenAI::Union

        Variants =
          type_template(:out) { {fixed: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter)} }
      end

      class RankingOptions < OpenAI::BaseModel
        sig { returns(T.nilable(OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol)) }
        def ranker
        end

        sig do
          params(_: OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol)
            .returns(OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol)
        end
        def ranker=(_)
        end

        sig { returns(T.nilable(Float)) }
        def score_threshold
        end

        sig { params(_: Float).returns(Float) }
        def score_threshold=(_)
        end

        # Ranking options for search.
        sig do
          params(
            ranker: OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol,
            score_threshold: Float
          )
            .returns(T.attached_class)
        end
        def self.new(ranker: nil, score_threshold: nil)
        end

        sig do
          override
            .returns(
              {ranker: OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol, score_threshold: Float}
            )
        end
        def to_hash
        end

        module Ranker
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol) }

          AUTO = T.let(:auto, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol)
          DEFAULT_2024_11_15 =
            T.let(:"default-2024-11-15", OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol)
        end
      end
    end
  end
end
