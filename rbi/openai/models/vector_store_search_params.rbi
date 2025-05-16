# typed: strong

module OpenAI
  module Models
    class VectorStoreSearchParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VectorStoreSearchParams, OpenAI::Internal::AnyHash)
        end

      # A query string for a search
      sig { returns(T.any(String, T::Array[String])) }
      attr_accessor :query

      # A filter to apply based on file attributes.
      sig do
        returns(
          T.nilable(T.any(OpenAI::ComparisonFilter, OpenAI::CompoundFilter))
        )
      end
      attr_reader :filters

      sig do
        params(
          filters:
            T.any(
              OpenAI::ComparisonFilter::OrHash,
              OpenAI::CompoundFilter::OrHash
            )
        ).void
      end
      attr_writer :filters

      # The maximum number of results to return. This number should be between 1 and 50
      # inclusive.
      sig { returns(T.nilable(Integer)) }
      attr_reader :max_num_results

      sig { params(max_num_results: Integer).void }
      attr_writer :max_num_results

      # Ranking options for search.
      sig do
        returns(T.nilable(OpenAI::VectorStoreSearchParams::RankingOptions))
      end
      attr_reader :ranking_options

      sig do
        params(
          ranking_options:
            OpenAI::VectorStoreSearchParams::RankingOptions::OrHash
        ).void
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
          filters:
            T.any(
              OpenAI::ComparisonFilter::OrHash,
              OpenAI::CompoundFilter::OrHash
            ),
          max_num_results: Integer,
          ranking_options:
            OpenAI::VectorStoreSearchParams::RankingOptions::OrHash,
          rewrite_query: T::Boolean,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # A query string for a search
        query:,
        # A filter to apply based on file attributes.
        filters: nil,
        # The maximum number of results to return. This number should be between 1 and 50
        # inclusive.
        max_num_results: nil,
        # Ranking options for search.
        ranking_options: nil,
        # Whether to rewrite the natural language query for vector search.
        rewrite_query: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            query: T.any(String, T::Array[String]),
            filters: T.any(OpenAI::ComparisonFilter, OpenAI::CompoundFilter),
            max_num_results: Integer,
            ranking_options: OpenAI::VectorStoreSearchParams::RankingOptions,
            rewrite_query: T::Boolean,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # A query string for a search
      module Query
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, T::Array[String]) }

        sig do
          override.returns(
            T::Array[OpenAI::VectorStoreSearchParams::Query::Variants]
          )
        end
        def self.variants
        end

        StringArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[String],
            OpenAI::Internal::Type::Converter
          )
      end

      # A filter to apply based on file attributes.
      module Filters
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(OpenAI::ComparisonFilter, OpenAI::CompoundFilter)
          end

        sig do
          override.returns(
            T::Array[OpenAI::VectorStoreSearchParams::Filters::Variants]
          )
        end
        def self.variants
        end
      end

      class RankingOptions < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::VectorStoreSearchParams::RankingOptions,
              OpenAI::Internal::AnyHash
            )
          end

        sig do
          returns(
            T.nilable(
              OpenAI::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol
            )
          )
        end
        attr_reader :ranker

        sig do
          params(
            ranker:
              OpenAI::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol
          ).void
        end
        attr_writer :ranker

        sig { returns(T.nilable(Float)) }
        attr_reader :score_threshold

        sig { params(score_threshold: Float).void }
        attr_writer :score_threshold

        # Ranking options for search.
        sig do
          params(
            ranker:
              OpenAI::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol,
            score_threshold: Float
          ).returns(T.attached_class)
        end
        def self.new(ranker: nil, score_threshold: nil)
        end

        sig do
          override.returns(
            {
              ranker:
                OpenAI::VectorStoreSearchParams::RankingOptions::Ranker::OrSymbol,
              score_threshold: Float
            }
          )
        end
        def to_hash
        end

        module Ranker
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::VectorStoreSearchParams::RankingOptions::Ranker
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol
            )
          DEFAULT_2024_11_15 =
            T.let(
              :"default-2024-11-15",
              OpenAI::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::VectorStoreSearchParams::RankingOptions::Ranker::TaggedSymbol
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
