# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#search
    class VectorStoreSearchParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute query
      #   A query string for a search
      #
      #   @return [String, Array<String>]
      required :query, union: -> { OpenAI::Models::VectorStoreSearchParams::Query }

      # @!attribute [r] filters
      #   A filter to apply based on file attributes.
      #
      #   @return [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter, nil]
      optional :filters, union: -> { OpenAI::Models::VectorStoreSearchParams::Filters }

      # @!parse
      #   # @return [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter]
      #   attr_writer :filters

      # @!attribute [r] max_num_results
      #   The maximum number of results to return. This number should be between 1 and 50
      #     inclusive.
      #
      #   @return [Integer, nil]
      optional :max_num_results, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :max_num_results

      # @!attribute [r] ranking_options
      #   Ranking options for search.
      #
      #   @return [OpenAI::Models::VectorStoreSearchParams::RankingOptions, nil]
      optional :ranking_options, -> { OpenAI::Models::VectorStoreSearchParams::RankingOptions }

      # @!parse
      #   # @return [OpenAI::Models::VectorStoreSearchParams::RankingOptions]
      #   attr_writer :ranking_options

      # @!attribute [r] rewrite_query
      #   Whether to rewrite the natural language query for vector search.
      #
      #   @return [Boolean, nil]
      optional :rewrite_query, OpenAI::BooleanModel

      # @!parse
      #   # @return [Boolean]
      #   attr_writer :rewrite_query

      # @!parse
      #   # @param query [String, Array<String>]
      #   # @param filters [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter]
      #   # @param max_num_results [Integer]
      #   # @param ranking_options [OpenAI::Models::VectorStoreSearchParams::RankingOptions]
      #   # @param rewrite_query [Boolean]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(
      #     query:,
      #     filters: nil,
      #     max_num_results: nil,
      #     ranking_options: nil,
      #     rewrite_query: nil,
      #     request_options: {},
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # A query string for a search
      module Query
        extend OpenAI::Union

        variant String

        variant -> { OpenAI::Models::VectorStoreSearchParams::Query::StringArray }

        # @!parse
        #   # @return [Array(String, Array<String>)]
        #   def self.variants; end

        StringArray = OpenAI::ArrayOf[String]
      end

      # A filter to apply based on file attributes.
      module Filters
        extend OpenAI::Union

        # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
        variant -> { OpenAI::Models::ComparisonFilter }

        # Combine multiple filters using `and` or `or`.
        variant -> { OpenAI::Models::CompoundFilter }

        # @!parse
        #   # @return [Array(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter)]
        #   def self.variants; end
      end

      class RankingOptions < OpenAI::BaseModel
        # @!attribute [r] ranker
        #
        #   @return [Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker, nil]
        optional :ranker, enum: -> { OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker]
        #   attr_writer :ranker

        # @!attribute [r] score_threshold
        #
        #   @return [Float, nil]
        optional :score_threshold, Float

        # @!parse
        #   # @return [Float]
        #   attr_writer :score_threshold

        # @!parse
        #   # Ranking options for search.
        #   #
        #   # @param ranker [Symbol, OpenAI::Models::VectorStoreSearchParams::RankingOptions::Ranker]
        #   # @param score_threshold [Float]
        #   #
        #   def initialize(ranker: nil, score_threshold: nil, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @see OpenAI::Models::VectorStoreSearchParams::RankingOptions#ranker
        module Ranker
          extend OpenAI::Enum

          AUTO = :auto
          DEFAULT_2024_11_15 = :"default-2024-11-15"

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
