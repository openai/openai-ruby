# typed: strong

module OpenAI
  module Models
    class VectorStoreSearchParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # A query string for a search
      sig { returns(T.any(String, T::Array[String])) }
      attr_accessor :query

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
      # inclusive.
      sig { returns(T.nilable(Integer)) }
      attr_reader :max_num_results

      sig { params(max_num_results: Integer).void }
      attr_writer :max_num_results

      # Ranking options for search.
      sig { returns(T.nilable(OpenAI::Models::VectorStoreSearchParams::RankingOptions)) }
      attr_reader :ranking_options

      sig do
        params(
          ranking_options: T.any(OpenAI::Models::VectorStoreSearchParams::RankingOptions, OpenAI::Internal::AnyHash)
        )
          .void
      end
      attr_writer :ranking_options

      # Whether to rewrite the natural language query for vector search.
      sig { returns(T.nilable(T::Boolean)) }
      attr_reader :rewrite_query

      sig { params(rewrite_query: T::Boolean).void }
      attr_writer :rewrite_query

      sig do
        params(
          query: T.any(String, T::Array[String]),
          filters: T.any(OpenAI::Models::ComparisonFilter, OpenAI::Internal::AnyHash, OpenAI::Models::CompoundFilter),
          max_num_results: Integer,
          ranking_options: T.any(OpenAI::Models::VectorStoreSearchParams::RankingOptions, OpenAI::Internal::AnyHash),
          rewrite_query: T::Boolean,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        query:,
        filters: nil,
        max_num_results: nil,
        ranking_options: nil,
        rewrite_query: nil,
        request_options: {}
      )
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
      def to_hash; end

      # A query string for a search
      module Query
        extend OpenAI::Internal::Type::Union

        sig { override.returns([String, T::Array[String]]) }
        def self.variants; end

        StringArray = T.let(OpenAI::Internal::Type::ArrayOf[String], OpenAI::Internal::Type::Converter)
      end

      # A filter to apply based on file attributes.
      module Filters
        extend OpenAI::Internal::Type::Union

        sig { override.returns([OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter]) }
        def self.variants; end
      end

      class RankingOptions < OpenAI::Internal::Type::BaseModel
        sig { returns(T.nilable(OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol)) }
        attr_reader :ranker

        sig { params(ranker: OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol).void }
        attr_writer :ranker

        sig { returns(T.nilable(Float)) }
        attr_reader :score_threshold

        sig { params(score_threshold: Float).void }
        attr_writer :score_threshold

        # Ranking options for search.
        sig do
          params(
            ranker: OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol,
            score_threshold: Float
          )
            .returns(T.attached_class)
        end
        def self.new(ranker: nil, score_threshold: nil); end

        sig do
          override
            .returns(
              {ranker: OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol, score_threshold: Float}
            )
        end
        def to_hash; end

        module Ranker
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol) }

          AUTO = T.let(:auto, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol)
          DEFAULT_2024_11_15 =
            T.let(
              :"default-2024-11-15",
              OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol
            )

          sig { override.returns(T::Array[OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
