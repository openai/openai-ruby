# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class FileSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the file search tool. Always `file_search`.
        #
        #   @return [Symbol, :file_search]
        required :type, const: :file_search

        # @!attribute vector_store_ids
        #   The IDs of the vector stores to search.
        #
        #   @return [Array<String>]
        required :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute [r] filters
        #   A filter to apply based on file attributes.
        #
        #   @return [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter, nil]
        optional :filters, union: -> { OpenAI::Models::Responses::FileSearchTool::Filters }

        # @!parse
        #   # @return [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter]
        #   attr_writer :filters

        # @!attribute [r] max_num_results
        #   The maximum number of results to return. This number should be between 1 and 50
        #   inclusive.
        #
        #   @return [Integer, nil]
        optional :max_num_results, Integer

        # @!parse
        #   # @return [Integer]
        #   attr_writer :max_num_results

        # @!attribute [r] ranking_options
        #   Ranking options for search.
        #
        #   @return [OpenAI::Models::Responses::FileSearchTool::RankingOptions, nil]
        optional :ranking_options, -> { OpenAI::Models::Responses::FileSearchTool::RankingOptions }

        # @!parse
        #   # @return [OpenAI::Models::Responses::FileSearchTool::RankingOptions]
        #   attr_writer :ranking_options

        # @!method initialize(vector_store_ids:, filters: nil, max_num_results: nil, ranking_options: nil, type: :file_search)
        #   A tool that searches for relevant content from uploaded files. Learn more about
        #   the
        #   [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        #
        #   @param vector_store_ids [Array<String>]
        #   @param filters [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter]
        #   @param max_num_results [Integer]
        #   @param ranking_options [OpenAI::Models::Responses::FileSearchTool::RankingOptions]
        #   @param type [Symbol, :file_search]

        # A filter to apply based on file attributes.
        #
        # @see OpenAI::Models::Responses::FileSearchTool#filters
        module Filters
          extend OpenAI::Internal::Type::Union

          # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
          variant -> { OpenAI::Models::ComparisonFilter }

          # Combine multiple filters using `and` or `or`.
          variant -> { OpenAI::Models::CompoundFilter }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter)]
        end

        # @see OpenAI::Models::Responses::FileSearchTool#ranking_options
        class RankingOptions < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] ranker
          #   The ranker to use for the file search.
          #
          #   @return [Symbol, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker, nil]
          optional :ranker, enum: -> { OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker]
          #   attr_writer :ranker

          # @!attribute [r] score_threshold
          #   The score threshold for the file search, a number between 0 and 1. Numbers
          #   closer to 1 will attempt to return only the most relevant results, but may
          #   return fewer results.
          #
          #   @return [Float, nil]
          optional :score_threshold, Float

          # @!parse
          #   # @return [Float]
          #   attr_writer :score_threshold

          # @!method initialize(ranker: nil, score_threshold: nil)
          #   Ranking options for search.
          #
          #   @param ranker [Symbol, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker]
          #   @param score_threshold [Float]

          # The ranker to use for the file search.
          #
          # @see OpenAI::Models::Responses::FileSearchTool::RankingOptions#ranker
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
end
