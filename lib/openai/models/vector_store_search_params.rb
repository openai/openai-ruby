# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#search
    class VectorStoreSearchParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute query
      #   A query string for a search
      #
      #   @return [String, Array<String>]
      required :query, union: -> { OpenAI::Models::VectorStoreSearchParams::Query }

      # @!attribute filters
      #   A filter to apply based on file attributes.
      #
      #   @return [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter, nil]
      optional :filters, union: -> { OpenAI::Models::VectorStoreSearchParams::Filters }

      # @!attribute max_num_results
      #   The maximum number of results to return. This number should be between 1 and 50
      #   inclusive.
      #
      #   @return [Integer, nil]
      optional :max_num_results, Integer

      # @!attribute ranking_options
      #   Ranking options for search.
      #
      #   @return [OpenAI::Models::VectorStoreSearchParams::RankingOptions, nil]
      optional :ranking_options, -> { OpenAI::Models::VectorStoreSearchParams::RankingOptions }

      # @!attribute rewrite_query
      #   Whether to rewrite the natural language query for vector search.
      #
      #   @return [Boolean, nil]
      optional :rewrite_query, OpenAI::Internal::Type::Boolean

      # @!method initialize(query:, filters: nil, max_num_results: nil, ranking_options: nil, rewrite_query: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::VectorStoreSearchParams} for more details.
      #
      #   @param query [String, Array<String>] A query string for a search
      #
      #   @param filters [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter] A filter to apply based on file attributes.
      #
      #   @param max_num_results [Integer] The maximum number of results to return. This number should be between 1 and 50
      #   ...
      #
      #   @param ranking_options [OpenAI::Models::VectorStoreSearchParams::RankingOptions] Ranking options for search.
      #
      #   @param rewrite_query [Boolean] Whether to rewrite the natural language query for vector search.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # A query string for a search
      module Query
        extend OpenAI::Internal::Type::Union

        variant String

        variant -> { OpenAI::Models::VectorStoreSearchParams::Query::StringArray }

        # @!method self.variants
        #   @return [Array(String, Array<String>)]

        # @type [OpenAI::Internal::Type::Converter]
        StringArray = OpenAI::Internal::Type::ArrayOf[String]
      end

      # A filter to apply based on file attributes.
      module Filters
        extend OpenAI::Internal::Type::Union

        # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
        variant -> { OpenAI::Models::ComparisonFilter }

        # Combine multiple filters using `and` or `or`.
        variant -> { OpenAI::Models::CompoundFilter }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter)]
      end

      class RankingOptions < OpenAI::Internal::Type::BaseModel
        # @!attribute ranker
        #
        #   @return [Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker, nil]
        optional :ranker, enum: -> { OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker }

        # @!attribute score_threshold
        #
        #   @return [Float, nil]
        optional :score_threshold, Float

        # @!method initialize(ranker: nil, score_threshold: nil)
        #   Ranking options for search.
        #
        #   @param ranker [Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker]
        #   @param score_threshold [Float]

        # @see OpenAI::Models::VectorStoreSearchParams::RankingOptions#ranker
        module Ranker
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT_2024_11_15 = :"default-2024-11-15"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
